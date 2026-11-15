import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _senhaKey = 'sanctaConsciencia_senhaHash';
  static const String _pecadosKey = 'sanctaConscientia_pecados';
  static const String _dataUltimaConfissaoKey = 'sanctaConscientia_dataUltimaConfissao';
  static const String _proximaConfissaoKey = 'sanctaConscientia_proximaConfissao';
  static const String _historicoConfissoesKey = 'sanctaConscientia_historicoConfissoes';
  static const String _activeNovenasKey = 'sanctaConscientia_activeNovenas';
  static const String _dailyPrayersKey = 'sanctaConscientia_dailyPrayers';
  static const String _weeklyCommitmentsKey = 'sanctaConscientia_weeklyCommitments';

  Future<void> savePassword(String passwordHash) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_senhaKey, passwordHash);
  }

  Future<String?> getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_senhaKey);
  }

  Future<void> savePecados(Map<String, int> pecados) async {
    final prefs = await SharedPreferences.getInstance();
    final pecadosString = _mapToString(pecados);
    await prefs.setString(_pecadosKey, pecadosString);
  }

  Future<Map<String, int>> loadPecados() async {
    final prefs = await SharedPreferences.getInstance();
    final pecadosString = prefs.getString(_pecadosKey);
    if (pecadosString != null) {
      return _stringToMap(pecadosString);
    }
    return {};
  }

  // Métodos para data da última confissão
  Future<void> saveDataUltimaConfissao(DateTime data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_dataUltimaConfissaoKey, data.toIso8601String());
  }

  Future<DateTime?> loadDataUltimaConfissao() async {
    final prefs = await SharedPreferences.getInstance();
    final dataString = prefs.getString(_dataUltimaConfissaoKey);
    if (dataString != null) {
      return DateTime.parse(dataString);
    }
    return null;
  }

  // Métodos para data da próxima confissão
  Future<void> saveProximaConfissao(DateTime data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_proximaConfissaoKey, data.toIso8601String());
  }

  Future<DateTime?> loadProximaConfissao() async {
    final prefs = await SharedPreferences.getInstance();
    final dataString = prefs.getString(_proximaConfissaoKey);
    if (dataString != null) {
      return DateTime.parse(dataString);
    }
    return null;
  }

  // Métodos para histórico de confissões
  Future<void> saveConfessionHistory(List<DateTime> datas) async {
    final prefs = await SharedPreferences.getInstance();
    final datasString = datas.map((d) => d.toIso8601String()).join('|');
    await prefs.setString(_historicoConfissoesKey, datasString);
  }

  Future<List<DateTime>> loadConfessionHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final datasString = prefs.getString(_historicoConfissoesKey);
    if (datasString != null && datasString.isNotEmpty) {
      return datasString.split('|').map((s) => DateTime.parse(s)).toList();
    }
    return [];
  }

  // Métodos para novenas ativas
  Future<void> saveActiveNovenas(Map<String, DateTime> novenas) async {
    final prefs = await SharedPreferences.getInstance();
    final novenasString = novenas.entries
        .map((e) => '${e.key}::${e.value.toIso8601String()}')
        .join('||');
    await prefs.setString(_activeNovenasKey, novenasString);
  }

  Future<Map<String, DateTime>> loadActiveNovenas() async {
    final prefs = await SharedPreferences.getInstance();
    final novenasString = prefs.getString(_activeNovenasKey);
    if (novenasString != null && novenasString.isNotEmpty) {
      final map = <String, DateTime>{};
      for (var entry in novenasString.split('||')) {
        final parts = entry.split('::');
        if (parts.length == 2) {
          map[parts[0]] = DateTime.parse(parts[1]);
        }
      }
      return map;
    }
    return {};
  }

  // Métodos para Plano de Vida
  Future<void> saveDailyPrayers(Map<String, int> dailyPrayers) async {
    final prefs = await SharedPreferences.getInstance();
    final dataString = _mapToString(dailyPrayers);
    await prefs.setString(_dailyPrayersKey, dataString);
  }

  Future<Map<String, int>> loadDailyPrayers() async {
    final prefs = await SharedPreferences.getInstance();
    final dataString = prefs.getString(_dailyPrayersKey);
    if (dataString != null) {
      return _stringToMap(dataString);
    }
    return {};
  }

  Future<void> saveWeeklyCommitments(Map<String, int> weeklyCommitments) async {
    final prefs = await SharedPreferences.getInstance();
    final dataString = _mapToString(weeklyCommitments);
    await prefs.setString(_weeklyCommitmentsKey, dataString);
  }

  Future<Map<String, int>> loadWeeklyCommitments() async {
    final prefs = await SharedPreferences.getInstance();
    final dataString = prefs.getString(_weeklyCommitmentsKey);
    if (dataString != null) {
      return _stringToMap(dataString);
    }
    return {};
  }

  // Métodos para Orações Personalizáveis
  static const String _availablePrayersKey = 'sanctaConscientia_availablePrayers';

  Future<void> saveAvailablePrayers(List<Map<String, String>> prayers) async {
    final prefs = await SharedPreferences.getInstance();
    // Format: id::title::prayerId::prayerType::reminderTime::frequency::reminderDate
    final dataString = prayers.map((e) {
      final id = e['id'] ?? '';
      final title = e['title'] ?? '';
      final prayerId = e['prayerId'] ?? '';
      final prayerType = e['prayerType'] ?? '';
      final reminderTime = e['reminderTime'] ?? '';
      final frequency = e['frequency'] ?? '';
      final reminderDate = e['reminderDate'] ?? '';
      return '$id::$title::$prayerId::$prayerType::$reminderTime::$frequency::$reminderDate';
    }).join('||');
    await prefs.setString(_availablePrayersKey, dataString);
  }

  Future<List<Map<String, String>>> loadAvailablePrayers() async {
    final prefs = await SharedPreferences.getInstance();
    final dataString = prefs.getString(_availablePrayersKey);
    
    if (dataString != null && dataString.isNotEmpty) {
      final List<Map<String, String>> prayers = [];
      for (var entry in dataString.split('||')) {
        final parts = entry.split('::');
        if (parts.length >= 2) {
          final prayer = {
            'id': parts[0],
            'title': parts[1],
          };
          if (parts.length >= 3 && parts[2].isNotEmpty) prayer['prayerId'] = parts[2];
          if (parts.length >= 4 && parts[3].isNotEmpty) prayer['prayerType'] = parts[3];
          if (parts.length >= 5 && parts[4].isNotEmpty) prayer['reminderTime'] = parts[4];
          if (parts.length >= 6 && parts[5].isNotEmpty) prayer['frequency'] = parts[5];
          if (parts.length >= 7 && parts[6].isNotEmpty) prayer['reminderDate'] = parts[6];
          prayers.add(prayer);
        }
      }
      return prayers;
    }
    return [];
  }

  // Métodos para Logs de Oração (Histórico)
  static const String _prayerLogsKey = 'sanctaConscientia_prayerLogs';

  Future<void> savePrayerLogs(List<Map<String, String>> logs) async {
    final prefs = await SharedPreferences.getInstance();
    // Format: title::timestamp::prayerId::prayerType
    final dataString = logs.map((e) {
      final title = e['title'] ?? '';
      final timestamp = e['timestamp'] ?? '';
      final prayerId = e['prayerId'] ?? '';
      final prayerType = e['prayerType'] ?? '';
      return '$title::$timestamp::$prayerId::$prayerType';
    }).join('||');
    await prefs.setString(_prayerLogsKey, dataString);
  }

  Future<List<Map<String, String>>> loadPrayerLogs() async {
    final prefs = await SharedPreferences.getInstance();
    final dataString = prefs.getString(_prayerLogsKey);
    
    if (dataString != null && dataString.isNotEmpty) {
      final List<Map<String, String>> logs = [];
      for (var entry in dataString.split('||')) {
        final parts = entry.split('::');
        if (parts.length >= 2) {
          final log = {
            'title': parts[0],
            'timestamp': parts[1],
          };
          if (parts.length >= 3 && parts[2].isNotEmpty) log['prayerId'] = parts[2];
          if (parts.length >= 4 && parts[3].isNotEmpty) log['prayerType'] = parts[3];
          logs.add(log);
        }
      }
      return logs;
    }
    return [];
  }

  // Métodos para Orações Agendadas
  static const String _scheduledPrayersKey = 'sanctaConscientia_scheduledPrayers';

  Future<void> saveScheduledPrayers(List<Map<String, String>> scheduled) async {
    final prefs = await SharedPreferences.getInstance();
    // Format: id::title::timestamp::prayerId::prayerType::notificationId
    final dataString = scheduled.map((e) {
      final id = e['id'] ?? '';
      final title = e['title'] ?? '';
      final timestamp = e['timestamp'] ?? '';
      final prayerId = e['prayerId'] ?? '';
      final prayerType = e['prayerType'] ?? '';
      final notificationId = e['notificationId'] ?? '';
      return '$id::$title::$timestamp::$prayerId::$prayerType::$notificationId';
    }).join('||');
    await prefs.setString(_scheduledPrayersKey, dataString);
  }

  Future<List<Map<String, String>>> loadScheduledPrayers() async {
    final prefs = await SharedPreferences.getInstance();
    final dataString = prefs.getString(_scheduledPrayersKey);
    
    if (dataString != null && dataString.isNotEmpty) {
      final List<Map<String, String>> scheduled = [];
      for (var entry in dataString.split('||')) {
        final parts = entry.split('::');
        if (parts.length >= 3) {
          final item = {
            'id': parts[0],
            'title': parts[1],
            'timestamp': parts[2],
          };
          if (parts.length >= 4 && parts[3].isNotEmpty) item['prayerId'] = parts[3];
          if (parts.length >= 5 && parts[4].isNotEmpty) item['prayerType'] = parts[4];
          if (parts.length >= 6 && parts[5].isNotEmpty) item['notificationId'] = parts[5];
          scheduled.add(item);
        }
      }
      return scheduled;
    }
    return [];
  }

  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_senhaKey);
    await prefs.remove(_pecadosKey);
    await prefs.remove(_dataUltimaConfissaoKey);
    await prefs.remove(_proximaConfissaoKey);
    await prefs.remove(_historicoConfissoesKey);
    await prefs.remove(_activeNovenasKey);
    await prefs.remove(_dailyPrayersKey);
    await prefs.remove(_weeklyCommitmentsKey);
    await prefs.remove(_scheduledPrayersKey);
  }

  // Helper methods para serializar/deserializar o Map
  String _mapToString(Map<String, int> map) {
    return map.entries.map((e) => '${e.key}:${e.value}').join(';');
  }

  Map<String, int> _stringToMap(String str) {
    final map = <String, int>{};
    final entries = str.split(';');
    for (var entry in entries) {
      final parts = entry.split(':');
      if (parts.length == 2) {
        map[parts[0]] = int.tryParse(parts[1]) ?? 0;
      }
    }
    return map;
  }
}