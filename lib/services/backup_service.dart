import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/services/backup_crypto.dart';
import 'package:sanctaconscientia/services/database_service.dart';
import 'package:share_plus/share_plus.dart';

class BackupService {
  BackupService();

  /// Preferências levadas no backup além das básicas. A senha do Exame
  /// (password_hash) fica de fora de propósito.
  static const _extraSettingKeys = [
    'confession_interval',
    'mass_guide_traditional',
    'haptics_enabled',
    'text_scale',
    'app_locale',
  ];

  /// Usado nos testes.
  @visibleForTesting
  Future<Map<String, dynamic>> collectDataForTests() => _collectData();
  @visibleForTesting
  Future<void> restoreDataForTests(Map<String, dynamic> data) => _restoreData(data);

  Future<Map<String, dynamic>> _collectData() async {
    final db = DatabaseService();
    
    // Load all data directly from DB to ensure we have everything
    final pecados = await db.loadPecados();
    final confessionHistory = await db.loadConfessionHistory();
    final activeNovenas = await db.loadActiveNovenas();
    final dailyPrayers = await db.loadDailyPrayersStatus();
    final weeklyCommitments = await db.loadWeeklyCommitmentsStatus();
    final customPrayers = await db.loadCustomPrayers();
    final prayerLogs = await db.loadPrayerLogs();
    final scheduledPrayers = await db.loadScheduledPrayers();
    final novenaHistory = await db.getSetting('novena_history');
    final massDays = await db.getSetting('mass_days');
    final intentions = await db.getSetting('prayer_intentions');
    
    // Settings
    final lastConfession = await db.getSetting('last_confession');
    final nextConfession = await db.getSetting('next_confession');
    final prayerLevel = await db.getSetting('prayer_level');
    final rosaryTraditional = await db.getSetting('rosary_traditional');
    final extraSettings = {for (final k in _extraSettingKeys) k: await db.getSetting(k)};
    final reminders = await db.loadReminders();

    // Convert complex objects to JSON-friendly format
    final novenasJson = activeNovenas.map((key, value) => MapEntry(key, {
      'startDate': value['startDate'].toIso8601String(),
      'reminderTime': value['reminderTime'],
    }));

    final confessionHistoryJson = confessionHistory.map((entry) => {
      'date': (entry['date'] as DateTime).toIso8601String(),
      'penanceNote': entry['penanceNote'],
      'penanceCompleted': entry['penanceCompleted'],
    }).toList();

    return {
      'version': 1,
      'timestamp': DateTime.now().toIso8601String(),
      'pecados': pecados,
      'confessionHistory': confessionHistoryJson,
      'activeNovenas': novenasJson,
      'dailyPrayers': dailyPrayers,
      'weeklyCommitments': weeklyCommitments,
      'customPrayers': customPrayers,
      'prayerLogs': prayerLogs,
      'scheduledPrayers': scheduledPrayers,
      'novenaHistory': novenaHistory,
      'massDays': massDays,
      'intentions': intentions,
      'reminders': reminders,
      'settings': {
        ...extraSettings,
        'last_confession': lastConfession,
        'next_confession': nextConfession,
        'prayer_level': prayerLevel,
        'rosary_traditional': rosaryTraditional,
      }
    };
  }

  /// Pergunta se o backup deve ser protegido. Retorna:
  /// null = cancelou; '' = exportar sem senha; outro texto = a senha.
  Future<String?> _askExportPassword(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final pass = TextEditingController();
    final confirm = TextEditingController();
    String? error;
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: Text(l10n.backupProtectTitle),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.backupProtectBody),
                const SizedBox(height: 12),
                TextField(
                  controller: pass,
                  obscureText: true,
                  decoration: InputDecoration(labelText: l10n.backupPasswordLabel),
                ),
                TextField(
                  controller: confirm,
                  obscureText: true,
                  decoration:
                      InputDecoration(labelText: l10n.backupPasswordConfirmLabel),
                ),
                if (error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(error!, style: const TextStyle(color: Colors.red)),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n.cancelButton),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, ''),
              child: Text(l10n.backupNoProtectAction),
            ),
            ElevatedButton(
              onPressed: () {
                if (pass.text.length < 6) {
                  setState(() => error = l10n.backupPasswordTooShort);
                } else if (pass.text != confirm.text) {
                  setState(() => error = l10n.backupPasswordMismatch);
                } else {
                  Navigator.pop(ctx, pass.text);
                }
              },
              child: Text(l10n.backupProtectAction),
            ),
          ],
        ),
      ),
    );
    pass.dispose();
    confirm.dispose();
    return result;
  }

  /// Pede a senha de um backup protegido. Retorna null se cancelado.
  Future<String?> _askImportPassword(BuildContext context, {bool wrong = false}) {
    final l10n = AppLocalizations.of(context)!;
    final pass = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.backupEnterPasswordTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.backupEnterPasswordBody),
            TextField(
              controller: pass,
              obscureText: true,
              autofocus: true,
              decoration: InputDecoration(labelText: l10n.backupPasswordLabel),
            ),
            if (wrong)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(l10n.backupWrongPassword,
                    style: const TextStyle(color: Colors.red)),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancelButton),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, pass.text),
            child: Text(l10n.backupOpenAction),
          ),
        ],
      ),
    );
  }

  Future<void> exportData(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final password = await _askExportPassword(context);
      if (password == null) return; // cancelado

      final data = await _collectData();
      var content = jsonEncode(data);
      if (password.isNotEmpty) {
        content = await BackupCrypto.encrypt(content, password);
      }

      final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      final fileName = 'backup_jardim_alma_$timestamp.json';

      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/$fileName');
      await file.writeAsString(content);

      await Share.shareXFiles(
        [XFile(file.path)],
        subject: l10n.backupShareSubject,
      );
    } catch (e) {
      debugPrint('Error exporting data: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.backupExportError)),
        );
      }
    }
  }

  Future<void> importData(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );
      if (result == null) return;

      final file = File(result.files.single.path!);
      var json = jsonDecode(await file.readAsString()) as Map<String, dynamic>;

      if (BackupCrypto.isEncrypted(json)) {
        Map<String, dynamic>? decrypted;
        var wrong = false;
        while (decrypted == null) {
          if (!context.mounted) return;
          final password = await _askImportPassword(context, wrong: wrong);
          if (password == null) return; // cancelado
          try {
            decrypted = jsonDecode(await BackupCrypto.decrypt(json, password))
                as Map<String, dynamic>;
          } on BackupWrongPasswordException {
            wrong = true;
          }
        }
        json = decrypted;
      }

      await _restoreData(json);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.backupImportSuccess)),
        );
      }
    } catch (e) {
      debugPrint('Error importing data: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.backupImportError)),
        );
      }
    }
  }

  Future<void> _restoreData(Map<String, dynamic> data) async {
    final db = DatabaseService();
    
    // Clear existing data? Or merge? 
    // Usually restore implies overwriting or at least adding.
    // For safety, let's overwrite specific tables but maybe keep some things?
    // User requested "backup system", usually implies full restore.
    
    // 1. Pecados
    if (data['pecados'] != null) {
      await db.clearPecados();
      final pecados = Map<String, int>.from(data['pecados']);
      for (var entry in pecados.entries) {
        await db.updatePecado(entry.key, entry.value);
      }
    }

    // 2. Confession History (ignora datas que já existem)
    if (data['confessionHistory'] != null) {
      final existing = (await db.loadConfessionHistory())
          .map((e) => (e['date'] as DateTime).toIso8601String())
          .toSet();
      final entries = (data['confessionHistory'] as List).cast<Map<String, dynamic>>();
      for (final entry in entries) {
        final date = DateTime.parse(entry['date'] as String);
        if (existing.contains(date.toIso8601String())) continue;
        await db.addConfession(date, penanceNote: entry['penanceNote'] as String?);
        if (entry['penanceCompleted'] == true) {
          final saved = (await db.loadConfessionHistory())
              .firstWhere((e) => (e['date'] as DateTime) == date);
          await db.updatePenanceCompleted(saved['id'] as int, true);
        }
      }
    }

    // 3. Active Novenas
    if (data['activeNovenas'] != null) {
      final novenas = data['activeNovenas'] as Map<String, dynamic>;
      for (var entry in novenas.entries) {
        final val = entry.value;
        await db.saveActiveNovena(
          entry.key, 
          DateTime.parse(val['startDate']),
          reminderTime: val['reminderTime'],
        );
      }
    }

    // 4. Daily Prayers
    if (data['dailyPrayers'] != null) {
      final daily = data['dailyPrayers'] as Map<String, dynamic>;
      for (var entry in daily.entries) {
        final parts = entry.key.split('_');
        if (parts.length >= 2) {
          final date = parts[0];
          final id = parts.sublist(1).join('_');
          await db.updateDailyPrayerStatus(date, id, entry.value);
        }
      }
    }

    // 5. Weekly Commitments
    if (data['weeklyCommitments'] != null) {
      final weekly = data['weeklyCommitments'] as Map<String, dynamic>;
      for (var entry in weekly.entries) {
        final parts = entry.key.split('_');
        if (parts.length >= 2) {
          final date = parts[0];
          final id = parts.sublist(1).join('_');
          await db.updateWeeklyCommitmentStatus(date, id, entry.value);
        }
      }
    }

    // 6. Custom Prayers
    if (data['customPrayers'] != null) {
      final prayers = (data['customPrayers'] as List).cast<Map<String, dynamic>>();
      for (var p in prayers) {
        await db.saveCustomPrayer(Map<String, String>.from(p));
      }
    }

    // 7. Prayer Logs
    if (data['prayerLogs'] != null) {
      final logs = (data['prayerLogs'] as List).cast<Map<String, dynamic>>();
      for (var l in logs) {
        await db.addPrayerLog(Map<String, String>.from(l));
      }
    }

    // 8. Scheduled Prayers
    if (data['scheduledPrayers'] != null) {
      final scheduled = (data['scheduledPrayers'] as List).cast<Map<String, dynamic>>();
      for (var s in scheduled) {
        await db.saveScheduledPrayer(Map<String, String>.from(s));
      }
    }

    // 8b. Histórico de novenas concluídas (une com o que já existe)
    if (data['novenaHistory'] is String) {
      final incoming = (jsonDecode(data['novenaHistory'] as String) as Map<String, dynamic>);
      final currentRaw = await db.getSetting('novena_history');
      final merged = currentRaw == null || currentRaw.isEmpty
          ? <String, dynamic>{}
          : Map<String, dynamic>.from(jsonDecode(currentRaw) as Map);
      incoming.forEach((id, runs) {
        final set = <String>{
          ...((merged[id] as List?)?.cast<String>() ?? const <String>[]),
          ...(runs as List).cast<String>(),
        };
        merged[id] = set.toList();
      });
      await db.saveSetting('novena_history', jsonEncode(merged));
    }

    // 8c. Dias de missa (une com o que já existe)
    if (data['massDays'] is String) {
      final merged = <String>{
        ...PrayerProvider.decodeMassDays(await db.getSetting('mass_days')),
        ...PrayerProvider.decodeMassDays(data['massDays'] as String),
      };
      await db.saveSetting('mass_days', jsonEncode(merged.toList()..sort()));
    }

    // 8d. Intenções de oração (une por id; uma graça recebida não volta a "em oração")
    if (data['intentions'] is String) {
      final byId = <String, Map<String, dynamic>>{
        for (final i in PrayerProvider.decodeIntentions(await db.getSetting('prayer_intentions'))) i['id'] as String: i,
      };
      for (final i in PrayerProvider.decodeIntentions(data['intentions'] as String)) {
        final id = i['id'] as String;
        final current = byId[id];
        byId[id] = current == null
            ? i
            : {...current, 'answered': current['answered'] == true || i['answered'] == true};
      }
      await db.saveSetting('prayer_intentions', jsonEncode(byId.values.toList()));
    }

    // 9. Settings
    if (data['settings'] != null) {
      final settings = data['settings'] as Map<String, dynamic>;
      if (settings['last_confession'] != null) await db.saveSetting('last_confession', settings['last_confession']);
      if (settings['next_confession'] != null) await db.saveSetting('next_confession', settings['next_confession']);
      if (settings['prayer_level'] != null) await db.saveSetting('prayer_level', settings['prayer_level']);
      if (settings['rosary_traditional'] != null) await db.saveSetting('rosary_traditional', settings['rosary_traditional']);
      for (final k in _extraSettingKeys) {
        if (settings[k] is String) await db.saveSetting(k, settings[k] as String);
      }
    }

    // 10. Lembretes (substitui pelo mesmo id; quem chama deve reagendar as notificações)
    if (data['reminders'] is List) {
      for (final r in (data['reminders'] as List).whereType<Map>()) {
        if (r['id'] is! String) continue;
        await db.saveReminderJson(Map<String, dynamic>.from(r));
      }
    }
  }
}
