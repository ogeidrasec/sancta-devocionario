/// Model representing an active novena with progress tracking
class NovenaProgress {
  final String novenaId;
  final DateTime startDate;

  NovenaProgress({
    required this.novenaId,
    required this.startDate,
  });

  /// Returns the current day of the novena (1-9)
  /// Returns 0 if not started, 10+ if completed
  int get currentDay {
    final now = DateTime.now();
    final startOfStartDate = DateTime(startDate.year, startDate.month, startDate.day);
    final startOfToday = DateTime(now.year, now.month, now.day);
    final daysDiff = startOfToday.difference(startOfStartDate).inDays;
    return daysDiff + 1; // Day 1 is the start date
  }

  /// Returns true if the novena is currently active (days 1-9)
  bool get isActive => currentDay >= 1 && currentDay <= 9;

  /// Returns true if all 9 days have been completed
  bool get isCompleted => currentDay > 9;

  /// Converts to a storable format
  Map<String, dynamic> toJson() => {
    'novenaId': novenaId,
    'startDate': startDate.toIso8601String(),
  };

  /// Creates from stored format
  factory NovenaProgress.fromJson(Map<String, dynamic> json) {
    return NovenaProgress(
      novenaId: json['novenaId'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
    );
  }
}
