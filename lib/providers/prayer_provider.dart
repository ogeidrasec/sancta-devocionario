import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sanctaconscientia/services/database_service.dart';
import 'package:sanctaconscientia/services/notification_service.dart';
import 'package:sanctaconscientia/utils/notification_strings.dart';
import 'package:sanctaconscientia/services/reminder_service.dart';
import 'package:sanctaconscientia/models/reminder_model.dart';
import 'package:intl/intl.dart';

class PrayerProvider extends ChangeNotifier {
  Map<String, Map<String, dynamic>> _activeNovenas = {};

  /// Novenas já concluídas: id -> datas de início de cada vez que foi rezada.
  /// Uma novena concluída não "expira": pode ser rezada quantas vezes quiser.
  Map<String, List<DateTime>> _novenaHistory = {};
  Map<String, int> _dailyPrayers = {};
  Map<String, int> _weeklyCommitments = {};
  List<Map<String, String>> _availablePrayers = [];
  List<Map<String, String>> _prayerLogs = [];
  List<Map<String, String>> _scheduledPrayers = [];
  
  // Dependencies
  final ReminderService _reminderService;

  PrayerProvider({ReminderService? reminderService}) 
      : _reminderService = reminderService ?? ReminderService(
          databaseService: DatabaseService(),
          notificationService: NotificationService(),
        );

  Map<String, Map<String, dynamic>> get activeNovenas => _activeNovenas;
  Map<String, List<DateTime>> get novenaHistory => _novenaHistory;
  Map<String, int> get dailyPrayers => _dailyPrayers;
  Map<String, int> get weeklyCommitments => _weeklyCommitments;
  List<Map<String, String>> get availablePrayers => _availablePrayers;
  List<Map<String, String>> get prayerLogs => _prayerLogs;
  List<Map<String, String>> get scheduledPrayers => _scheduledPrayers;

  Future<void> loadData() async {
    final dbService = DatabaseService();
    
    _activeNovenas = await dbService.loadActiveNovenas();
    _dailyPrayers = await dbService.loadDailyPrayersStatus();
    _weeklyCommitments = await dbService.loadWeeklyCommitmentsStatus();
    _availablePrayers = await dbService.loadCustomPrayers();
    _prayerLogs = await dbService.loadPrayerLogs();
    _scheduledPrayers = await dbService.loadScheduledPrayers();
    _novenaHistory = _decodeNovenaHistory(await dbService.getSetting('novena_history'));
    _massDays = decodeMassDays(await dbService.getSetting('mass_days'));
    _intentions = decodeIntentions(await dbService.getSetting('prayer_intentions'));

    // Initialize default prayers if needed
    final appInitialized = await dbService.getSetting('app_initialized');
    if (_availablePrayers.isEmpty && appInitialized == null) {
      _availablePrayers = [
        {'id': 'morningOffering', 'title': 'Oferecimento do Dia', 'defaultTime': 'morning'},
        {'id': 'angelus', 'title': 'Angelus / Regina Caeli', 'defaultTime': 'noon'},
        {'id': 'rosary', 'title': 'Santo Terço', 'defaultTime': 'anytime'},
        {'id': 'daily_examination', 'title': 'Exame Diário', 'defaultTime': 'night'},
        {'id': 'nightPrayer', 'title': 'Oração da Noite', 'defaultTime': 'night'},
      ];
      for (var p in _availablePrayers) {
        await dbService.saveCustomPrayer(p);
      }
      await dbService.saveSetting('app_initialized', 'true');
    } else if (appInitialized == null && _availablePrayers.isNotEmpty) {
       await dbService.saveSetting('app_initialized', 'true');
    }
    
    await archiveFinishedNovenas();
    notifyListeners();
  }

  /// Move as novenas que passaram do 9º dia para o histórico.
  /// Chamada ao abrir o app, ao voltar do segundo plano e ao iniciar uma novena.
  Future<void> archiveFinishedNovenas() async {
    final finished = _activeNovenas.keys
        .where((id) => getNovenaDay(id) > 9)
        .toList();
    if (finished.isEmpty) return;

    final db = DatabaseService();
    for (final id in finished) {
      final start = _activeNovenas[id]!['startDate'] as DateTime;
      final runs = _novenaHistory.putIfAbsent(id, () => []);
      if (!runs.any((d) => _sameDay(d, start))) runs.add(start);
      _activeNovenas.remove(id);
      await db.removeActiveNovena(id);
      await _reminderService.deleteReminder('novena_$id');
    }
    await db.saveSetting('novena_history', _encodeNovenaHistory(_novenaHistory));
    notifyListeners();
  }

  static bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  static String _encodeNovenaHistory(Map<String, List<DateTime>> h) => jsonEncode(
        h.map((k, v) => MapEntry(k, v.map((d) => d.toIso8601String()).toList())),
      );

  static Map<String, List<DateTime>> _decodeNovenaHistory(String? raw) {
    if (raw == null || raw.isEmpty) return {};
    try {
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      return decoded.map((k, v) => MapEntry(
            k,
            (v as List).map((e) => DateTime.parse(e as String)).toList(),
          ));
    } catch (_) {
      return {};
    }
  }

  // ---------------- Intenções de oração ----------------

  /// Cada intenção: {id, text, created (ISO), answered (bool)}.
  List<Map<String, dynamic>> _intentions = [];

  List<Map<String, dynamic>> get intentions => List.unmodifiable(_intentions);

  static List<Map<String, dynamic>> decodeIntentions(String? raw) {
    if (raw == null || raw.isEmpty) return [];
    try {
      return (jsonDecode(raw) as List)
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .where((e) => e['id'] is String && e['text'] is String)
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> _saveIntentions() async {
    // mais recentes primeiro
    _intentions.sort((a, b) => (b['created'] as String? ?? '').compareTo(a['created'] as String? ?? ''));
    await DatabaseService().saveSetting('prayer_intentions', jsonEncode(_intentions));
    notifyListeners();
  }

  Future<void> addIntention(String text) async {
    final now = DateTime.now();
    _intentions.add({
      'id': now.microsecondsSinceEpoch.toString(),
      'text': text.trim(),
      'created': now.toIso8601String(),
      'answered': false,
    });
    await _saveIntentions();
  }

  Future<void> updateIntention(String id, String text) async {
    final i = _intentions.indexWhere((e) => e['id'] == id);
    if (i < 0) return;
    _intentions[i] = {..._intentions[i], 'text': text.trim()};
    await _saveIntentions();
  }

  Future<void> toggleIntentionAnswered(String id) async {
    final i = _intentions.indexWhere((e) => e['id'] == id);
    if (i < 0) return;
    _intentions[i] = {..._intentions[i], 'answered': _intentions[i]['answered'] != true};
    await _saveIntentions();
  }

  Future<void> deleteIntention(String id) async {
    _intentions.removeWhere((e) => e['id'] == id);
    await _saveIntentions();
  }

  /// Desfaz uma exclusão (usada pelo "Desfazer").
  Future<void> restoreIntention(Map<String, dynamic> item) async {
    if (_intentions.any((e) => e['id'] == item['id'])) return;
    _intentions.add(Map<String, dynamic>.from(item));
    await _saveIntentions();
  }

  // ---------------- Missa ----------------

  /// Dias em que o usuário foi à missa (chave yyyy-MM-dd).
  Set<String> _massDays = {};

  static String massKey(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  static Set<String> decodeMassDays(String? raw) {
    if (raw == null || raw.isEmpty) return {};
    try {
      return (jsonDecode(raw) as List).cast<String>().toSet();
    } catch (_) {
      return {};
    }
  }

  bool hasMassOn(DateTime date) => _massDays.contains(massKey(date));

  /// Dias de missa registrados (sem hora).
  List<DateTime> get massDates =>
      _massDays.map(DateTime.tryParse).whereType<DateTime>().toList();

  int massCountInMonth(DateTime month) =>
      massDates.where((d) => d.year == month.year && d.month == month.month).length;

  /// Domingos seguidos com missa, contando para trás a partir do domingo mais
  /// recente. O domingo de hoje ainda sem registro não quebra a contagem.
  int get sundayMassStreak {
    final now = DateTime.now();
    var s = DateTime(now.year, now.month, now.day).subtract(Duration(days: now.weekday % 7));
    if (!hasMassOn(s) && _sameDay(s, now)) s = s.subtract(const Duration(days: 7));
    var count = 0;
    while (hasMassOn(s)) {
      count++;
      s = s.subtract(const Duration(days: 7));
    }
    return count;
  }

  /// Marca ou desmarca a missa do dia. Retorna se o dia ficou marcado.
  Future<bool> toggleMass(DateTime date) async {
    final key = massKey(date);
    final marked = _massDays.add(key);
    if (!marked) _massDays.remove(key);
    await DatabaseService().saveSetting('mass_days', jsonEncode(_massDays.toList()..sort()));
    notifyListeners();
    return marked;
  }

  /// Chamado quando o app volta ao primeiro plano: arquiva novenas concluídas
  /// e força a atualização das telas (ex.: virada do dia com o app aberto).
  Future<void> onAppResumed() async {
    await archiveFinishedNovenas();
    notifyListeners();
  }

  /// Quantas vezes a novena já foi concluída.
  int novenaTimesCompleted(String novenaId) => _novenaHistory[novenaId]?.length ?? 0;

  /// Data em que a novena foi concluída pela última vez (9º dia).
  DateTime? lastNovenaCompletion(String novenaId) {
    final runs = _novenaHistory[novenaId];
    if (runs == null || runs.isEmpty) return null;
    final latest = runs.reduce((a, b) => a.isAfter(b) ? a : b);
    return DateTime(latest.year, latest.month, latest.day).add(const Duration(days: 8));
  }

  /// Verdadeiro nos primeiros dias após concluir (usado para um destaque
  /// temporário; depois disso a novena volta ao estado normal).
  bool novenaRecentlyCompleted(String novenaId, {int withinDays = 3}) {
    final last = lastNovenaCompletion(novenaId);
    if (last == null) return false;
    final today = DateTime.now();
    final diff = DateTime(today.year, today.month, today.day).difference(last).inDays;
    return diff >= 0 && diff < withinDays;
  }

  // =====================
  // Prayer Management
  // =====================

  Future<String> addPrayer(String title, {String? prayerId, String? prayerType, String? time}) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final id = prayerId != null ? '${prayerId}_$timestamp' : 'custom_$timestamp';
    
    final prayer = {'id': id, 'title': title};
    if (prayerId != null) prayer['prayerId'] = prayerId;
    if (prayerType != null) prayer['prayerType'] = prayerType;
    if (time != null) prayer['defaultTime'] = time;
    
    _availablePrayers.add(prayer);
    await DatabaseService().saveCustomPrayer(prayer);
    notifyListeners();
    
    return id;
  }

  Future<void> removePrayer(String id) async {
    _availablePrayers.removeWhere((p) => p['id'] == id);
    await DatabaseService().deleteCustomPrayer(id);
    
    // Deletar reminder associado (tenta ambos os formatos de ID)
    final prayerReminderId = 'prayer_$id';
    await _reminderService.deleteReminder(prayerReminderId);
    
    // Também tentar formato de novena se aplicável
    if (id.startsWith('novena')) {
      await _reminderService.deleteReminder('novena_$id');
    }
    
    notifyListeners();
  }

  Future<void> updatePrayerTime(String id, String newTime) async {
    final index = _availablePrayers.indexWhere((p) => p['id'] == id);
    if (index != -1) {
      _availablePrayers[index]['defaultTime'] = newTime;
      await DatabaseService().saveCustomPrayer(_availablePrayers[index]);
      notifyListeners();
    }
  }

  Future<void> setPrayerReminder(String id, TimeOfDay? time, {String frequency = 'daily', DateTime? date, String? title}) async {
    final index = _availablePrayers.indexWhere((p) => p['id'] == id);
    if (index != -1) {
      final prayer = _availablePrayers[index];
      // notificationId agora é gerado pelo scheduleNotifications() no ReminderService

      if (time != null) {
        // Special handling for Novenas
        if (id.startsWith('novena_') || (prayer['id']?.startsWith('novena_') ?? false)) {
          // It's a novena, we must ensure it follows the 9-day rule
          // We need the start date to calculate correct occurrences
          // Try to get from active novenas first
          final novenaId = id; // The ID usually IS the novena ID in availablePrayers for novenas
          final activeNovena = _activeNovenas[novenaId];
          
          DateTime startDate;
          if (activeNovena != null) {
            startDate = activeNovena['startDate'] as DateTime;
          } else {
             // Fallback: if not active, assume starting today or use passed date
             startDate = date ?? DateTime.now();
          }

          final prayerTitle = title ?? (prayer['title'] as String);
          
          final novenaReminder = ReminderModel(
            id: 'novena_$id', // Use consistent ID format for novenas
            title: prayerTitle, // Use provided (localized) title
            description: 'Reze durante 9 dias consecutivos',
            type: ReminderType.novena,
            times: [time],
            recurrence: RecurrenceType.daily,
            startDate: startDate,
            maxOccurrences: 9, 
            createdAt: DateTime.now(),
            novenaId: id,
            // Não pré-gerar notificationIds: scheduleNotifications() gera os corretos
          );
          
          await _reminderService.createOrUpdateUnifiedReminder(novenaReminder);
          
        } else {
          // Standard prayer reminder logic
          final recurrence = frequency == 'daily' 
              ? RecurrenceType.daily
              : (frequency == 'weekly' || frequency == 'biweekly')
                  ? RecurrenceType.weekly
                  : frequency == 'monthly'
                      ? RecurrenceType.monthly
                      : RecurrenceType.once;

          final interval = frequency == 'biweekly' ? 2 : 1;
          
          final prayerTitle = title ?? (prayer['title'] as String);
          
          final prayerReminder = ReminderModel(
            id: 'prayer_$id',
            title: prayerTitle,
            type: id.contains('rosary') ? ReminderType.rosary
                  : id.contains('examination') || id.contains('exame') ? ReminderType.examination
                  : ReminderType.prayer,
            times: [time],
            recurrence: recurrence,
            interval: interval,
            startDate: date ?? (() {
              final now = DateTime.now();
              var start = now;
              // Se for apenas uma vez e a hora já passou hoje, agenda para amanhã
              if (recurrence == RecurrenceType.once) {
                final scheduledToday = DateTime(now.year, now.month, now.day, time.hour, time.minute);
                if (scheduledToday.isBefore(now)) {
                  start = now.add(const Duration(days: 1));
                }
              }
              return start;
            })(),
            weekDays: recurrence == RecurrenceType.weekly ? [date?.weekday ?? DateTime.now().weekday] : null,
            monthDay: recurrence == RecurrenceType.monthly ? (date?.day ?? DateTime.now().day) : null,
            createdAt: DateTime.now(),
            prayerId: id,
            notificationIds: const [],
          );
          
          await _reminderService.createOrUpdateUnifiedReminder(prayerReminder);
        }

      } else {
        final reminderId = 'prayer_$id';
        await _reminderService.deleteReminder(reminderId);
        
        // Also try deleting novena reminder format if it exists
        if (id.startsWith('novena_')) {
           await _reminderService.deleteReminder('novena_$id');
        }
      }
      
      notifyListeners();
    }
  }

  // =====================
  // Novena Methods
  // =====================

  Future<void> startNovena(String novenaId, {DateTime? startDate, TimeOfDay? reminderTime, String? title}) async {
    final now = DateTime.now();
    final start = startDate != null 
        ? DateTime(startDate.year, startDate.month, startDate.day)
        : DateTime(now.year, now.month, now.day);

    _activeNovenas[novenaId] = {
      'startDate': start,
    };
    
    await DatabaseService().saveActiveNovena(novenaId, start);
    
    if (reminderTime != null) {
      // baseId agora é gerado pelo scheduleNotifications() no ReminderService
      // Use the provided title or fallback to the hardcoded one (as a safety net)
      final displayTitle = title ?? await NotificationStrings.getNovenaReminderTitle();
      
      final novenaReminder = ReminderModel(
        id: 'novena_$novenaId',
        title: displayTitle,
        description: 'Reze durante 9 dias consecutivos',
        type: ReminderType.novena,
        times: [reminderTime],
        recurrence: RecurrenceType.daily,
        startDate: start,
        maxOccurrences: 9,
        createdAt: DateTime.now(),
        novenaId: novenaId,
        // Não pré-gerar notificationIds: scheduleNotifications() gera os corretos
      );
      
      await _reminderService.createOrUpdateUnifiedReminder(novenaReminder);
    }

    notifyListeners();
  }
  
  Future<void> cancelNovena(String novenaId) async {
    _activeNovenas.remove(novenaId);
    await DatabaseService().removeActiveNovena(novenaId);
    
    final reminderId = 'novena_$novenaId';
    await _reminderService.deleteReminder(reminderId);
    
    notifyListeners();
  }

  int getNovenaDay(String novenaId) {
    final data = _activeNovenas[novenaId];
    if (data == null) return 0;
    
    final startDate = data['startDate'] as DateTime;
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day);
    final startOfStartDate = DateTime(startDate.year, startDate.month, startDate.day);
    final daysDiff = startOfToday.difference(startOfStartDate).inDays;
    return daysDiff + 1; 
  }

  bool isNovenaActive(String novenaId) {
    final day = getNovenaDay(novenaId);
    return day >= 1 && day <= 9;
  }

  bool isNovenaCompleted(String novenaId) {
    final day = getNovenaDay(novenaId);
    return day > 9;
  }

  DateTime? getNovenaStartDate(String novenaId) {
    final data = _activeNovenas[novenaId];
    if (data == null) return null;
    return data['startDate'] as DateTime;
  }
  
  String? getNovenaReminderTime(String novenaId) {
    final reminder = _reminderService.getReminderById('novena_$novenaId');
    if (reminder != null && reminder.times.isNotEmpty) {
      final t = reminder.times.first;
      return '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
    }
    return null;
  }

  List<Map<String, dynamic>> getNovenasForDate(DateTime date) {
    final List<Map<String, dynamic>> novenas = [];
    final checkDate = DateTime(date.year, date.month, date.day);

    void consider(String id, DateTime startDate) {
      final start = DateTime(startDate.year, startDate.month, startDate.day);
      final end = start.add(const Duration(days: 8));
      if (!checkDate.isBefore(start) && !checkDate.isAfter(end)) {
        novenas.add({
          'id': id,
          'day': checkDate.difference(start).inDays + 1,
          'startDate': startDate,
        });
      }
    }

    _activeNovenas.forEach((id, data) => consider(id, data['startDate'] as DateTime));
    // Novenas já concluídas continuam marcadas no jardim nos dias em que foram rezadas.
    _novenaHistory.forEach((id, runs) {
      for (final run in runs) {
        consider(id, run);
      }
    });

    return novenas;
  }

  /// Se o dia [day] (1 a 9) da novena já foi rezado em alguma data.
  bool isNovenaDayDone(String novenaId, int day) {
    final suffix = '_${novenaId}_day_$day';
    return _dailyPrayers.entries.any((e) => e.value == 1 && e.key.endsWith(suffix));
  }

  /// Marca (de forma idempotente) uma oração como feita hoje.
  /// Diferente de [toggleDailyPrayer], rezar de novo no mesmo dia não desfaz.
  Future<void> markPrayerDoneToday(String prayerId, String title) async {
    final dateKey = DateFormat('yyyyMMdd').format(DateTime.now());
    if (!isDailyPrayerCompleted(dateKey, prayerId)) {
      await toggleDailyPrayer(dateKey, prayerId, title: title);
    }
  }

  // =====================
  // Daily & Weekly Status
  // =====================

  Future<void> toggleDailyPrayer(String date, String prayerId, {String? title}) async {
    final key = '${date}_$prayerId';
    final currentStatus = _dailyPrayers[key] ?? 0;
    final newStatus = currentStatus == 0 ? 1 : 0;
    _dailyPrayers[key] = newStatus;
    
    await DatabaseService().updateDailyPrayerStatus(date, prayerId, newStatus);
    
    if (newStatus == 1 && title != null) {
      final timestamp = DateTime.now();
      final log = {
        'title': title,
        'timestamp': timestamp.toIso8601String(),
        'prayerId': prayerId,
        'dateKey': date,
      };
      _prayerLogs.add(log);
      await DatabaseService().addPrayerLog(log);
    } else if (newStatus == 0) {
      _prayerLogs.removeWhere((log) {
        if (log['prayerId'] != prayerId) return false;
        if (log['dateKey'] == date) return true;
        final timestamp = log['timestamp'];
        if (timestamp != null) {
          final logDate = DateTime.parse(timestamp);
          final logDateKey = '${logDate.year}${logDate.month.toString().padLeft(2, '0')}${logDate.day.toString().padLeft(2, '0')}';
          return logDateKey == date;
        }
        return false;
      });
      await DatabaseService().deletePrayerLogByDateAndId(date, prayerId);
    }

    // Marcar/desmarcar o terço no check também conta (ou desconta) no Rosário do dia
    if (_rosaryPlanId.hasMatch(prayerId)) {
      await _syncCompleteRosaryLogs(date, DateTime.now());
    }

    notifyListeners();
  }

  Future<void> completePrayerByTitle(String title, String fallbackId) async {
    final now = DateTime.now();
    final timeSlot = _getTimeSlot(now);
    final dateKey = DateFormat('yyyyMMdd').format(now);
    
    // Find if there is a specific prayer scheduled for this time slot with the same title
    // or if the fallbackId matches the current time slot
    String targetId = fallbackId;
    
    final matchingPrayer = _availablePrayers.firstWhere(
      (p) =>
          p['defaultTime'] == timeSlot &&
          (p['title'] == title || (p['prayerId'] ?? p['id']) == fallbackId),
      orElse: () => {},
    );

    if (matchingPrayer.isNotEmpty) {
      targetId = matchingPrayer['id']!;
    }

    // Only toggle if not already completed
    if (!isDailyPrayerCompleted(dateKey, targetId)) {
      await toggleDailyPrayer(dateKey, targetId, title: title);
    }
  }

  String _getTimeSlot(DateTime time) {
    final hour = time.hour;
    if (hour >= 5 && hour < 12) {
      return 'morning';
    } else if (hour >= 12 && hour < 18) {
      return 'noon';
    } else {
      return 'night';
    }
  }
  
  Future<void> removePrayerLogAndUncheck(Map<String, String> log) async {
    var dateKey = log['dateKey'];
    final prayerId = log['prayerId'];
    
    if (dateKey == null && log['timestamp'] != null) {
      final date = DateTime.parse(log['timestamp']!);
      dateKey = DateFormat('yyyyMMdd').format(date);
    }
    
    _prayerLogs.remove(log);
    await DatabaseService().deletePrayerLog(log['timestamp'] ?? '', log['title'] ?? '');
    
    if (dateKey != null && prayerId != null) {
      final key = '${dateKey}_$prayerId';
      if (_dailyPrayers.containsKey(key)) {
        _dailyPrayers[key] = 0;
        await DatabaseService().updateDailyPrayerStatus(dateKey, prayerId, 0);
      }
    }

    // Apagar um terço também desfaz o "Rosário completo" do dia, se for o caso
    if (prayerId != null && rosaryMysteryIds.contains(prayerId) && dateKey != null) {
      await _syncCompleteRosaryLogs(dateKey, DateTime.tryParse(log['timestamp'] ?? '') ?? DateTime.now());
    }

    notifyListeners();
  }

  bool isDailyPrayerCompleted(String date, String prayerId) {
    final key = '${date}_$prayerId';
    return (_dailyPrayers[key] ?? 0) == 1;
  }

  Future<void> toggleWeeklyCommitment(String date, String commitmentId) async {
    final key = '${date}_$commitmentId';
    final currentStatus = _weeklyCommitments[key] ?? 0;
    final newStatus = currentStatus == 0 ? 1 : 0;
    _weeklyCommitments[key] = newStatus;
    
    await DatabaseService().updateWeeklyCommitmentStatus(date, commitmentId, newStatus);
    notifyListeners();
  }

  bool isWeeklyCommitmentCompleted(String date, String commitmentId) {
    final key = '${date}_$commitmentId';
    return (_weeklyCommitments[key] ?? 0) == 1;
  }

  // =====================
  // Prayer Logs & Schedule
  // =====================

  Future<void> logPrayer(String title, DateTime timestamp, {String? prayerId, String? prayerType}) async {
    final dateKey = DateFormat('yyyyMMdd').format(timestamp);
    final log = {
      'title': title,
      'timestamp': timestamp.toIso8601String(),
      'dateKey': dateKey,
    };
    if (prayerId != null) log['prayerId'] = prayerId;
    if (prayerType != null) log['prayerType'] = prayerType;

    _prayerLogs.add(log);
    
    if (prayerId != null) {
      final key = '${dateKey}_$prayerId';
      _dailyPrayers[key] = 1;
      await DatabaseService().updateDailyPrayerStatus(dateKey, prayerId, 1);
    }
    
    await DatabaseService().addPrayerLog(log);
    
    if (prayerId != null && rosaryMysteryIds.contains(prayerId)) {
      await _syncCompleteRosaryLogs(dateKey, timestamp);
    }
    
    notifyListeners();
  }

  // ---------------- Terço × Rosário ----------------
  // Um terço são 5 dezenas. O Rosário completo reúne todos os mistérios:
  // 3 terços no modo tradicional (gozosos, dolorosos e gloriosos) ou 4 no
  // modo atual (com os luminosos). Conta-se por dia.

  static const rosaryMysteryIds = {'rosary_joyful', 'rosary_sorrowful', 'rosary_glorious', 'rosary_luminous'};

  /// Quantos terços formam um Rosário (3 no modo tradicional, 4 no atual).
  static int chapletsPerRosary({required bool traditional}) => traditional ? 3 : 4;

  Future<int> _chapletsPerRosaryFromSettings() async {
    final traditional = (await DatabaseService().getSetting('rosary_traditional')) != 'false';
    return chapletsPerRosary(traditional: traditional);
  }

  /// O terço do plano ('rosary' ou uma cópia 'rosary_<número>'), marcado no check.
  static final _rosaryPlanId = RegExp(r'^rosary(_\d{10,})?$');

  /// Terços completos rezados em um dia. Marcar o terço do plano no check conta
  /// como um terço; rezar pela página do terço grava o mistério e também marca o
  /// plano, por isso vale o maior dos dois números (sem contar em dobro).
  int chapletsOn(DateTime date) => _chapletsOnKey(DateFormat('yyyyMMdd').format(date));

  int _chapletsOnKey(String key) {
    final dayLogs = _prayerLogs.where((l) => l['dateKey'] == key);
    final mysteries = dayLogs.where((l) => rosaryMysteryIds.contains(l['prayerId'])).length;
    final planned = dayLogs.where((l) => _rosaryPlanId.hasMatch(l['prayerId'] ?? '')).length;
    return mysteries > planned ? mysteries : planned;
  }

  int get chapletsToday => chapletsOn(DateTime.now());

  /// Mantém um registro "Rosário completo" para cada grupo de terços do dia
  /// (e remove os que sobrarem se um terço for apagado).
  Future<void> _syncCompleteRosaryLogs(String dateKey, DateTime timestamp) async {
    final per = await _chapletsPerRosaryFromSettings();
    final chaplets = _chapletsOnKey(dateKey);
    final shouldHave = chaplets ~/ per;
    final complete = _prayerLogs
        .where((l) => l['dateKey'] == dateKey && l['prayerId'] == 'rosary_complete')
        .toList();

    while (complete.length < shouldHave) {
      final rosaryLog = {
        'title': await NotificationStrings.rosaryCompleteLog(per),
        // milissegundos diferentes: o banco identifica o registro pelo horário
        'timestamp': timestamp.add(Duration(milliseconds: complete.length + 1)).toIso8601String(),
        'dateKey': dateKey,
        'prayerId': 'rosary_complete',
        'prayerType': 'rosary',
      };
      _prayerLogs.add(rosaryLog);
      await DatabaseService().addPrayerLog(rosaryLog);
      complete.add(rosaryLog);
    }
    while (complete.length > shouldHave) {
      final extra = complete.removeLast();
      _prayerLogs.remove(extra);
      await DatabaseService().deletePrayerLog(extra['timestamp'] ?? '', extra['title'] ?? '');
    }
  }

  Future<void> deletePrayerLog(Map<String, String> log) async {
    _prayerLogs.remove(log);
    await DatabaseService().deletePrayerLog(log['timestamp'] ?? '', log['title'] ?? '');
    // Apagar um terço pode desfazer o "Rosário completo" do dia
    if (rosaryMysteryIds.contains(log['prayerId']) && log['dateKey'] != null) {
      await _syncCompleteRosaryLogs(log['dateKey']!, DateTime.tryParse(log['timestamp'] ?? '') ?? DateTime.now());
    }
    notifyListeners();
  }

  Future<void> schedulePrayer(String title, DateTime scheduledTime, {String? prayerId, String? prayerType}) async {
    final notificationId = DateTime.now().millisecondsSinceEpoch % 2147483647;
    final id = 'scheduled_${DateTime.now().millisecondsSinceEpoch}';
    
    final scheduled = {
      'id': id,
      'title': title,
      'timestamp': scheduledTime.toIso8601String(),
      'notificationId': notificationId.toString(),
    };
    if (prayerId != null) scheduled['prayerId'] = prayerId;
    if (prayerType != null) scheduled['prayerType'] = prayerType;

    _scheduledPrayers.add(scheduled);
    await DatabaseService().saveScheduledPrayer(scheduled);
    
    final reminder = ReminderModel(
      id: id,
      title: await NotificationStrings.getPrayerReminderTitle(),
      description: title,
      type: ReminderType.prayer,
      times: [TimeOfDay.fromDateTime(scheduledTime)],
      recurrence: RecurrenceType.once,
      startDate: scheduledTime,
      createdAt: DateTime.now(),
      prayerId: prayerId ?? id,
    );
    await _reminderService.createOrUpdateUnifiedReminder(reminder);
    
    notifyListeners();
  }

  Future<void> completeScheduledPrayer(String id) async {
    final index = _scheduledPrayers.indexWhere((p) => p['id'] == id);
    if (index != -1) {
      final prayer = _scheduledPrayers[index];
      
      await _reminderService.deleteReminder(id);

      _scheduledPrayers.removeAt(index);
      
      await logPrayer(
        prayer['title']!, 
        DateTime.now(),
        prayerId: prayer['prayerId'],
        prayerType: prayer['prayerType'],
      );

      await DatabaseService().deleteScheduledPrayer(id);
      notifyListeners();
    }
  }

  Future<void> deleteScheduledPrayer(String id) async {
    final index = _scheduledPrayers.indexWhere((p) => p['id'] == id);
    if (index != -1) {
      await _reminderService.deleteReminder(id);

      _scheduledPrayers.removeAt(index);
      await DatabaseService().deleteScheduledPrayer(id);
      notifyListeners();
    }
  }

  int getWeeklyPrayerCount() {
    final now = DateTime.now();
    final startOfWeek = DateTime(now.year, now.month, now.day).subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 7));

    int count = 0;
    final Set<String> countedKeys = {};

    _dailyPrayers.forEach((key, value) {
      final parts = key.split('_');
      if (parts.length >= 2) {
        final dateStr = parts[0];
        if (dateStr.length == 8) {
          final year = int.parse(dateStr.substring(0, 4));
          final month = int.parse(dateStr.substring(4, 6));
          final day = int.parse(dateStr.substring(6, 8));
          final date = DateTime(year, month, day);

          if (date.isAfter(startOfWeek.subtract(const Duration(seconds: 1))) && 
              date.isBefore(endOfWeek)) {
            if (value == 1) {
              count++;
              countedKeys.add(key);
            }
          }
        }
      }
    });

    for (var log in _prayerLogs) {
      final date = DateTime.parse(log['timestamp']!);
      if (date.isAfter(startOfWeek.subtract(const Duration(seconds: 1))) && 
          date.isBefore(endOfWeek)) {
        final prayerId = log['prayerId'] ?? '';
        final dateStr = DateFormat('yyyyMMdd').format(date);
        final key = '${dateStr}_$prayerId';
        
        if (!countedKeys.contains(key)) {
          count++;
        }
      }
    }
    
    return count;
  }

  int getDailyPrayerCount(DateTime date) {
    int count = 0;
    final dateStr = DateFormat('yyyyMMdd').format(date);
    
    // Track which prayer IDs are already counted from dailyPrayers
    final Set<String> countedPrayerIds = {};

    // Count completed daily prayers
    _dailyPrayers.forEach((key, value) {
      if (key.startsWith(dateStr) && value == 1) {
        count++;
        // Extract the prayer ID from the key (format: yyyyMMdd_prayerId)
        final parts = key.split('_');
        if (parts.length >= 2) {
          countedPrayerIds.add(parts.sublist(1).join('_'));
        }
      }
    });

    // Count logged prayers (but skip those already counted from dailyPrayers)
    for (var log in _prayerLogs) {
      final logDate = DateTime.parse(log['timestamp']!);
      if (logDate.year == date.year && logDate.month == date.month && logDate.day == date.day) {
        final prayerId = log['prayerId'] ?? '';
        // Only count if not already counted from dailyPrayers
        if (!countedPrayerIds.contains(prayerId)) {
          count++;
        }
      }
    }

    return count;
  }

  Map<DateTime, int> getHeatmapData() {
    final Map<DateTime, int> heatmap = {};

    // Process daily prayers
    _dailyPrayers.forEach((key, value) {
      if (value == 1) {
        final parts = key.split('_');
        if (parts.length >= 2) {
          final dateStr = parts[0];
          if (dateStr.length == 8) {
            final year = int.parse(dateStr.substring(0, 4));
            final month = int.parse(dateStr.substring(4, 6));
            final day = int.parse(dateStr.substring(6, 8));
            final date = DateTime(year, month, day);
            
            heatmap.update(date, (val) => val + 1, ifAbsent: () => 1);
          }
        }
      }
    });

    // Process logs (avoid double counting)
    // Create a set of "date_prayerId" for existing daily prayers to check against
    final dailyPrayerKeys = _dailyPrayers.entries
        .where((e) => e.value == 1)
        .map((e) => e.key)
        .toSet();

    for (var log in _prayerLogs) {
      final timestamp = DateTime.parse(log['timestamp']!);
      final dateOnly = DateTime(timestamp.year, timestamp.month, timestamp.day);
      final dateStr = DateFormat('yyyyMMdd').format(dateOnly);
      final prayerId = log['prayerId'] ?? '';
      
      final key = '${dateStr}_$prayerId';
      
      // If not already counted via daily prayers
      if (!dailyPrayerKeys.contains(key)) {
        heatmap.update(dateOnly, (val) => val + 1, ifAbsent: () => 1);
      }
    }
    
    return heatmap;
  }

  ReminderModel? getReminderById(String id) => _reminderService.getReminderById(id);
}
