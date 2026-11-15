import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sanctaconscientia/services/local_storage.dart';
import 'dart:convert';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  /// Apaga todos os dados de todas as tabelas, para os testes começarem limpos.
  @visibleForTesting
  Future<void> wipeAllDataForTests() async {
    final db = await database;
    final tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type = 'table' "
      "AND name NOT LIKE 'sqlite_%' AND name != 'android_metadata'",
    );
    for (final t in tables) {
      await db.delete(t['name'] as String);
    }
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'sancta_conscientia.db');

    return await openDatabase(
      path,
      version: 5, // Bumped version for penance system
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    // Tabela de Pecados
    await db.execute('''
      CREATE TABLE pecados (
        id TEXT PRIMARY KEY,
        count INTEGER NOT NULL
      )
    ''');

    // Tabela de Configurações/Dados Simples (Última confissão, Próxima confissão, Senha)
    await db.execute('''
      CREATE TABLE user_settings (
        key TEXT PRIMARY KEY,
        value TEXT
      )
    ''');

    // Tabela de Histórico de Confissões
    await db.execute('''
      CREATE TABLE confession_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        penance_note TEXT,
        penance_completed INTEGER NOT NULL DEFAULT 0
      )
    ''');

    // Tabela de Novenas Ativas
    await db.execute('''
      CREATE TABLE active_novenas (
        id TEXT PRIMARY KEY,
        start_date TEXT NOT NULL,
        reminder_time TEXT
      )
    ''');

    // Tabela de Orações Diárias (Plano de Vida)
    await db.execute('''
      CREATE TABLE daily_prayers_status (
        date TEXT NOT NULL,
        prayer_id TEXT NOT NULL,
        status INTEGER NOT NULL,
        PRIMARY KEY (date, prayer_id)
      )
    ''');

    // Tabela de Compromissos Semanais
    await db.execute('''
      CREATE TABLE weekly_commitments_status (
        date TEXT NOT NULL,
        commitment_id TEXT NOT NULL,
        status INTEGER NOT NULL,
        PRIMARY KEY (date, commitment_id)
      )
    ''');

    // Tabela de Orações Personalizadas (Available Prayers)
    await db.execute('''
      CREATE TABLE custom_prayers (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        prayer_id TEXT,
        prayer_type TEXT,
        reminder_time TEXT,
        frequency TEXT,
        reminder_date TEXT,
        default_time TEXT
      )
    ''');

    // Tabela de Logs de Oração
    await db.execute('''
      CREATE TABLE prayer_logs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        timestamp TEXT NOT NULL,
        prayer_id TEXT,
        prayer_type TEXT
      )
    ''');

    // Tabela de Orações Agendadas
    await db.execute('''
      CREATE TABLE scheduled_prayers (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        timestamp TEXT NOT NULL,
        prayer_id TEXT,
        prayer_type TEXT,
        notification_id TEXT
      )
    ''');

    // Tabela de Lembretes (Reminders)
    await db.execute('''
      CREATE TABLE reminders (
        id TEXT PRIMARY KEY,
        data TEXT NOT NULL
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add reminder_time column to active_novenas
      // Check if column exists first to be safe, or just try/catch, but standard SQL add column is safe enough usually
      // SQLite doesn't support IF NOT EXISTS for ADD COLUMN in all versions, but we know version 1 didn't have it.
      await db.execute('ALTER TABLE active_novenas ADD COLUMN reminder_time TEXT');
    }
    if (oldVersion < 3) {
      await db.execute('ALTER TABLE custom_prayers ADD COLUMN default_time TEXT');
    }
    if (oldVersion < 4) {
      // Add reminders table
      await db.execute('''
        CREATE TABLE reminders (
          id TEXT PRIMARY KEY,
          data TEXT NOT NULL
        )
      ''');
    }
    if (oldVersion < 5) {
      await db.execute('ALTER TABLE confession_history ADD COLUMN penance_note TEXT');
      await db.execute('ALTER TABLE confession_history ADD COLUMN penance_completed INTEGER NOT NULL DEFAULT 0');
    }
  }

  // =======================================================================
  // Migration Helper
  // =======================================================================
  Future<void> migrateFromSharedPreferences() async {
    final db = await database;
    
    final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM custom_prayers'));
    if (count != null && count > 0) {
      return; 
    }

    final localStorage = LocalStorage();
    
    // 1. Pecados
    final pecados = await localStorage.loadPecados();
    if (pecados.isNotEmpty) {
      final batch = db.batch();
      pecados.forEach((key, value) {
        batch.insert('pecados', {'id': key, 'count': value}, conflictAlgorithm: ConflictAlgorithm.replace);
      });
      await batch.commit();
    }

    // 2. User Settings
    final lastConfession = await localStorage.loadDataUltimaConfissao();
    if (lastConfession != null) {
      await saveSetting('last_confession', lastConfession.toIso8601String());
    }
    final nextConfession = await localStorage.loadProximaConfissao();
    if (nextConfession != null) {
      await saveSetting('next_confession', nextConfession.toIso8601String());
    }
    final password = await localStorage.getPassword();
    if (password != null) {
      await saveSetting('password_hash', password);
    }

    // 3. Confession History
    final history = await localStorage.loadConfessionHistory();
    if (history.isNotEmpty) {
      final batch = db.batch();
      for (var date in history) {
        batch.insert('confession_history', {'date': date.toIso8601String()});
      }
      await batch.commit();
    }

    // 4. Active Novenas
    final novenas = await localStorage.loadActiveNovenas();
    if (novenas.isNotEmpty) {
      final batch = db.batch();
      novenas.forEach((key, value) {
        batch.insert('active_novenas', {'id': key, 'start_date': value.toIso8601String()}, conflictAlgorithm: ConflictAlgorithm.replace);
      });
      await batch.commit();
    }

    // 5. Daily Prayers Status
    final daily = await localStorage.loadDailyPrayers(); 
    if (daily.isNotEmpty) {
      final batch = db.batch();
      daily.forEach((key, value) {
        final parts = key.split('_');
        if (parts.length >= 2) {
          final date = parts[0];
          final id = parts.sublist(1).join('_'); 
          batch.insert('daily_prayers_status', {'date': date, 'prayer_id': id, 'status': value}, conflictAlgorithm: ConflictAlgorithm.replace);
        }
      });
      await batch.commit();
    }

    // 6. Weekly Commitments
    final weekly = await localStorage.loadWeeklyCommitments();
    if (weekly.isNotEmpty) {
      final batch = db.batch();
      weekly.forEach((key, value) {
        final parts = key.split('_');
        if (parts.length >= 2) {
          final date = parts[0];
          final id = parts.sublist(1).join('_');
          batch.insert('weekly_commitments_status', {'date': date, 'commitment_id': id, 'status': value}, conflictAlgorithm: ConflictAlgorithm.replace);
        }
      });
      await batch.commit();
    }

    // 7. Custom Prayers (Available Prayers)
    final prayers = await localStorage.loadAvailablePrayers();
    if (prayers.isNotEmpty) {
      final batch = db.batch();
      for (var p in prayers) {
        batch.insert('custom_prayers', {
          'id': p['id'],
          'title': p['title'],
          'prayer_id': p['prayerId'],
          'prayer_type': p['prayerType'],
          'reminder_time': p['reminderTime'],
          'frequency': p['frequency'],
          'reminder_date': p['reminderDate'],
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit();
    }

    // 8. Prayer Logs
    final logs = await localStorage.loadPrayerLogs();
    if (logs.isNotEmpty) {
      final batch = db.batch();
      for (var l in logs) {
        batch.insert('prayer_logs', {
          'title': l['title'],
          'timestamp': l['timestamp'],
          'prayer_id': l['prayerId'],
          'prayer_type': l['prayerType'],
        });
      }
      await batch.commit();
    }

    // 9. Scheduled Prayers
    final scheduled = await localStorage.loadScheduledPrayers();
    if (scheduled.isNotEmpty) {
      final batch = db.batch();
      for (var s in scheduled) {
        batch.insert('scheduled_prayers', {
          'id': s['id'],
          'title': s['title'],
          'timestamp': s['timestamp'],
          'prayer_id': s['prayerId'],
          'prayer_type': s['prayerType'],
          'notification_id': s['notificationId'],
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit();
    }
  }

  // =======================================================================
  // CRUD Operations
  // =======================================================================

  // --- Settings ---
  Future<void> saveSetting(String key, String value) async {
    final db = await database;
    await db.insert('user_settings', {'key': key, 'value': value}, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<String?> getSetting(String key) async {
    final db = await database;
    final maps = await db.query('user_settings', where: 'key = ?', whereArgs: [key]);
    if (maps.isNotEmpty) {
      return maps.first['value'] as String?;
    }
    return null;
  }

  /// Apaga os dados sensíveis do exame: itens marcados, histórico de confissões,
  /// datas e a senha. Usado pelo "Recuperar acesso" (senha esquecida).
  Future<void> wipeExamData() async {
    final db = await database;
    await db.delete('pecados');
    await db.delete('confession_history');
    for (final key in const ['last_confession', 'next_confession', 'confession_interval', 'password_hash']) {
      await db.delete('user_settings', where: 'key = ?', whereArgs: [key]);
    }
  }

  Future<void> deleteSetting(String key) async {
    final db = await database;
    await db.delete('user_settings', where: 'key = ?', whereArgs: [key]);
  }

  // --- Pecados ---
  Future<void> updatePecado(String id, int count) async {
    final db = await database;
    await db.insert('pecados', {'id': id, 'count': count}, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, int>> loadPecados() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('pecados');
    return {for (var m in maps) m['id'] as String: m['count'] as int};
  }
  
  Future<void> clearPecados() async {
    final db = await database;
    await db.delete('pecados');
  }

  // --- Confession History ---
  Future<void> addConfession(DateTime date, {String? penanceNote}) async {
    final db = await database;
    await db.insert('confession_history', {
      'date': date.toIso8601String(),
      'penance_note': penanceNote,
      'penance_completed': 0,
    });
  }
  
  Future<void> deleteConfessionByDate(DateTime date) async {
     final db = await database;
     await db.delete('confession_history', where: 'date = ?', whereArgs: [date.toIso8601String()]);
  }

  Future<void> updatePenanceCompleted(int confessionId, bool completed) async {
    final db = await database;
    await db.update(
      'confession_history',
      {'penance_completed': completed ? 1 : 0},
      where: 'id = ?',
      whereArgs: [confessionId],
    );
  }

  Future<List<Map<String, dynamic>>> loadConfessionHistory() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('confession_history', orderBy: 'date DESC');
    return maps.map((m) => {
      'id': m['id'] as int,
      'date': DateTime.parse(m['date'] as String),
      'penanceNote': m['penance_note'] as String?,
      'penanceCompleted': (m['penance_completed'] as int?) == 1,
    }).toList();
  }

  // --- Active Novenas ---
  Future<void> saveActiveNovena(String id, DateTime startDate, {String? reminderTime}) async {
    final db = await database;
    final data = {'id': id, 'start_date': startDate.toIso8601String()};
    if (reminderTime != null) {
      data['reminder_time'] = reminderTime;
    }
    await db.insert('active_novenas', data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeActiveNovena(String id) async {
    final db = await database;
    await db.delete('active_novenas', where: 'id = ?', whereArgs: [id]);
  }

  Future<Map<String, Map<String, dynamic>>> loadActiveNovenas() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('active_novenas');
    return {
      for (var m in maps) 
        m['id'] as String: {
          'startDate': DateTime.parse(m['start_date'] as String),
          'reminderTime': m['reminder_time'] as String?,
        }
    };
  }

  // --- Daily Prayers Status ---
  Future<void> updateDailyPrayerStatus(String date, String prayerId, int status) async {
    final db = await database;
    await db.insert('daily_prayers_status', {'date': date, 'prayer_id': prayerId, 'status': status}, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, int>> loadDailyPrayersStatus() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('daily_prayers_status');
    return {for (var m in maps) '${m['date']}_${m['prayer_id']}': m['status'] as int};
  }

  // --- Weekly Commitments ---
  Future<void> updateWeeklyCommitmentStatus(String date, String commitmentId, int status) async {
    final db = await database;
    await db.insert('weekly_commitments_status', {'date': date, 'commitment_id': commitmentId, 'status': status}, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, int>> loadWeeklyCommitmentsStatus() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('weekly_commitments_status');
    return {for (var m in maps) '${m['date']}_${m['commitment_id']}': m['status'] as int};
  }

  // --- Custom Prayers ---
  Future<void> saveCustomPrayer(Map<String, String> prayer) async {
    final db = await database;
    await db.insert('custom_prayers', {
      'id': prayer['id'],
      'title': prayer['title'],
      'prayer_id': prayer['prayerId'],
      'prayer_type': prayer['prayerType'],
      'reminder_time': prayer['reminderTime'],
      'frequency': prayer['frequency'],
      'reminder_date': prayer['reminderDate'],
      'default_time': prayer['defaultTime'],
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteCustomPrayer(String id) async {
    final db = await database;
    await db.delete('custom_prayers', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, String>>> loadCustomPrayers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('custom_prayers');
    return maps.map((m) {
      final map = <String, String>{
        'id': m['id'] as String,
        'title': m['title'] as String,
      };
      if (m['prayer_id'] != null) map['prayerId'] = m['prayer_id'] as String;
      if (m['prayer_type'] != null) map['prayerType'] = m['prayer_type'] as String;
      if (m['reminder_time'] != null) map['reminderTime'] = m['reminder_time'] as String;
      if (m['frequency'] != null) map['frequency'] = m['frequency'] as String;
      if (m['reminder_date'] != null) map['reminderDate'] = m['reminder_date'] as String;
      if (m['default_time'] != null) map['defaultTime'] = m['default_time'] as String;
      return map;
    }).toList();
  }

  // --- Prayer Logs ---
  Future<void> addPrayerLog(Map<String, String> log) async {
    final db = await database;
    await db.insert('prayer_logs', {
      'title': log['title'],
      'timestamp': log['timestamp'],
      'prayer_id': log['prayerId'],
      'prayer_type': log['prayerType'],
    });
  }

  Future<void> deletePrayerLog(String timestamp, String title) async {
    final db = await database;
    await db.delete('prayer_logs', where: 'timestamp = ? AND title = ?', whereArgs: [timestamp, title]);
  }

  /// Delete prayer log by date key and prayer ID (for bidirectional sync)
  Future<void> deletePrayerLogByDateAndId(String dateKey, String prayerId) async {
    final db = await database;
    // Convert dateKey (yyyyMMdd) to ISO date format (yyyy-MM-dd) for matching
    String isoDatePrefix = dateKey;
    if (dateKey.length == 8) {
      isoDatePrefix = '${dateKey.substring(0, 4)}-${dateKey.substring(4, 6)}-${dateKey.substring(6, 8)}';
    }
    // Delete logs where prayer_id matches and timestamp starts with the date
    await db.delete(
      'prayer_logs',
      where: 'prayer_id = ? AND timestamp LIKE ?',
      whereArgs: [prayerId, '$isoDatePrefix%'],
    );
  }

  Future<List<Map<String, String>>> loadPrayerLogs() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('prayer_logs', orderBy: 'timestamp DESC');
    return maps.map((m) {
      final map = <String, String>{
        'title': m['title'] as String,
        'timestamp': m['timestamp'] as String,
      };
      if (m['prayer_id'] != null) map['prayerId'] = m['prayer_id'] as String;
      if (m['prayer_type'] != null) map['prayerType'] = m['prayer_type'] as String;
      return map;
    }).toList();
  }

  // --- Scheduled Prayers ---
  Future<void> saveScheduledPrayer(Map<String, String> prayer) async {
    final db = await database;
    await db.insert('scheduled_prayers', {
      'id': prayer['id'],
      'title': prayer['title'],
      'timestamp': prayer['timestamp'],
      'prayer_id': prayer['prayerId'],
      'prayer_type': prayer['prayerType'],
      'notification_id': prayer['notificationId'],
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteScheduledPrayer(String id) async {
    final db = await database;
    await db.delete('scheduled_prayers', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, String>>> loadScheduledPrayers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('scheduled_prayers', orderBy: 'timestamp ASC');
    return maps.map((m) {
      final map = <String, String>{
        'id': m['id'] as String,
        'title': m['title'] as String,
        'timestamp': m['timestamp'] as String,
      };
      if (m['prayer_id'] != null) map['prayerId'] = m['prayer_id'] as String;
      if (m['prayer_type'] != null) map['prayerType'] = m['prayer_type'] as String;
      if (m['notification_id'] != null) map['notificationId'] = m['notification_id'] as String;
      return map;
    }).toList();
  }

  // --- Reminders ---
  Future<void> saveReminder(dynamic reminder) async {
    final db = await database;
    final json = reminder.toJson();
    await db.insert('reminders', {
      'id': json['id'],
      'data': jsonEncode(json),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// Grava um lembrete já em JSON (restauração de backup).
  Future<void> saveReminderJson(Map<String, dynamic> json) async {
    final db = await database;
    await db.insert('reminders', {
      'id': json['id'],
      'data': jsonEncode(json),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateReminder(dynamic reminder) async {
    await saveReminder(reminder); // Same as save with replace
  }

  Future<void> deleteReminder(String id) async {
    final db = await database;
    await db.delete('reminders', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<dynamic>> loadReminders() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('reminders');
    
    // Import will be done in ReminderService to avoid circular dependency
    // Return raw JSON maps for now
    return maps.map((m) => jsonDecode(m['data'] as String)).toList();
  }
}

