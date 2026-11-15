import 'package:flutter/material.dart';
import 'package:sanctaconscientia/services/database_service.dart';
import 'package:sanctaconscientia/services/notification_service.dart';
import 'package:sanctaconscientia/services/reminder_service.dart';
import 'package:sanctaconscientia/models/reminder_model.dart';
import 'package:sanctaconscientia/utils/notification_strings.dart';

class ConfessionProvider extends ChangeNotifier {
  Map<String, int> _pecados = {};
  DateTime? _dataUltimaConfissao;
  DateTime? _nextConfessionDate;
  List<Map<String, dynamic>> _confessionHistory = [];
  int? _confessionInterval;
  
  // Dependencies
  final ReminderService _reminderService;

  ConfessionProvider({ReminderService? reminderService}) 
      : _reminderService = reminderService ?? ReminderService(
          databaseService: DatabaseService(),
          notificationService: NotificationService(),
        );

  /// Dados de exemplo só em memória (nada é gravado), usados pelo guia do app
  /// para mostrar o Exame sem expor os dados reais da pessoa.
  void loadDemo(List<String> categoryIds) {
    final now = DateTime.now();
    _dataUltimaConfissao = now.subtract(const Duration(days: 45));
    _nextConfessionDate = now.add(const Duration(days: 12));
    _pecados.clear();
    for (var i = 0; i < categoryIds.length && i < 3; i++) {
      for (var k = 0; k <= i + 1; k++) {
        _pecados['${categoryIds[i]}-demo-$k'] = 1;
      }
    }
    notifyListeners();
  }

  Map<String, int> get pecados => _pecados;
  DateTime? get dataUltimaConfissao => _dataUltimaConfissao;
  DateTime? get nextConfessionDate => _nextConfessionDate;
  List<Map<String, dynamic>> get confessionHistory => _confessionHistory;
  int? get confessionInterval => _confessionInterval;

  TimeOfDay? get confessionReminderTime {
    final reminder = _reminderService.getReminderById('confession_reminder');
    if (reminder != null && reminder.times.isNotEmpty) return reminder.times.first;
    return null;
  }

  int? get confessionReminderDays {
    final reminder = _reminderService.getReminderById('confession_reminder');
    if (reminder != null && _nextConfessionDate != null && reminder.startDate != null) {
      // Create a date-only version of both to avoid time-of-day subtraction issues
      final nextDateOnly = DateTime(_nextConfessionDate!.year, _nextConfessionDate!.month, _nextConfessionDate!.day);
      final reminderDateOnly = DateTime(reminder.startDate!.year, reminder.startDate!.month, reminder.startDate!.day);
      return nextDateOnly.difference(reminderDateOnly).inDays;
    }
    return null;
  }

  Future<void> loadData() async {
    final dbService = DatabaseService();
    
    _pecados = await dbService.loadPecados();
    
    final lastConfessionStr = await dbService.getSetting('last_confession');
    if (lastConfessionStr != null) _dataUltimaConfissao = DateTime.parse(lastConfessionStr);
    
    final nextConfessionStr = await dbService.getSetting('next_confession');
    if (nextConfessionStr != null) _nextConfessionDate = DateTime.parse(nextConfessionStr);

    final intervalStr = await dbService.getSetting('confession_interval');
    if (intervalStr != null) _confessionInterval = int.tryParse(intervalStr);
    
    _confessionHistory = await dbService.loadConfessionHistory();
    
    // Load reminders to ensure sync is already handled by AppState
    // await _reminderService.loadReminders();

    notifyListeners();
  }

  /// Quantos itens (pecados distintos) estão marcados no exame inteiro.
  int get totalPecados => _pecados.values.fold(0, (a, b) => a + (b > 0 ? 1 : 0));

  /// Quantos itens (pecados distintos) estão marcados em uma categoria.
  /// As chaves têm o formato `<categoria>-<subcategoria>-<indice>`.
  int pecadosNaCategoria(String categoriaId) => _pecados.entries
      .where((e) => e.value > 0 && e.key.startsWith('$categoriaId-'))
      .length;

  int getContador(String chave) {
    return _pecados[chave] ?? 0;
  }

  Future<void> incrementarPecado(String chave) async {
    _pecados[chave] = (getContador(chave) + 1);
    await DatabaseService().updatePecado(chave, _pecados[chave]!);
    notifyListeners();
  }

  Future<void> decrementarPecado(String chave) async {
    final contadorAtual = getContador(chave);
    if (contadorAtual > 0) {
      _pecados[chave] = contadorAtual - 1;
      await DatabaseService().updatePecado(chave, _pecados[chave]!);
      notifyListeners();
    }
  }

  Future<void> confirmarConfissao({DateTime? date, String? penanceNote}) async {
    final dataConfissao = date ?? DateTime.now();
    _dataUltimaConfissao = dataConfissao;
    _pecados.clear();
    
    final dbService = DatabaseService();
    await dbService.addConfession(dataConfissao, penanceNote: penanceNote);
    await dbService.saveSetting('last_confession', dataConfissao.toIso8601String());
    await dbService.clearPecados();
    
    // Reload history to get the new entry with its DB id
    _confessionHistory = await dbService.loadConfessionHistory();
    
    notifyListeners();

    // Auto-schedule next confession if interval is set
    if (_confessionInterval != null && _confessionInterval! > 0) {
      // Re-schedule reminder if configured
      final currentReminderTime = confessionReminderTime;
      final currentReminderDays = confessionReminderDays;

      final nextDate = dataConfissao.add(Duration(days: _confessionInterval!));
      await setNextConfessionDate(nextDate);
      
      if (currentReminderTime != null) {
        // Usa o valor persistido se existir, senão usa 1 (1 dia antes)
        await setConfessionReminder(currentReminderTime, daysInAdvance: currentReminderDays ?? 1);
      }
    } else {
      await setNextConfessionDate(null);
    }
  }

  Future<void> setNextConfessionDate(DateTime? data) async {
    _nextConfessionDate = data;
    if (data != null) {
      await DatabaseService().saveSetting('next_confession', data.toIso8601String());
    } else {
      await cancelConfessionReminder();
    }
    notifyListeners();
  }

  static const int _confessionNotificationId = 999999;

  Future<void> setConfessionReminder(TimeOfDay time, {int daysInAdvance = 0}) async {
    DateTime? targetNextConfession = _nextConfessionDate;

    // Se estivermos adicionando uma notificação e não houver data calculada, mas temos um intervalo:
    if (targetNextConfession == null) {
      if (_confessionInterval != null && _confessionInterval! > 0) {
        final baseDate = _dataUltimaConfissao ?? DateTime.now();
        targetNextConfession = baseDate.add(Duration(days: _confessionInterval!));
        await setNextConfessionDate(targetNextConfession);
      } else {
        return; // Nem data, nem intervalo: nada a fazer
      }
    }

    // Calcula a data e garante que ela inclui a hora exata da notificação
    final baseReminderDate = targetNextConfession.subtract(Duration(days: daysInAdvance));
    final reminderDate = DateTime(
      baseReminderDate.year, 
      baseReminderDate.month, 
      baseReminderDate.day, 
      time.hour, 
      time.minute,
    );
    
    // Create/update unified reminder
    final reminderTitle = await NotificationStrings.getConfessionReminderTitle();
    final reminderDescription = await NotificationStrings.getConfessionReminderBody(daysInAdvance);
    // Se o usuário pausou o lembrete em Lembretes, a pausa continua depois de
    // cada confissão (antes o lembrete era recriado ligado).
    final wasActive = _reminderService.getReminderById('confession_reminder')?.isActive ?? true;
    final confessionReminder = ReminderModel(
      id: 'confession_reminder',
      title: reminderTitle,
      description: reminderDescription,
      type: ReminderType.confession,
      times: [time],
      recurrence: RecurrenceType.once,
      startDate: reminderDate,
      createdAt: DateTime.now(),
      prayerId: 'full_examination',
      isActive: wasActive,
      notificationIds: [_confessionNotificationId],
    );
    
    await _reminderService.createOrUpdateUnifiedReminder(confessionReminder);
    notifyListeners();
  }

  Future<void> cancelConfessionReminder() async {
    // Try to cleanup old database properties if they exist
    await DatabaseService().deleteSetting('confession_reminder_time');
    await DatabaseService().deleteSetting('confession_reminder_days');
    
    // Use ReminderService to delete
    await _reminderService.deleteReminder('confession_reminder');
    notifyListeners();
  }

  Future<void> setConfessionInterval(int? days) async {
    _confessionInterval = days;
    if (days != null) {
      await DatabaseService().saveSetting('confession_interval', days.toString());
      
      // Se não há uma data futura de confissão, calcula uma com base na última confissão ou hoje
      final now = DateTime.now();
      if (_nextConfessionDate == null || _nextConfessionDate!.isBefore(now)) {
        final baseDate = _dataUltimaConfissao ?? now;
        await setNextConfessionDate(baseDate.add(Duration(days: days)));
        
        // Auto re-agenda a notificação se as preferências existirem, senão com default de 1 dia de antecedência
        final currentTime = confessionReminderTime;
        final currentDays = confessionReminderDays;
        
        if (currentTime != null) {
          await setConfessionReminder(currentTime, daysInAdvance: currentDays ?? 1);
        }
      }
    } else {
      await DatabaseService().deleteSetting('confession_interval');
    }
    notifyListeners();
  }

  Future<void> deleteConfession(int index) async {
    if (index >= 0 && index < _confessionHistory.length) {
      final entry = _confessionHistory[index];
      final dateToRemove = entry['date'] as DateTime;
      _confessionHistory.removeAt(index);
      await DatabaseService().deleteConfessionByDate(dateToRemove);
      notifyListeners();
    }
  }

  Future<void> togglePenanceCompleted(int confessionId, bool completed) async {
    await DatabaseService().updatePenanceCompleted(confessionId, completed);
    // Update local state
    final idx = _confessionHistory.indexWhere((e) => e['id'] == confessionId);
    if (idx != -1) {
      _confessionHistory[idx] = Map<String, dynamic>.from(_confessionHistory[idx])
        ..['penanceCompleted'] = completed;
    }
    if (completed) {
      await cancelPenanceReminder();
    }
    notifyListeners();
  }

  Future<void> setPenanceReminder(String penanceText, TimeOfDay time) async {
    final now = DateTime.now();
    var reminderDate = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    
    // If time has passed today, schedule for tomorrow
    if (reminderDate.isBefore(now)) {
      reminderDate = reminderDate.add(const Duration(days: 1));
    }

    final reminderTitle = await NotificationStrings.getPenanceReminderTitle();
    
    final penanceReminder = ReminderModel(
      id: 'penance_reminder',
      title: reminderTitle,
      description: penanceText, // Use penance text as description
      type: ReminderType.penance,
      times: [time],
      recurrence: RecurrenceType.once,
      startDate: reminderDate,
      createdAt: DateTime.now(),
      prayerId: 'penance',
    );
    
    await _reminderService.createOrUpdateUnifiedReminder(penanceReminder);
    notifyListeners();
  }

  Future<void> cancelPenanceReminder() async {
    await _reminderService.deleteReminder('penance_reminder');
    notifyListeners();
  }

  /// Apaga o exame, o histórico de confissões e as datas (senha esquecida).
  Future<void> apagarDadosDoExame() async {
    await DatabaseService().wipeExamData();
    _pecados.clear();
    _confessionHistory = [];
    _dataUltimaConfissao = null;
    _nextConfessionDate = null;
    _confessionInterval = null;
    await _reminderService.deleteReminder('confession_reminder');
    await _reminderService.deleteReminder('penance_reminder');
    notifyListeners();
  }

  Future<void> limparDados() async {
    _pecados.clear();
    await DatabaseService().clearPecados();
    notifyListeners();
  }
}
