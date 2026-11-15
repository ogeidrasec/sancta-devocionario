import 'package:flutter/material.dart';
import 'package:sanctaconscientia/models/reminder_model.dart';
import 'package:sanctaconscientia/services/database_service.dart';
import 'package:sanctaconscientia/services/notification_service.dart';
import 'package:sanctaconscientia/utils/notification_strings.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Service to manage reminders/notifications
class ReminderService {
  final DatabaseService _databaseService;
  final NotificationService _notificationService;
  
  VoidCallback? onRemindersChanged;

  void _notifyListeners() {
    onRemindersChanged?.call();
  }
  
  List<ReminderModel> _reminders = [];
  
  ReminderService({
    required DatabaseService databaseService,
    required NotificationService notificationService,
  })  : _databaseService = databaseService,
        _notificationService = notificationService;

  /// Get all reminders
  List<ReminderModel> getAllReminders() => List.unmodifiable(_reminders);

  /// Get active reminders only
  List<ReminderModel> getActiveReminders() =>
      _reminders.where((r) => r.isActive).toList();

  /// Get reminder by ID
  ReminderModel? getReminderById(String id) {
    try {
      return _reminders.firstWhere((r) => r.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Get reminders by type
  List<ReminderModel> getRemindersByType(ReminderType type) =>
      _reminders.where((r) => r.type == type).toList();

  /// Load all reminders from database
  /// Load all reminders from database
  Future<void> loadReminders() async {
    final jsonMaps = await _databaseService.loadReminders();
    _reminders = jsonMaps.map((json) => ReminderModel.fromJson(json as Map<String, dynamic>)).toList();
    debugPrint("ReminderService: Carregados ${_reminders.length} lembretes do banco de dados.");
    _notifyListeners();
  }

  /// Reagenda todas as notificações para lembretes ativos
  /// Cancela TODAS as notificações existentes antes de reagendar para evitar duplicatas.
  Future<void> rescheduleAllActiveReminders() async {
    // 1. Cancelar todas as notificações existentes de TODOS os reminders
    for (final reminder in _reminders) {
      await _cancelNotifications(reminder);
    }
    
    // 2. Reagendar apenas os ativos
    for (final reminder in _reminders.where((r) => r.isActive)) {
      await scheduleNotifications(reminder);
    }
  }

  /// Create a new reminder
  Future<ReminderModel> createReminder(ReminderModel reminder) async {
    // Save to database
    await _databaseService.saveReminder(reminder);
    
    // Add to local list
    _reminders.add(reminder);
    
    // Schedule notifications if active
    if (reminder.isActive) {
      await scheduleNotifications(reminder);
    }
    
    _notifyListeners();
    return reminder;
  }

  /// Update existing reminder
  Future<void> updateReminder(ReminderModel reminder) async {
    // Find index
    final index = _reminders.indexWhere((r) => r.id == reminder.id);
    if (index == -1) {
      throw Exception('Reminder not found: ${reminder.id}');
    }
    
    // Cancel old notifications
    final oldReminder = _reminders[index];
    await _cancelNotifications(oldReminder);
    
    // Update in database
    await _databaseService.updateReminder(reminder);
    
    // Update in local list
    _reminders[index] = reminder;
    
    // Schedule new notifications if active
    if (reminder.isActive) {
      await scheduleNotifications(reminder);
    }
    _notifyListeners();
  }

  Future<void> createOrUpdateUnifiedReminder(ReminderModel reminder) async {
    final existing = getReminderById(reminder.id);
    if (existing != null) {
      debugPrint("ReminderService: Atualizando lembrete unificado '${reminder.id}'");
      await updateReminder(reminder);
    } else {
      debugPrint("ReminderService: Criando novo lembrete unificado '${reminder.id}'");
      await createReminder(reminder);
    }
  }

  /// Toggle reminder active state
  Future<void> toggleActive(String id) async {
    final reminder = getReminderById(id);
    if (reminder == null) return;
    
    final updated = reminder.copyWith(isActive: !reminder.isActive);
    await updateReminder(updated);
  }

  /// Delete reminder
  Future<void> deleteReminder(String id) async {
    final reminder = getReminderById(id);
    if (reminder == null) return;
    
    // Cancel notifications
    await _cancelNotifications(reminder);
    
    // Delete from database
    await _databaseService.deleteReminder(id);
    
    // Remove from local list
    _reminders.removeWhere((r) => r.id == id);
    _notifyListeners();
  }

  /// Schedule all notifications for a reminder
  /// Cancela notificações existentes do reminder antes de agendar novas (idempotente).
  Future<Map<String, String>> _getChannelDetails(ReminderType type) async {
    switch (type) {
      case ReminderType.confession:
        return {
          'id': 'confession_channel',
          'name': await NotificationStrings.text('channelConfessionName'),
          'desc': await NotificationStrings.text('channelConfessionDesc'),
        };
      case ReminderType.novena:
        return {
          'id': 'novena_channel',
          'name': await NotificationStrings.text('channelNovenaName'),
          'desc': await NotificationStrings.text('channelNovenaDesc'),
        };
      default:
        return {
          'id': 'daily_prayer_channel',
          'name': await NotificationStrings.text('channelPrayerName'),
          'desc': await NotificationStrings.text('channelPrayerDesc'),
        };
    }
  }

  Future<void> scheduleNotifications(ReminderModel reminder) async {
    if (!reminder.isActive) return;
    
    // Cancelar notificações anteriores deste reminder para evitar duplicatas
    await _cancelNotifications(reminder);
    
    debugPrint("ReminderService: Agendando notificações para '${reminder.id}' (${reminder.type})");
    final List<int> notificationIds = [];
    final channelInfo = await _getChannelDetails(reminder.type);
    
    switch (reminder.recurrence) {
      case RecurrenceType.once:
        // Schedule single notification
        if (reminder.startDate != null && reminder.times.isNotEmpty) {
          for (final time in reminder.times) {
            final scheduledDate = DateTime(
              reminder.startDate!.year,
              reminder.startDate!.month,
              reminder.startDate!.day,
              time.hour,
              time.minute,
            );
            
            if (scheduledDate.isAfter(DateTime.now())) {
              final notifId = _generateNotificationId(reminder.id, time);
              notificationIds.add(notifId);
              
              // Usar título e corpo específicos para confissão e novena
                String title;
                if (reminder.type == ReminderType.confession) {
                  title = await NotificationStrings.getConfessionReminderTitle();
                } else if (reminder.type == ReminderType.novena) {
                  title = await NotificationStrings.getNovenaReminderTitle();
                } else if (reminder.type == ReminderType.penance) {
                  title = await NotificationStrings.getPenanceReminderTitle();
                } else if (reminder.type == ReminderType.custom) {
                  title = reminder.title;
                } else {
                  title = await NotificationStrings.getPrayerReminderTitle();
                }
              
              final body = reminder.type == ReminderType.confession
                  ? reminder.description ?? reminder.title
                  : (reminder.type == ReminderType.custom 
                        ? (reminder.description ?? reminder.title)
                        : reminder.title);
              
              await _notificationService.scheduleNotification(
                id: notifId,
                title: title,
                body: body,
                scheduledDate: scheduledDate,
                payload: reminder.prayerId ?? reminder.novenaId,
                channelId: channelInfo['id']!,
                channelName: channelInfo['name']!,
                channelDescription: channelInfo['desc']!,
              );
            }
          }
        }
        break;

        
      case RecurrenceType.daily:
        if (reminder.maxOccurrences != null && reminder.startDate != null) {
          // Limited occurrences (e.g. Novena 9 days)
          // Schedule discrete notifications for each day
          for (final time in reminder.times) {
            for (int i = 0; i < reminder.maxOccurrences!; i++) {
              final date = reminder.startDate!.add(Duration(days: i));
              final scheduledDate = DateTime(
                date.year,
                date.month,
                date.day,
                time.hour,
                time.minute,
              );
              
              if (scheduledDate.isAfter(DateTime.now())) {
                final notifId = _generateNotificationId(reminder.id, time, weekDay: i); // Use 'i' to differentiate IDs
                notificationIds.add(notifId);
                
                String title;
                if (reminder.type == ReminderType.novena) {
                  title = await NotificationStrings.getNovenaReminderTitle();
                } else if (reminder.type == ReminderType.penance) {
                  title = await NotificationStrings.getPenanceReminderTitle();
                } else if (reminder.type == ReminderType.rosary) {
                  title = await NotificationStrings.getRosaryReminderTitle();
                } else if (reminder.type == ReminderType.custom) {
                  title = reminder.title;
                } else {
                  title = await NotificationStrings.getPrayerReminderTitle();
                }
                
                final dayNum = i + 1;
                final body = reminder.type == ReminderType.novena 
                    ? '${reminder.title} - ${await NotificationStrings.novenaDay(dayNum)}' 
                    : (reminder.type == ReminderType.custom 
                        ? (reminder.description ?? reminder.title)
                        : reminder.title);

                await _notificationService.scheduleNotification(
                  id: notifId,
                  title: title,
                  body: body,
                  scheduledDate: scheduledDate,
                  payload: reminder.prayerId ?? reminder.novenaId,
                  channelId: channelInfo['id']!,
                  channelName: channelInfo['name']!,
                  channelDescription: channelInfo['desc']!,
                );
              }
            }
          }
        } else {
          // Schedule daily repeating notifications (Infinite)
          for (final time in reminder.times) {
            final notifId = _generateNotificationId(reminder.id, time);
            notificationIds.add(notifId);
            
            String title;
            if (reminder.type == ReminderType.novena) {
              title = await NotificationStrings.getNovenaReminderTitle();
            } else if (reminder.type == ReminderType.penance) {
              title = await NotificationStrings.getPenanceReminderTitle();
            } else if (reminder.type == ReminderType.rosary) {
              title = await NotificationStrings.getRosaryReminderTitle();
            } else if (reminder.type == ReminderType.custom) {
              title = reminder.title;
            } else {
              title = await NotificationStrings.getPrayerReminderTitle();
            }
            
            await _notificationService.scheduleDailyNotification(
              id: notifId,
              title: title,
              body: reminder.type == ReminderType.custom ? (reminder.description ?? reminder.title) : reminder.title,
              time: time,
              payload: reminder.prayerId ?? reminder.novenaId,
              channelId: channelInfo['id']!,
              channelName: channelInfo['name']!,
              channelDescription: channelInfo['desc']!,
            );
          }
        }
        break;
        
      case RecurrenceType.weekly:
        // Schedule for each day of week
        if (reminder.weekDays != null) {
          for (final time in reminder.times) {
            for (final weekDay in reminder.weekDays!) {
              final notifId = _generateNotificationId(
                reminder.id,
                time,
                weekDay: weekDay,
              );
              notificationIds.add(notifId);
              
              // Find next occurrence of this weekday+time
              final nextOccurrence = _findNextWeekdayOccurrence(weekDay, time);
              
              String title;
              if (reminder.type == ReminderType.novena) {
                title = await NotificationStrings.getNovenaReminderTitle();
              } else if (reminder.type == ReminderType.penance) {
                title = await NotificationStrings.getPenanceReminderTitle();
              } else if (reminder.type == ReminderType.rosary) {
                title = await NotificationStrings.getRosaryReminderTitle();
              } else if (reminder.type == ReminderType.custom) {
                title = reminder.title;
              } else {
                title = await NotificationStrings.getPrayerReminderTitle();
              }
              await _notificationService.scheduleRepeatingNotification(
                id: notifId,
                title: title,
                body: reminder.type == ReminderType.custom ? (reminder.description ?? reminder.title) : reminder.title,
                scheduledDate: nextOccurrence,
                matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
                payload: reminder.prayerId ?? reminder.novenaId,
                channelId: channelInfo['id']!,
                channelName: channelInfo['name']!,
                channelDescription: channelInfo['desc']!,
              );
            }
          }
        }
        break;
        
      case RecurrenceType.monthly:
        // Schedule for specific day of month
        if (reminder.monthDay != null) {
          for (final time in reminder.times) {
            final notifId = _generateNotificationId(reminder.id, time);
            notificationIds.add(notifId);
            
            // Find next occurrence of this day
            final nextOccurrence = _findNextMonthDayOccurrence(
              reminder.monthDay!,
              time,
            );
            
            String title;
            if (reminder.type == ReminderType.novena) {
              title = await NotificationStrings.getNovenaReminderTitle();
            } else if (reminder.type == ReminderType.penance) {
              title = await NotificationStrings.getPenanceReminderTitle();
            } else if (reminder.type == ReminderType.rosary) {
              title = await NotificationStrings.getRosaryReminderTitle();
            } else if (reminder.type == ReminderType.custom) {
              title = reminder.title;
            } else {
              title = await NotificationStrings.getPrayerReminderTitle();
            }
            await _notificationService.scheduleRepeatingNotification(
              id: notifId,
              title: title,
              body: reminder.type == ReminderType.custom ? (reminder.description ?? reminder.title) : reminder.title,
              scheduledDate: nextOccurrence,
              matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
              payload: reminder.prayerId ?? reminder.novenaId,
              channelId: channelInfo['id']!,
              channelName: channelInfo['name']!,
              channelDescription: channelInfo['desc']!,
            );
          }
        }
        break;
        
      case RecurrenceType.custom:
        // Custom logic - placeholder for future
        break;
    }
    
    // Update reminder with notification IDs
    final updated = reminder.copyWith(notificationIds: notificationIds);
    final index = _reminders.indexWhere((r) => r.id == reminder.id);
    if (index != -1) {
      _reminders[index] = updated;
      await _databaseService.updateReminder(updated);
    }
    debugPrint("ReminderService: Agendadas ${notificationIds.length} notificações para '${reminder.id}'. IDs: $notificationIds");
  }

  /// Cancel all notifications for a reminder
  Future<void> _cancelNotifications(ReminderModel reminder) async {
    if (reminder.notificationIds.isNotEmpty) {
      debugPrint("ReminderService: Cancelando ${reminder.notificationIds.length} notificações antigas para '${reminder.id}'. IDs: ${reminder.notificationIds}");
    }
    for (final notifId in reminder.notificationIds) {
      await _notificationService.cancelNotification(notifId);
    }
  }

  /// Generate unique notification ID
  int _generateNotificationId(String reminderId, TimeOfDay time, {int? weekDay}) {
    // Generate a deterministic 32-bit hash for the string mixed with time/weekday
    int hash = 5381;
    final timeStr = "${time.hour}:${time.minute}_${weekDay ?? 0}";
    final combinedStr = "${reminderId}_$timeStr";
    for (int i = 0; i < combinedStr.length; i++) {
      hash = ((hash << 5) + hash) + combinedStr.codeUnitAt(i);
      hash = hash & 0xFFFFFFFF; // Keep it 32-bit
    }
    return hash.abs() % 2147483647;
  }

  /// Find next occurrence of a specific weekday and time
  DateTime _findNextWeekdayOccurrence(int targetWeekday, TimeOfDay time) {
    final now = DateTime.now();
    DateTime candidate = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    
    // Find next occurrence of target weekday
    while (candidate.weekday != targetWeekday || candidate.isBefore(now)) {
      candidate = candidate.add(const Duration(days: 1));
    }
    
    return candidate;
  }

  /// Find next occurrence of a specific day of month and time
  DateTime _findNextMonthDayOccurrence(int targetDay, TimeOfDay time) {
    final now = DateTime.now();
    DateTime candidate = DateTime(now.year, now.month, targetDay, time.hour, time.minute);
    
    // If already passed, try next month
    if (candidate.isBefore(now) || candidate.day != targetDay) {
      candidate = DateTime(now.year, now.month + 1, targetDay, time.hour, time.minute);
    }
    
    return candidate;
  }

  /// Get statistics about reminders
  Map<String, dynamic> getStatistics() {
    final activeReminders = getActiveReminders();

    
    // Find next reminder
    ReminderModel? nextReminder;
    DateTime? nextOccurrence;
    
    for (final reminder in activeReminders) {
      final occurrence = reminder.calculateNextOccurrence();
      if (occurrence != null) {
        if (nextOccurrence == null || occurrence.isBefore(nextOccurrence)) {
          nextOccurrence = occurrence;
          nextReminder = reminder;
        }
      }
    }
    
    // Count completed today (placeholder - needs integration with prayer logs)
    final completedToday = 0;
    
    return {
      'totalActive': activeReminders.length,
      'totalReminders': _reminders.length,
      'nextReminder': nextReminder,
      'nextOccurrence': nextOccurrence,
      'completedToday': completedToday,
    };
  }

  /// Get reminders grouped by type
  Map<ReminderType, List<ReminderModel>> getGroupedReminders() {
    final grouped = <ReminderType, List<ReminderModel>>{};
    
    for (final reminder in _reminders) {
      grouped.putIfAbsent(reminder.type, () => []);
      grouped[reminder.type]!.add(reminder);
    }
    
    return grouped;
  }

  /// Migrate existing prayer reminders from AppState
  Future<void> migrateExistingReminders({
    required List<Map<String, String>> existingPrayers,
    required DateTime? nextConfessionDate,
    required TimeOfDay? confessionReminderTime,
    required int? confessionReminderDays,
  }) async {
    // Migrate confession reminder if exists
    if (nextConfessionDate != null && confessionReminderTime != null) {
      final confessionTitle = await NotificationStrings.getConfessionReminderTitle();
      final confessionReminder = ReminderModel(
        id: 'confession_reminder',
        title: confessionTitle,
        type: ReminderType.confession,
        times: [confessionReminderTime],
        recurrence: RecurrenceType.once,
        startDate: nextConfessionDate.subtract(
          Duration(days: confessionReminderDays ?? 0),
        ),
        createdAt: DateTime.now(),
        prayerId: 'confession',
      );
      
      // Check if doesn't already exist
      if (getReminderById(confessionReminder.id) == null) {
        await createReminder(confessionReminder);
      }
    }
    
    // Migrate prayer reminders
    for (final prayer in existingPrayers) {
      final prayerId = prayer['id'];
      final reminderTimeStr = prayer['reminderTime'];
      final frequency = prayer['frequency'] ?? 'daily';
      
      if (prayerId != null && reminderTimeStr != null) {
        // Parse time
        final timeParts = reminderTimeStr.split(':');
        if (timeParts.length != 2) continue;
        
        final time = TimeOfDay(
          hour: int.parse(timeParts[0]),
          minute: int.parse(timeParts[1]),
        );
        
        // Determine recurrence type
        RecurrenceType recurrence;
        switch (frequency) {
          case 'daily':
            recurrence = RecurrenceType.daily;
            break;
          case 'weekly':
            recurrence = RecurrenceType.weekly;
            break;
          case 'monthly':
            recurrence = RecurrenceType.monthly;
            break;
          case 'once':
            recurrence = RecurrenceType.once;
            break;
          default:
            recurrence = RecurrenceType.daily;
        }
        
        // Determine type
        ReminderType type;
        if (prayerId.contains('rosary')) {
          type = ReminderType.rosary;
        } else if (prayerId.contains('examination') || prayerId.contains('exame')) {
          type = ReminderType.examination;
        } else if (prayerId.contains('novena')) {
          type = ReminderType.novena;
        } else {
          type = ReminderType.prayer;
        }
        
        final reminder = ReminderModel(
          id: 'prayer_$prayerId',
          title: prayer['title'] ?? await NotificationStrings.text('prayerFallback'),
          type: type,
          times: [time],
          recurrence: recurrence,
          createdAt: DateTime.now(),
          prayerId: prayerId,
        );
        
        // Check if doesn't already exist
        if (getReminderById(reminder.id) == null) {
          await createReminder(reminder);
        }
      }
    }
  }
}
