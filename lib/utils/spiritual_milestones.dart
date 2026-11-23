import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/providers/confession_provider.dart';
import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/utils/liturgical_calendar.dart';

enum MilestoneCategory { prayer, rosary, mass, devotion }

class SpiritualMilestone {
  final String id;
  final MilestoneCategory category;
  final int target;
  final int current;
  final IconData icon;

  const SpiritualMilestone({
    required this.id,
    required this.category,
    required this.target,
    required this.current,
    required this.icon,
  });

  bool get achieved => current >= target;

  int get clampedCurrent => math.min(current, target);

  double get progress => target <= 0 ? 1.0 : (current / target).clamp(0.0, 1.0);

  String title(AppLocalizations l10n) {
    switch (id) {
      case 'prayer_streak_3':
        return l10n.milestonePrayerStreak3Title;
      case 'prayer_streak_7':
        return l10n.milestonePrayerStreak7Title;
      case 'prayer_streak_21':
        return l10n.milestonePrayerStreak21Title;
      case 'prayer_streak_40':
        return l10n.milestonePrayerStreak40Title;
      case 'prayer_streak_90':
        return l10n.milestonePrayerStreak90Title;
      case 'prayer_streak_365':
        return l10n.milestonePrayerStreak365Title;
      case 'rosary_total_1':
        return l10n.milestoneRosaryTotal1Title;
      case 'rosary_streak_7':
        return l10n.milestoneRosaryStreak7Title;
      case 'rosary_streak_30':
        return l10n.milestoneRosaryStreak30Title;
      case 'rosary_streak_54':
        return l10n.milestoneRosaryStreak54Title;
      case 'rosary_total_100':
        return l10n.milestoneRosaryTotal100Title;
      case 'mass_total_1':
        return l10n.milestoneMassTotal1Title;
      case 'mass_sunday_4':
        return l10n.milestoneMassSunday4Title;
      case 'mass_perfect_month_1':
        return l10n.milestoneMassPerfectMonth1Title;
      case 'mass_sunday_12':
        return l10n.milestoneMassSunday12Title;
      case 'mass_sunday_52':
        return l10n.milestoneMassSunday52Title;
      case 'novena_completed_1':
        return l10n.milestoneNovena1Title;
      case 'novena_completed_3':
        return l10n.milestoneNovena3Title;
      case 'confession_total_1':
        return l10n.milestoneConfession1Title;
      case 'confession_total_4':
        return l10n.milestoneConfession4Title;
      default:
        return id;
    }
  }

  String description(AppLocalizations l10n) {
    switch (id) {
      case 'prayer_streak_3':
        return l10n.milestonePrayerStreak3Desc;
      case 'prayer_streak_7':
        return l10n.milestonePrayerStreak7Desc;
      case 'prayer_streak_21':
        return l10n.milestonePrayerStreak21Desc;
      case 'prayer_streak_40':
        return l10n.milestonePrayerStreak40Desc;
      case 'prayer_streak_90':
        return l10n.milestonePrayerStreak90Desc;
      case 'prayer_streak_365':
        return l10n.milestonePrayerStreak365Desc;
      case 'rosary_total_1':
        return l10n.milestoneRosaryTotal1Desc;
      case 'rosary_streak_7':
        return l10n.milestoneRosaryStreak7Desc;
      case 'rosary_streak_30':
        return l10n.milestoneRosaryStreak30Desc;
      case 'rosary_streak_54':
        return l10n.milestoneRosaryStreak54Desc;
      case 'rosary_total_100':
        return l10n.milestoneRosaryTotal100Desc;
      case 'mass_total_1':
        return l10n.milestoneMassTotal1Desc;
      case 'mass_sunday_4':
        return l10n.milestoneMassSunday4Desc;
      case 'mass_perfect_month_1':
        return l10n.milestoneMassPerfectMonth1Desc;
      case 'mass_sunday_12':
        return l10n.milestoneMassSunday12Desc;
      case 'mass_sunday_52':
        return l10n.milestoneMassSunday52Desc;
      case 'novena_completed_1':
        return l10n.milestoneNovena1Desc;
      case 'novena_completed_3':
        return l10n.milestoneNovena3Desc;
      case 'confession_total_1':
        return l10n.milestoneConfession1Desc;
      case 'confession_total_4':
        return l10n.milestoneConfession4Desc;
      default:
        return '';
    }
  }
}

class SpiritualProgressSnapshot {
  final int currentPrayerStreak;
  final int bestPrayerStreak;
  final int currentRosaryStreak;
  final int bestRosaryStreak;
  final int totalRosaries;
  final int currentSundayMassStreak;
  final int bestSundayMassStreak;
  final int perfectPreceptMonths;
  final int totalMasses;
  final int totalNovenasCompleted;
  final int totalConfessions;
  final List<SpiritualMilestone> milestones;

  const SpiritualProgressSnapshot({
    required this.currentPrayerStreak,
    required this.bestPrayerStreak,
    required this.currentRosaryStreak,
    required this.bestRosaryStreak,
    required this.totalRosaries,
    required this.currentSundayMassStreak,
    required this.bestSundayMassStreak,
    required this.perfectPreceptMonths,
    required this.totalMasses,
    required this.totalNovenasCompleted,
    required this.totalConfessions,
    required this.milestones,
  });

  int get achievedCount => milestones.where((m) => m.achieved).length;
  int get totalCount => milestones.length;

  double get overallProgress =>
      totalCount == 0 ? 0.0 : (achievedCount / totalCount).clamp(0.0, 1.0);

  Set<String> get achievedIds =>
      {for (final m in milestones) if (m.achieved) m.id};

  /// Próxima meta ainda não alcançada com maior percentual de progresso.
  SpiritualMilestone? get nextMilestone {
    SpiritualMilestone? best;
    for (final m in milestones) {
      if (m.achieved) continue;
      if (best == null || m.progress > best.progress) {
        best = m;
      }
    }
    return best;
  }

  List<SpiritualMilestone> byCategory(MilestoneCategory category) =>
      milestones.where((m) => m.category == category).toList();
}

/// Motor puro e offline para cálculo de sequências e metas espirituais a partir
/// do histórico já armazenado pelo aplicativo.
class SpiritualMilestonesCalculator {
  SpiritualMilestonesCalculator._();

  static DateTime _dayKey(DateTime d) => DateTime.utc(d.year, d.month, d.day);

  static DateTime? _parseYyyyMmDd(String raw) {
    if (raw.length < 8) return null;
    final y = int.tryParse(raw.substring(0, 4));
    final m = int.tryParse(raw.substring(4, 6));
    final d = int.tryParse(raw.substring(6, 8));
    if (y == null || m == null || d == null) return null;
    if (m < 1 || m > 12 || d < 1 || d > 31) return null;
    return DateTime.utc(y, m, d);
  }

  static int _currentDailyStreak(Set<DateTime> days, DateTime todayUtc) {
    var cursor = todayUtc;
    if (!days.contains(cursor)) {
      cursor = cursor.subtract(const Duration(days: 1));
    }
    var streak = 0;
    while (days.contains(cursor)) {
      streak++;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return streak;
  }

  static int _bestSteppedStreak(Set<DateTime> days, int stepDays) {
    if (days.isEmpty) return 0;
    final sorted = days.toList()..sort();
    var best = 1;
    var current = 1;
    for (var i = 1; i < sorted.length; i++) {
      final diff = sorted[i].difference(sorted[i - 1]).inDays;
      if (diff == stepDays) {
        current++;
        if (current > best) best = current;
      } else if (diff > 0) {
        current = 1;
      }
    }
    return best;
  }

  static int _currentSundayStreak(Set<DateTime> massDays, DateTime todayUtc) {
    var sunday = todayUtc.subtract(Duration(days: todayUtc.weekday % 7));
    if (!massDays.contains(sunday) && sunday == todayUtc) {
      sunday = sunday.subtract(const Duration(days: 7));
    }
    var count = 0;
    while (massDays.contains(sunday)) {
      count++;
      sunday = sunday.subtract(const Duration(days: 7));
    }
    return count;
  }

  static int _countPerfectPreceptMonths(Set<DateTime> massDays, DateTime todayUtc) {
    if (massDays.isEmpty) return 0;
    final months = <(int, int)>{
      for (final d in massDays) (d.year, d.month),
    };
    var perfect = 0;
    for (final (year, month) in months) {
      final daysInMonth = DateTime.utc(year, month + 1, 0).day;
      var hasPreceptDay = false;
      var allFulfilled = true;
      for (var day = 1; day <= daysInMonth; day++) {
        final localDate = DateTime(year, month, day);
        if (!LiturgicalCalendar.isDayOfObligation(localDate)) continue;
        hasPreceptDay = true;
        final utcDay = DateTime.utc(year, month, day);
        if (utcDay.isAfter(todayUtc) || !massDays.contains(utcDay)) {
          allFulfilled = false;
          break;
        }
      }
      if (hasPreceptDay && allFulfilled) {
        perfect++;
      }
    }
    return perfect;
  }

  static SpiritualProgressSnapshot computeFromProviders(
    PrayerProvider prayers,
    ConfessionProvider confessions, {
    DateTime? now,
  }) {
    final confessionDates = <DateTime>[
      for (final entry in confessions.confessionHistory)
        if (entry['date'] is DateTime) entry['date'] as DateTime,
    ];
    final novenaCompletions = prayers.novenaHistory.values.fold<int>(
      0,
      (sum, list) => sum + list.length,
    );

    return compute(
      prayerLogs: prayers.prayerLogs,
      dailyPrayers: prayers.dailyPrayers,
      massDates: prayers.massDates,
      confessionDates: confessionDates,
      novenaCompletions: novenaCompletions,
      now: now,
    );
  }

  static SpiritualProgressSnapshot compute({
    required List<Map<String, String>> prayerLogs,
    required Map<String, int> dailyPrayers,
    required List<DateTime> massDates,
    required List<DateTime> confessionDates,
    required int novenaCompletions,
    DateTime? now,
  }) {
    final todayUtc = _dayKey(now ?? DateTime.now());
    final activeDays = <DateTime>{};
    final rosaryDays = <DateTime>{};
    final loggedRosaryKeys = <String>{};
    var totalRosaries = 0;

    for (final log in prayerLogs) {
      final ts = DateTime.tryParse(log['timestamp'] ?? '');
      if (ts == null) continue;
      final day = _dayKey(ts);
      if (day.isAfter(todayUtc)) continue;
      activeDays.add(day);

      final pid = (log['prayerId'] ?? '').toLowerCase();
      if (pid.startsWith('rosary') || pid.contains('rosary')) {
        rosaryDays.add(day);
        totalRosaries++;
        loggedRosaryKeys.add('${day.year}-${day.month}-${day.day}_$pid');
      }
    }

    dailyPrayers.forEach((key, value) {
      if (value != 1) return;
      final sep = key.indexOf('_');
      if (sep < 8) return;
      final day = _parseYyyyMmDd(key.substring(0, 8));
      if (day == null || day.isAfter(todayUtc)) return;
      activeDays.add(day);

      final pid = key.substring(sep + 1).toLowerCase();
      if (pid.contains('rosary')) {
        rosaryDays.add(day);
        final dedupKey = '${day.year}-${day.month}-${day.day}_$pid';
        if (!loggedRosaryKeys.contains(dedupKey)) {
          totalRosaries++;
          loggedRosaryKeys.add(dedupKey);
        }
      }
    });

    final massDays = <DateTime>{};
    for (final m in massDates) {
      final day = _dayKey(m);
      if (day.isAfter(todayUtc)) continue;
      massDays.add(day);
      activeDays.add(day);
    }

    final validConfessions = <DateTime>[];
    for (final c in confessionDates) {
      final day = _dayKey(c);
      if (day.isAfter(todayUtc)) continue;
      validConfessions.add(day);
      activeDays.add(day);
    }

    final currentPrayerStreak = _currentDailyStreak(activeDays, todayUtc);
    final bestPrayerStreak = math.max(
      currentPrayerStreak,
      _bestSteppedStreak(activeDays, 1),
    );

    final currentRosaryStreak = _currentDailyStreak(rosaryDays, todayUtc);
    final bestRosaryStreak = math.max(
      currentRosaryStreak,
      _bestSteppedStreak(rosaryDays, 1),
    );

    final sundayMassDays = <DateTime>{
      for (final d in massDays)
        if (d.weekday == DateTime.sunday) d,
    };
    final currentSundayMassStreak = _currentSundayStreak(massDays, todayUtc);
    final bestSundayMassStreak = math.max(
      currentSundayMassStreak,
      _bestSteppedStreak(sundayMassDays, 7),
    );
    final perfectPreceptMonths = _countPerfectPreceptMonths(massDays, todayUtc);
    final totalMasses = massDays.length;
    final totalConfessions = validConfessions.length;

    final milestones = <SpiritualMilestone>[
      // 1. Constância na Oração
      SpiritualMilestone(
        id: 'prayer_streak_3',
        category: MilestoneCategory.prayer,
        target: 3,
        current: bestPrayerStreak,
        icon: Icons.eco_outlined,
      ),
      SpiritualMilestone(
        id: 'prayer_streak_7',
        category: MilestoneCategory.prayer,
        target: 7,
        current: bestPrayerStreak,
        icon: Icons.local_fire_department_outlined,
      ),
      SpiritualMilestone(
        id: 'prayer_streak_21',
        category: MilestoneCategory.prayer,
        target: 21,
        current: bestPrayerStreak,
        icon: Icons.wb_twilight,
      ),
      SpiritualMilestone(
        id: 'prayer_streak_40',
        category: MilestoneCategory.prayer,
        target: 40,
        current: bestPrayerStreak,
        icon: Icons.terrain_outlined,
      ),
      SpiritualMilestone(
        id: 'prayer_streak_90',
        category: MilestoneCategory.prayer,
        target: 90,
        current: bestPrayerStreak,
        icon: Icons.park_outlined,
      ),
      SpiritualMilestone(
        id: 'prayer_streak_365',
        category: MilestoneCategory.prayer,
        target: 365,
        current: bestPrayerStreak,
        icon: Icons.workspace_premium,
      ),

      // 2. Santo Terço
      SpiritualMilestone(
        id: 'rosary_total_1',
        category: MilestoneCategory.rosary,
        target: 1,
        current: totalRosaries,
        icon: Icons.auto_awesome,
      ),
      SpiritualMilestone(
        id: 'rosary_streak_7',
        category: MilestoneCategory.rosary,
        target: 7,
        current: bestRosaryStreak,
        icon: Icons.filter_vintage_outlined,
      ),
      SpiritualMilestone(
        id: 'rosary_streak_30',
        category: MilestoneCategory.rosary,
        target: 30,
        current: bestRosaryStreak,
        icon: Icons.local_florist,
      ),
      SpiritualMilestone(
        id: 'rosary_streak_54',
        category: MilestoneCategory.rosary,
        target: 54,
        current: bestRosaryStreak,
        icon: Icons.military_tech_outlined,
      ),
      SpiritualMilestone(
        id: 'rosary_total_100',
        category: MilestoneCategory.rosary,
        target: 100,
        current: totalRosaries,
        icon: Icons.emoji_events,
      ),

      // 3. Santa Missa
      SpiritualMilestone(
        id: 'mass_total_1',
        category: MilestoneCategory.mass,
        target: 1,
        current: totalMasses,
        icon: Icons.church_outlined,
      ),
      SpiritualMilestone(
        id: 'mass_sunday_4',
        category: MilestoneCategory.mass,
        target: 4,
        current: bestSundayMassStreak,
        icon: Icons.wb_sunny_outlined,
      ),
      SpiritualMilestone(
        id: 'mass_perfect_month_1',
        category: MilestoneCategory.mass,
        target: 1,
        current: perfectPreceptMonths,
        icon: Icons.verified_outlined,
      ),
      SpiritualMilestone(
        id: 'mass_sunday_12',
        category: MilestoneCategory.mass,
        target: 12,
        current: bestSundayMassStreak,
        icon: Icons.stars_outlined,
      ),
      SpiritualMilestone(
        id: 'mass_sunday_52',
        category: MilestoneCategory.mass,
        target: 52,
        current: bestSundayMassStreak,
        icon: Icons.workspace_premium_outlined,
      ),

      // 4. Novenas e Sacramentos
      SpiritualMilestone(
        id: 'novena_completed_1',
        category: MilestoneCategory.devotion,
        target: 1,
        current: novenaCompletions,
        icon: Icons.menu_book_outlined,
      ),
      SpiritualMilestone(
        id: 'novena_completed_3',
        category: MilestoneCategory.devotion,
        target: 3,
        current: novenaCompletions,
        icon: Icons.auto_stories_outlined,
      ),
      SpiritualMilestone(
        id: 'confession_total_1',
        category: MilestoneCategory.devotion,
        target: 1,
        current: totalConfessions,
        icon: Icons.favorite_outline,
      ),
      SpiritualMilestone(
        id: 'confession_total_4',
        category: MilestoneCategory.devotion,
        target: 4,
        current: totalConfessions,
        icon: Icons.volunteer_activism_outlined,
      ),
    ];

    return SpiritualProgressSnapshot(
      currentPrayerStreak: currentPrayerStreak,
      bestPrayerStreak: bestPrayerStreak,
      currentRosaryStreak: currentRosaryStreak,
      bestRosaryStreak: bestRosaryStreak,
      totalRosaries: totalRosaries,
      currentSundayMassStreak: currentSundayMassStreak,
      bestSundayMassStreak: bestSundayMassStreak,
      perfectPreceptMonths: perfectPreceptMonths,
      totalMasses: totalMasses,
      totalNovenasCompleted: novenaCompletions,
      totalConfessions: totalConfessions,
      milestones: milestones,
    );
  }
}
