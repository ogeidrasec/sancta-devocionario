/// Model for scheduled prayers with recurrence support
class ScheduledPrayer {
  final String id;
  final String prayerId;
  final String title;
  final DateTime startDate;
  final int? scheduledHour;
  final int? scheduledMinute;
  final RecurrenceType recurrenceType;
  final int? repeatCount; // null = infinite
  int completedCount;
  bool isActive;

  ScheduledPrayer({
    required this.id,
    required this.prayerId,
    required this.title,
    required this.startDate,
    this.scheduledHour,
    this.scheduledMinute,
    this.recurrenceType = RecurrenceType.once,
    this.repeatCount,
    this.completedCount = 0,
    this.isActive = true,
  });

  /// Check if this prayer should appear on a given date
  bool shouldAppearOn(DateTime date) {
    if (!isActive) return false;
    
    final dateOnly = DateTime(date.year, date.month, date.day);
    final startOnly = DateTime(startDate.year, startDate.month, startDate.day);
    
    // Past dates don't show
    if (dateOnly.isBefore(startOnly)) return false;
    
    // Check if we've exceeded repeat count
    if (repeatCount != null && completedCount >= repeatCount!) return false;
    
    switch (recurrenceType) {
      case RecurrenceType.once:
        return dateOnly.isAtSameMomentAs(startOnly);
        
      case RecurrenceType.daily:
        return true; // Appears every day after start
        
      case RecurrenceType.weekly:
        final daysDiff = dateOnly.difference(startOnly).inDays;
        return daysDiff % 7 == 0;
        
      case RecurrenceType.monthly:
        return date.day == startDate.day;
        
      case RecurrenceType.novena:
        // Novena appears for exactly 9 consecutive days
        final daysDiff = dateOnly.difference(startOnly).inDays;
        return daysDiff >= 0 && daysDiff < 9;
    }
  }

  /// Get the day number for novenas (1-9)
  int? getNovenaDay(DateTime date) {
    if (recurrenceType != RecurrenceType.novena) return null;
    
    final dateOnly = DateTime(date.year, date.month, date.day);
    final startOnly = DateTime(startDate.year, startDate.month, startDate.day);
    final daysDiff = dateOnly.difference(startOnly).inDays;
    
    if (daysDiff >= 0 && daysDiff < 9) {
      return daysDiff + 1; // Day 1-9
    }
    return null;
  }

  /// Convert to Map for storage
  Map<String, String> toMap() {
    return {
      'id': id,
      'prayerId': prayerId,
      'title': title,
      'startDate': startDate.toIso8601String(),
      'scheduledHour': scheduledHour?.toString() ?? '',
      'scheduledMinute': scheduledMinute?.toString() ?? '',
      'recurrenceType': recurrenceType.name,
      'repeatCount': repeatCount?.toString() ?? '',
      'completedCount': completedCount.toString(),
      'isActive': isActive.toString(),
    };
  }

  /// Create from Map (storage)
  factory ScheduledPrayer.fromMap(Map<String, dynamic> map) {
    return ScheduledPrayer(
      id: map['id'] as String,
      prayerId: map['prayerId'] as String,
      title: map['title'] as String,
      startDate: DateTime.parse(map['startDate'] as String),
      scheduledHour: map['scheduledHour']?.isNotEmpty == true 
          ? int.parse(map['scheduledHour'] as String) 
          : null,
      scheduledMinute: map['scheduledMinute']?.isNotEmpty == true 
          ? int.parse(map['scheduledMinute'] as String) 
          : null,
      recurrenceType: RecurrenceType.values.firstWhere(
        (e) => e.name == (map['recurrenceType'] as String),
        orElse: () => RecurrenceType.once,
      ),
      repeatCount: map['repeatCount']?.isNotEmpty == true 
          ? int.parse(map['repeatCount'] as String) 
          : null,
      completedCount: int.tryParse(map['completedCount']?.toString() ?? '0') ?? 0,
      isActive: map['isActive'] == 'true',
    );
  }

  /// Create a copy with modifications
  ScheduledPrayer copyWith({
    String? id,
    String? prayerId,
    String? title,
    DateTime? startDate,
    int? scheduledHour,
    int? scheduledMinute,
    RecurrenceType? recurrenceType,
    int? repeatCount,
    int? completedCount,
    bool? isActive,
  }) {
    return ScheduledPrayer(
      id: id ?? this.id,
      prayerId: prayerId ?? this.prayerId,
      title: title ?? this.title,
      startDate: startDate ?? this.startDate,
      scheduledHour: scheduledHour ?? this.scheduledHour,
      scheduledMinute: scheduledMinute ?? this.scheduledMinute,
      recurrenceType: recurrenceType ?? this.recurrenceType,
      repeatCount: repeatCount ?? this.repeatCount,
      completedCount: completedCount ?? this.completedCount,
      isActive: isActive ?? this.isActive,
    );
  }
}

/// Types of recurrence for scheduled prayers
enum RecurrenceType {
  once,     // Single occurrence
  daily,    // Every day
  weekly,   // Every week (same day)
  monthly,  // Every month (same day number)
  novena,   // 9 consecutive days
}

/// Extension for display names
extension RecurrenceTypeExtension on RecurrenceType {
  String get displayName {
    switch (this) {
      case RecurrenceType.once:
        return 'Uma vez';
      case RecurrenceType.daily:
        return 'Diariamente';
      case RecurrenceType.weekly:
        return 'Semanalmente';
      case RecurrenceType.monthly:
        return 'Mensalmente';
      case RecurrenceType.novena:
        return 'Novena (9 dias)';
    }
  }
}
