import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/providers/confession_provider.dart';
import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/utils/spiritual_milestones.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';

/// Tela de Evolução e Perseverança: sequências atuais, próxima meta e marcos
/// progressivos de oração, Terço, Santa Missa, Novenas e Confissões.
class SpiritualGrowthPage extends StatelessWidget {
  const SpiritualGrowthPage({super.key});

  static const _gold = Color(0xFFB7791F);
  static const _gardenGreen = Color(0xFF2F5D34);
  static const _rosaryRed = Color(0xFFD94452);
  static const _devotionBlue = Color(0xFF1E5AA8);

  Color _categoryColor(MilestoneCategory category) {
    switch (category) {
      case MilestoneCategory.prayer:
        return _gardenGreen;
      case MilestoneCategory.rosary:
        return _rosaryRed;
      case MilestoneCategory.mass:
        return _gold;
      case MilestoneCategory.devotion:
        return _devotionBlue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final prayers = Provider.of<PrayerProvider>(context);
    final confessions = Provider.of<ConfessionProvider>(context);
    final snapshot = SpiritualMilestonesCalculator.computeFromProviders(
      prayers,
      confessions,
    );
    final next = snapshot.nextMilestone;

    return InnerPageScaffold(
      title: l10n.growthPageTitle,
      subtitle: l10n.growthPageSubtitle,
      color: _gold,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        children: [
          _SummaryHeroCard(snapshot: snapshot),
          const SizedBox(height: 18),
          SectionLabel(l10n.growthSectionStreaks),
          _StreakOverviewGrid(snapshot: snapshot),
          if (next != null) ...[
            const SizedBox(height: 18),
            SectionLabel(l10n.growthSectionNext),
            _MilestoneTile(
              milestone: next,
              accent: _categoryColor(next.category),
              highlighted: true,
            ),
          ],
          const SizedBox(height: 18),
          _buildCategorySection(
            l10n.growthCatPrayer,
            snapshot.byCategory(MilestoneCategory.prayer),
            _gardenGreen,
          ),
          const SizedBox(height: 14),
          _buildCategorySection(
            l10n.growthCatRosary,
            snapshot.byCategory(MilestoneCategory.rosary),
            _rosaryRed,
          ),
          const SizedBox(height: 14),
          _buildCategorySection(
            l10n.growthCatMass,
            snapshot.byCategory(MilestoneCategory.mass),
            _gold,
          ),
          const SizedBox(height: 14),
          _buildCategorySection(
            l10n.growthCatDevotion,
            snapshot.byCategory(MilestoneCategory.devotion),
            _devotionBlue,
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(
    String heading,
    List<SpiritualMilestone> items,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(heading),
        for (final m in items) ...[
          _MilestoneTile(milestone: m, accent: color),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _SummaryHeroCard extends StatelessWidget {
  final SpiritualProgressSnapshot snapshot;
  const _SummaryHeroCard({required this.snapshot});

  static const _gold = Color(0xFFB7791F);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: appCardDecoration(tint: _gold, radius: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleIcon(icon: Icons.emoji_events, color: _gold, size: 48),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.growthSummaryTitle,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      l10n.growthSummaryProgress(
                        snapshot.achievedCount,
                        snapshot.totalCount,
                      ),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _gold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: snapshot.overallProgress,
              minHeight: 8,
              backgroundColor: _gold.withValues(alpha: 0.14),
              valueColor: const AlwaysStoppedAnimation<Color>(_gold),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.growthSummaryQuote,
            style: const TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              height: 1.4,
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}

class _StreakOverviewGrid extends StatelessWidget {
  final SpiritualProgressSnapshot snapshot;
  const _StreakOverviewGrid({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cards = [
      _StreakBox(
        icon: Icons.local_fire_department_outlined,
        color: SpiritualGrowthPage._gardenGreen,
        value: '${snapshot.currentPrayerStreak}',
        label: l10n.growthStreakPrayerLabel,
        footer: l10n.growthStreakBest(snapshot.bestPrayerStreak),
      ),
      _StreakBox(
        icon: Icons.auto_awesome,
        color: SpiritualGrowthPage._rosaryRed,
        value: '${snapshot.currentRosaryStreak}',
        label: l10n.growthStreakRosaryLabel,
        footer: l10n.growthTotalRosariesLabel(snapshot.totalRosaries),
      ),
      _StreakBox(
        icon: Icons.church_outlined,
        color: SpiritualGrowthPage._gold,
        value: '${snapshot.currentSundayMassStreak}',
        label: l10n.growthStreakMassLabel,
        footer: l10n.growthPreceptMonthsLabel(snapshot.perfectPreceptMonths),
      ),
      _StreakBox(
        icon: Icons.volunteer_activism_outlined,
        color: SpiritualGrowthPage._devotionBlue,
        value: '${snapshot.totalNovenasCompleted + snapshot.totalConfessions}',
        label: l10n.growthStreakDevotionLabel,
        footer: l10n.growthDevotionBreakdown(
          snapshot.totalNovenasCompleted,
          snapshot.totalConfessions,
        ),
      ),
    ];

    return Column(
      children: [
        for (var i = 0; i < cards.length; i++) ...[
          cards[i],
          if (i < cards.length - 1) const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _StreakBox extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String value;
  final String label;
  final String footer;

  const _StreakBox({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
    required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: appCardDecoration(tint: color),
      child: Row(
        children: [
          CircleIcon(icon: icon, color: color, size: 44),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  footer,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MilestoneTile extends StatelessWidget {
  final SpiritualMilestone milestone;
  final Color accent;
  final bool highlighted;

  const _MilestoneTile({
    required this.milestone,
    required this.accent,
    this.highlighted = false,
  });

  static const _gold = Color(0xFFB7791F);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final done = milestone.achieved;
    final badgeColor = done ? _gold : accent;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: appCardDecoration(tint: done ? _gold : accent).copyWith(
        border: Border.all(
          color: (done ? _gold : accent).withValues(
            alpha: highlighted ? 0.55 : (done ? 0.4 : 0.14),
          ),
          width: highlighted ? 1.5 : 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleIcon(
            icon: done ? Icons.emoji_events : milestone.icon,
            color: badgeColor,
            size: 42,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      milestone.title(l10n),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText,
                      ),
                    ),
                    if (done)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _gold.withValues(alpha: 0.16),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          l10n.growthAchievedBadge,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: _gold,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  milestone.description(l10n),
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.35,
                    color: AppColors.secondaryText,
                  ),
                ),
                if (!done) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: milestone.progress,
                            minHeight: 6,
                            backgroundColor: accent.withValues(alpha: 0.14),
                            valueColor: AlwaysStoppedAnimation<Color>(accent),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        l10n.growthProgressRatio(
                          milestone.clampedCurrent,
                          milestone.target,
                        ),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: accent,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
