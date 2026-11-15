import 'package:flutter/material.dart';
import 'package:sanctaconscientia/services/database_service.dart';
import 'package:sanctaconscientia/services/notification_service.dart';
import 'package:sanctaconscientia/services/reminder_service.dart';
import 'package:sanctaconscientia/models/reminder_model.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sanctaconscientia/utils/notification_strings.dart';

enum LiturgicalType {
  precept,
  fasting,
  abstinence,
}

class LiturgicalProvider extends ChangeNotifier {
  bool _notifyPrecept = true;
  bool _notifyFasting = true;
  bool _notifyAbstinence = true;
  TimeOfDay _notificationTime = const TimeOfDay(hour: 8, minute: 0);
  bool _isInitialized = false;
  bool _notificationsScheduledThisSession = false; // Evita re-agendamento redundante

  // Dependencies
  final ReminderService _reminderService;

  LiturgicalProvider({ReminderService? reminderService}) 
      : _reminderService = reminderService ?? ReminderService(
          databaseService: DatabaseService(),
          notificationService: NotificationService(),
        );

  bool get notifyPrecept => _reminderService.getReminderById('liturgical_precept')?.isActive ?? _notifyPrecept;
  bool get notifyAbstinence => _reminderService.getReminderById('liturgical_abstinence')?.isActive ?? _notifyAbstinence;
  bool get notifyFasting => _reminderService.getReminderById('liturgical_ash_wednesday')?.isActive ?? _notifyFasting;
  
  TimeOfDay get notificationTime {
    final existing = _reminderService.getReminderById('liturgical_precept');
    if (existing != null && existing.times.isNotEmpty) {
      return existing.times.first;
    }
    return _notificationTime;
  }
  bool get isInitialized => _isInitialized;

  Future<void> loadSettings() async {
    final dbService = DatabaseService();
    final prefs = await SharedPreferences.getInstance(); // Use SharedPreferences for settings

    _notifyPrecept = prefs.getBool('liturgical_notify_precept') ?? true;
    _notifyFasting = prefs.getBool('liturgical_notify_fasting') ?? true;
    _notifyAbstinence = prefs.getBool('liturgical_notify_abstinence') ?? true;

    final timeStr = prefs.getString('liturgical_notification_time');
    if (timeStr != null) {
      final parts = timeStr.split(':');
      if (parts.length == 2) {
        _notificationTime = TimeOfDay(
          hour: int.tryParse(parts[0]) ?? 8, 
          minute: int.tryParse(parts[1]) ?? 0
        );
      }
    }

    _isInitialized = true;
    notifyListeners();
    
    // Verificar e criar lembretes litúrgicos (apenas se não foram criados nesta sessão)
    // NOTA: As notificações em si serão agendadas pelo rescheduleAllActiveReminders()
    // chamado no AppState.loadReminders(). Aqui apenas garantimos que os MODELOS
    // existam no banco de dados.
    if (!_notificationsScheduledThisSession) {
      await _checkAndScheduleNotifications();
      _notificationsScheduledThisSession = true;
    }
  }

  Future<void> setNotifyPrecept(bool value) async {
    _notifyPrecept = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('liturgical_notify_precept', value);
    
    final existing = _reminderService.getReminderById('liturgical_precept');
    if (existing != null) {
      final updated = existing.copyWith(isActive: value);
      await _reminderService.createOrUpdateUnifiedReminder(updated);
    } else {
      await _checkAndScheduleNotifications();
    }
    notifyListeners();
  }

  Future<void> setNotifyFasting(bool value) async {
    _notifyFasting = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('liturgical_notify_fasting', value);
    
    final ashWed = _reminderService.getReminderById('liturgical_ash_wednesday');
    final goodFri = _reminderService.getReminderById('liturgical_good_friday');
    
    if (ashWed != null || goodFri != null) {
      if (ashWed != null) {
        await _reminderService.createOrUpdateUnifiedReminder(ashWed.copyWith(isActive: value));
      }
      if (goodFri != null) {
        await _reminderService.createOrUpdateUnifiedReminder(goodFri.copyWith(isActive: value));
      }
    } else {
      await _checkAndScheduleNotifications();
    }
    notifyListeners();
  }

  Future<void> setNotifyAbstinence(bool value) async {
    _notifyAbstinence = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('liturgical_notify_abstinence', value);
    
    final existing = _reminderService.getReminderById('liturgical_abstinence');
    if (existing != null) {
      final updated = existing.copyWith(isActive: value);
      await _reminderService.createOrUpdateUnifiedReminder(updated);
    } else {
      await _checkAndScheduleNotifications();
    }
    notifyListeners();
  }

  Future<void> setNotificationTime(TimeOfDay time) async { // Changed parameter type to TimeOfDay
    _notificationTime = time;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'liturgical_notification_time', '${time.hour}:${time.minute}'); // Store as HH:mm
        
    final ids = [
      'liturgical_precept',
      'liturgical_abstinence',
      'liturgical_ash_wednesday',
      'liturgical_good_friday'
    ];
    for (final id in ids) {
       final existing = _reminderService.getReminderById(id);
       if (existing != null) {
          final updated = existing.copyWith(times: [time]);
          await _reminderService.createOrUpdateUnifiedReminder(updated);
       }
    }
    notifyListeners();
    // Forçar re-agendamento quando o horário muda
    _notificationsScheduledThisSession = false;
    _checkAndScheduleNotifications(); // Re-schedule all notifications with the new time
    _notificationsScheduledThisSession = true;
  }

  /// Returns true if the given date is a Day of Precept (Holy Day of Obligation).
  bool isDayOfPrecept(DateTime date) {
    // 1. Sundays
    if (date.weekday == DateTime.sunday) return true;

    // 2. Fixed Dates
    // Mother of God (Jan 1)
    if (date.month == 1 && date.day == 1) return true;
    
    // Immaculate Conception (Dec 8)
    if (date.month == 12 && date.day == 8) return true;
    
    // Christmas (Dec 25)
    if (date.month == 12 && date.day == 25) return true;

    // 3. Variable Dates (Corpus Christi)
    final easter = _calculateEaster(date.year);
    // Corpus Christi is 60 days after Easter
    final corpusChristi = easter.add(const Duration(days: 60));
    
    if (date.year == corpusChristi.year && 
        date.month == corpusChristi.month && 
        date.day == corpusChristi.day) {
      return true;
    }

    return false;
  }

  /// Returns true if the given date is a Day of Fasting (Ash Wednesday & Good Friday).
  bool isDayOfFasting(DateTime date) {
    final easter = _calculateEaster(date.year);
    final ashWednesday = easter.subtract(const Duration(days: 46));
    final goodFriday = easter.subtract(const Duration(days: 2));

    // Ash Wednesday
    if (date.year == ashWednesday.year && 
        date.month == ashWednesday.month && 
        date.day == ashWednesday.day) {
      return true;
    }

    // Good Friday
    if (date.year == goodFriday.year && 
        date.month == goodFriday.month && 
        date.day == goodFriday.day) {
      return true;
    }

    return false;
  }

  /// Returns true if the given date is a Day of Abstinence (Fridays).
  /// Note: Ash Wednesday and Good Friday are also days of abstinence, but handled by isDayOfFasting for priority.
  bool isDayOfAbstinence(DateTime date) {
    // If it is already a fasting day (which implies abstinence), we don't need to mark it as just abstinence
    // unless we want to show both. But usually Fasting > Abstinence in hierarchy.
    // However, for the UI, we might want to know if it is specifically a Friday abstinence.
    
    if (date.weekday == DateTime.friday) {
      // Exception: If a fixed Solemnity falls on a Friday, abstinence is lifted.
      if ((date.month == 1 && date.day == 1) || // Mary Mother of God
          (date.month == 3 && date.day == 19) || // St Joseph
          (date.month == 3 && date.day == 25) || // Annunciation
          (date.month == 10 && date.day == 12) || // NS Aparecida
          (date.month == 12 && date.day == 8) || // Immaculate Conception
          (date.month == 12 && date.day == 25)) { // Christmas
        return false;
      }
      
      // Good Friday is already covered by Fasting, but it is also Abstinence.
      // We return true here, and the UI can decide how to display.
      return true;
    }

    return false;
  }

  /// Returns a list of liturgical types for the day
  List<LiturgicalType> getLiturgicalTypes(DateTime date) {
    final List<LiturgicalType> types = [];

    if (isDayOfPrecept(date)) {
      types.add(LiturgicalType.precept);
    }

    if (isDayOfFasting(date)) {
      types.add(LiturgicalType.fasting);
    }

    // If it's fasting, it's also abstinence, but we might want to distinguish "Friday Abstinence"
    if (isDayOfAbstinence(date) && !isDayOfFasting(date)) {
      types.add(LiturgicalType.abstinence);
    }

    return types;
  }

  /// Returns a display string for the day's liturgical status using localization
  String? getLiturgicalInfo(BuildContext context, DateTime date) {
    final types = getLiturgicalTypes(date);
    if (types.isEmpty) return null;

    final l10n = AppLocalizations.of(context)!;
    final List<String> infos = [];

    for (final type in types) {
      switch (type) {
        case LiturgicalType.precept:
          infos.add(l10n.preceptDayLabel);
          break;
        case LiturgicalType.fasting:
          infos.add(l10n.fastingDayLabel);
          break;
        case LiturgicalType.abstinence:
          infos.add(l10n.abstinenceDayLabel);
          break;
      }
    }

    return infos.join(" • ");
  }

  /// Calculates Easter Sunday for a given year using the anonymous algorithm (Meeus/Jones/Butcher).
  DateTime _calculateEaster(int year) {
    final a = year % 19;
    final b = year ~/ 100;
    final c = year % 100;
    final d = b ~/ 4;
    final e = b % 4;
    final f = (b + 8) ~/ 25;
    final g = (b - f + 1) ~/ 3;
    final h = (19 * a + b - d - g + 15) % 30;
    final i = c ~/ 4;
    final k = c % 4;
    final l = (32 + 2 * e + 2 * i - h - k) % 7;
    final m = (a + 11 * h + 22 * l) ~/ 451;
    final month = (h + l - 7 * m + 114) ~/ 31;
    final day = ((h + l - 7 * m + 114) % 31) + 1;

    return DateTime(year, month, day);
  }

  /// Recria os avisos litúrgicos com os textos no idioma atual (usado ao trocar de idioma).
  Future<void> refreshNotificationTexts() => _checkAndScheduleNotifications();

  Future<void> _checkAndScheduleNotifications() async {
    // 1. Precept Day Notification (Sundays)
    final existingPrecept = _reminderService.getReminderById('liturgical_precept');
    final preceptReminder = ReminderModel(
      id: 'liturgical_precept',
      title: await NotificationStrings.getPreceptTitle(),
      description: await NotificationStrings.getPreceptBody(),
      type: ReminderType.custom,
      times: existingPrecept?.times ?? [_notificationTime],
      recurrence: RecurrenceType.weekly,
      weekDays: [DateTime.sunday],
      createdAt: existingPrecept?.createdAt ?? DateTime.now(),
      prayerId: 'precept',
      isActive: existingPrecept?.isActive ?? _notifyPrecept,
    );
    await _reminderService.createOrUpdateUnifiedReminder(preceptReminder);

    // 2. Abstinence Day Notification (Fridays)
    final existingAbstinence = _reminderService.getReminderById('liturgical_abstinence');
    final abstinenceReminder = ReminderModel(
       id: 'liturgical_abstinence',
       title: await NotificationStrings.getAbstinenceTitle(),
       description: await NotificationStrings.getAbstinenceBody(),
       type: ReminderType.custom,
       times: existingAbstinence?.times ?? [_notificationTime],
       recurrence: RecurrenceType.weekly,
       weekDays: [DateTime.friday],
       createdAt: existingAbstinence?.createdAt ?? DateTime.now(),
       prayerId: 'abstinence',
       isActive: existingAbstinence?.isActive ?? _notifyAbstinence,
    );
    await _reminderService.createOrUpdateUnifiedReminder(abstinenceReminder);
    
    // 3. Fasting Days (Ash Wednesday & Good Friday)
    final now = DateTime.now();
    final easter = _calculateEaster(now.year);
    final ashWednesday = easter.subtract(const Duration(days: 46));
    final goodFriday = easter.subtract(const Duration(days: 2));
    
    final existingAsh = _reminderService.getReminderById('liturgical_ash_wednesday');
    final ashWedReminder = ReminderModel(
      id: 'liturgical_ash_wednesday',
      title: await NotificationStrings.getFastingTitle(),
      description: await NotificationStrings.getAshWednesdayBody(),
      type: ReminderType.custom,
      times: existingAsh?.times ?? [_notificationTime],
      recurrence: RecurrenceType.once,
      startDate: ashWednesday,
      createdAt: existingAsh?.createdAt ?? DateTime.now(),
      prayerId: 'ash_wednesday',
      isActive: existingAsh?.isActive ?? _notifyFasting,
    );
    await _reminderService.createOrUpdateUnifiedReminder(ashWedReminder);
    
    final existingGood = _reminderService.getReminderById('liturgical_good_friday');
    final goodFriReminder = ReminderModel(
      id: 'liturgical_good_friday',
      title: await NotificationStrings.getFastingTitle(),
      description: await NotificationStrings.getGoodFridayBody(),
      type: ReminderType.custom,
      times: existingGood?.times ?? [_notificationTime],
      recurrence: RecurrenceType.once,
      startDate: goodFriday,
      createdAt: existingGood?.createdAt ?? DateTime.now(),
      prayerId: 'good_friday',
      isActive: existingGood?.isActive ?? _notifyFasting,
    );
    await _reminderService.createOrUpdateUnifiedReminder(goodFriReminder);
  }
}
