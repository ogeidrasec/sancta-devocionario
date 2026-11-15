import 'package:flutter/material.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

/// Types of reminders in the app
enum ReminderType {
  prayer,      // Regular prayer
  novena,      // Novena prayer
  examination, // Examination of conscience
  rosary,      // Rosary
  confession,  // Confession reminder
  penance,     // Penance reminder
  custom,      // Custom reminder
}

/// Recurrence patterns for reminders
enum RecurrenceType {
  once,    // One-time reminder
  daily,   // Repeat every day
  weekly,  // Repeat on specific days of week
  monthly, // Repeat on specific day of month
  custom,  // Custom pattern (for future expansion)
}

/// Model representing a reminder/notification
class ReminderModel {
  final String id;
  String title;
  String? description;
  ReminderType type;
  
  // Scheduling - supports multiple times per day
  List<TimeOfDay> times;
  RecurrenceType recurrence;
  int interval; // Recurrence interval (every X days/weeks/months)
  List<int>? weekDays; // 1=Monday, 7=Sunday, null for non-weekly
  int? monthDay; // 1-31, null for non-monthly
  
  // Dates
  DateTime? startDate;
  DateTime? endDate;
  int? maxOccurrences; // For novenas and limited repetitions
  
  // Status
  bool isActive;
  
  // Metadata
  DateTime createdAt;
  DateTime? lastTriggered;
  int completionCount; // How many times completed
  
  // Extension point for future features
  Map<String, dynamic>? metadata;
  
  // Linked IDs (for integration with existing data)
  String? prayerId;
  String? novenaId;
  
  // Notification IDs for cleanup
  List<int> notificationIds;

  ReminderModel({
    required this.id,
    required this.title,
    this.description,
    required this.type,
    required this.times,
    required this.recurrence,
    this.interval = 1,
    this.weekDays,
    this.monthDay,
    this.startDate,
    this.endDate,
    this.maxOccurrences,
    this.isActive = true,
    required this.createdAt,
    this.lastTriggered,
    this.completionCount = 0,
    this.metadata,
    this.prayerId,
    this.novenaId,
    this.notificationIds = const [],
  });

  /// Create a copy with modified fields
  ReminderModel copyWith({
    String? id,
    String? title,
    String? description,
    ReminderType? type,
    List<TimeOfDay>? times,
    RecurrenceType? recurrence,
    int? interval,
    List<int>? weekDays,
    int? monthDay,
    DateTime? startDate,
    DateTime? endDate,
    int? maxOccurrences,
    bool? isActive,
    DateTime? createdAt,
    DateTime? lastTriggered,
    int? completionCount,
    Map<String, dynamic>? metadata,
    String? prayerId,
    String? novenaId,
    List<int>? notificationIds,
  }) {
    return ReminderModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      times: times ?? this.times,
      recurrence: recurrence ?? this.recurrence,
      interval: interval ?? this.interval,
      weekDays: weekDays ?? this.weekDays,
      monthDay: monthDay ?? this.monthDay,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      maxOccurrences: maxOccurrences ?? this.maxOccurrences,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      lastTriggered: lastTriggered ?? this.lastTriggered,
      completionCount: completionCount ?? this.completionCount,
      metadata: metadata ?? this.metadata,
      prayerId: prayerId ?? this.prayerId,
      novenaId: novenaId ?? this.novenaId,
      notificationIds: notificationIds ?? this.notificationIds,
    );
  }

  /// Convert to JSON for database storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type.toString().split('.').last,
      'times': times.map((t) => '${t.hour}:${t.minute}').toList(),
      'recurrence': recurrence.toString().split('.').last,
      'interval': interval,
      'weekDays': weekDays,
      'monthDay': monthDay,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'maxOccurrences': maxOccurrences,
      'isActive': isActive ? 1 : 0,
      'createdAt': createdAt.toIso8601String(),
      'lastTriggered': lastTriggered?.toIso8601String(),
      'completionCount': completionCount,
      'metadata': metadata?.toString(),
      'prayerId': prayerId,
      'novenaId': novenaId,
      'notificationIds': notificationIds.join(','),
    };
  }

  /// Create from JSON data from database
  factory ReminderModel.fromJson(Map<String, dynamic> json) {
    return ReminderModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      type: ReminderType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
        orElse: () => ReminderType.custom,
      ),
      times: (json['times'] as List<dynamic>)
          .map((t) {
            final parts = (t as String).split(':');
            return TimeOfDay(
              hour: int.parse(parts[0]),
              minute: int.parse(parts[1]),
            );
          })
          .toList(),
      recurrence: RecurrenceType.values.firstWhere(
        (e) => e.toString().split('.').last == json['recurrence'],
        orElse: () => RecurrenceType.once,
      ),
      interval: json['interval'] as int? ?? 1,
      weekDays: json['weekDays'] != null
          ? List<int>.from(json['weekDays'] as List)
          : null,
      monthDay: json['monthDay'] as int?,
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'] as String)
          : null,
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'] as String)
          : null,
      maxOccurrences: json['maxOccurrences'] as int?,
      isActive: (json['isActive'] as int) == 1,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastTriggered: json['lastTriggered'] != null
          ? DateTime.parse(json['lastTriggered'] as String)
          : null,
      completionCount: json['completionCount'] as int? ?? 0,
      metadata: json['metadata'] != null
          ? {} // Parse metadata string if needed
          : null,
      prayerId: json['prayerId'] as String?,
      novenaId: json['novenaId'] as String?,
      notificationIds: json['notificationIds'] != null
          ? (json['notificationIds'] as String)
              .split(',')
              .where((s) => s.isNotEmpty)
              .map((s) => int.parse(s))
              .toList()
          : [],
    );
  }

  /// Calculate next occurrence based on current settings
  DateTime? calculateNextOccurrence({DateTime? from}) {
    final now = from ?? DateTime.now();
    
    if (!isActive) return null;
    if (endDate != null && now.isAfter(endDate!)) return null;
    
    // Start from today or startDate, whichever is later
    DateTime baseDate = startDate != null && startDate!.isAfter(now)
        ? startDate!
        : DateTime(now.year, now.month, now.day);
    
    // Find the next valid time today or in the future
    switch (recurrence) {
      case RecurrenceType.once:
        // One-time: return the specific date+time if in future
        if (startDate != null && times.isNotEmpty) {
          final scheduledTime = DateTime(
            startDate!.year,
            startDate!.month,
            startDate!.day,
            times.first.hour,
            times.first.minute,
          );
          return scheduledTime.isAfter(now) ? scheduledTime : null;
        }
        return null;
        
      case RecurrenceType.daily:
        // Find next time today or tomorrow
        for (final time in times) {
          final candidate = DateTime(
            baseDate.year,
            baseDate.month,
            baseDate.day,
            time.hour,
            time.minute,
          );
          if (candidate.isAfter(now)) return candidate;
        }

        // All times passed today, get first time tomorrow (or next interval)
        final nextDate = baseDate.add(Duration(days: interval));
        
        // Check if we exceeded maxOccurrences (for daily recurrence)
        if (maxOccurrences != null && startDate != null) {
          final daysSinceStart = nextDate.difference(startDate!).inDays;
          // If we are calculating a date that is beyond the max occurrences (e.g. day 10 of 9), return null
          if (daysSinceStart >= maxOccurrences!) {
            return null;
          }
        }

        return DateTime(
          nextDate.year,
          nextDate.month,
          nextDate.day,
          times.first.hour,
          times.first.minute,
        );
        
      case RecurrenceType.weekly:
        if (weekDays == null || weekDays!.isEmpty) return null;
        
        // Search for next valid day in the next 7 days
        // Search for next valid day in the next 7 * interval days
        // This logic is simplified; for true "every 2 weeks", we need a reference start date.
        // Assuming baseDate is the anchor.
        // If interval > 1, we only check weeks that match the interval from startDate.
        
        // Find the "current week start" relative to startDate
        // For simplicity in this version, we'll just check the next few weeks if interval is small,
        // but strictly speaking "every 2 weeks" means we skip a week.
        
        // Better logic: Iterate by weeks based on interval
        for (int w = 0; w < 10; w += interval) { // Check next 10 occurrences
           for (int d = 0; d < 7; d++) {
             final testDate = baseDate.add(Duration(days: (w * 7) + d));
             if (testDate.isBefore(now)) continue;
             
             if (weekDays!.contains(testDate.weekday)) {
                for (final time in times) {
                  final candidate = DateTime(
                    testDate.year,
                    testDate.month,
                    testDate.day,
                    time.hour,
                    time.minute,
                  );
                  if (candidate.isAfter(now)) return candidate;
                }
             }
           }
        }
        return null;
        
      case RecurrenceType.monthly:
        if (monthDay == null) return null;
        
        // Find next occurrence of this day of month
        DateTime testDate = DateTime(baseDate.year, baseDate.month, monthDay!);
        
        // If already passed this month, try next interval months
        if (testDate.isBefore(now) || testDate.day != monthDay) {
          testDate = DateTime(baseDate.year, baseDate.month + interval, monthDay!);
        }
        
        // Check if it's a valid date
        if (testDate.day == monthDay) {
          for (final time in times) {
            final candidate = DateTime(
              testDate.year,
              testDate.month,
              testDate.day,
              time.hour,
              time.minute,
            );
            if (candidate.isAfter(now)) return candidate;
          }
        }
        return null;
        
      case RecurrenceType.custom:
        // Placeholder for future complex rules
        return null;
    }
  }

  /// Get human-readable frequency description
  String getFrequencyDescription(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (recurrence) {
      case RecurrenceType.once:
        return l10n.reminderRecurrenceOnce;
      case RecurrenceType.daily:
        return interval > 1 
            ? l10n.reminderFrequencyDailyInterval(interval)
            : l10n.reminderRecurrenceDaily;
      case RecurrenceType.weekly:
        if (weekDays == null || weekDays!.isEmpty) {
          return interval > 1 
              ? l10n.reminderFrequencyWeeklyInterval(interval)
              : l10n.reminderRecurrenceWeekly;
        }
        
        final locale = l10n.localeName;
        final dayNames = weekDays!.map((d) {
          // Use a known Monday (Jan 1, 2024) as base to get weekday names
          final date = DateTime(2024, 1, d); 
          return DateFormat.E(locale).format(date);
        }).join(', ');
        
        return interval > 1 
            ? '$dayNames (${l10n.reminderFrequencyWeeklyInterval(interval)})' 
            : dayNames;
      case RecurrenceType.monthly:
        return interval > 1 
            ? l10n.reminderFrequencyMonthlyInterval(monthDay ?? 1, interval)
            : l10n.reminderFrequencyMonthly(monthDay ?? 1);
      case RecurrenceType.custom:
        return l10n.reminderRecurrenceCustom;
    }
  }

  /// Get formatted times string
  String getTimesString() {
    if (times.isEmpty) return '--:--';
    return times.map((t) {
      final hour = t.hour.toString().padLeft(2, '0');
      final minute = t.minute.toString().padLeft(2, '0');
      return '$hour:$minute';
    }).join(', ');
  }

  /// Get icon for reminder type
  IconData getTypeIcon() {
    switch (type) {
      case ReminderType.prayer:
        return Icons.auto_awesome;
      case ReminderType.novena:
        return Icons.brightness_1;
      case ReminderType.examination:
        return Icons.search;
      case ReminderType.rosary:
        return Icons.radio_button_checked;
      case ReminderType.confession:
        return Icons.church;
      case ReminderType.penance:
        return Icons.volunteer_activism;
      case ReminderType.custom:
        return Icons.notifications;
    }
  }

  /// Get type label
  String getTypeLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    // Check for liturgical reminders specifically
    if (id.startsWith('liturgical_')) {
      return l10n.liturgicalCalendarTitle;
    }

    switch (type) {
      case ReminderType.prayer:
        return l10n.reminderTypePrayer;
      case ReminderType.novena:
        return l10n.reminderTypeNovena;
      case ReminderType.examination:
        return l10n.reminderTypeExamination;
      case ReminderType.rosary:
        return l10n.reminderTypeRosary;
      case ReminderType.confession:
        return l10n.reminderTypeConfession;
      case ReminderType.penance:
        return l10n.reminderTypePenance;
      case ReminderType.custom:
        return l10n.reminderTypeCustom;
    }
  }
}
