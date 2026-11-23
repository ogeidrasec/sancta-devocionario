import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/pages/spiritual_growth_page.dart';
import 'package:sanctaconscientia/providers/confession_provider.dart';
import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/utils/spiritual_milestones.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';

/// Cartão compacto de evolução na aba Hoje (abaixo do Jardim da Alma).
/// Mostra sequências atuais, a próxima meta e abre a tela completa de metas.
class SpiritualGrowthCard extends StatelessWidget {
  const SpiritualGrowthCard({super.key});

  static const _gold = Color(0xFFB7791F);
  static const _gardenGreen = Color(0xFF2F5D34);
  static const _rosaryRed = Color(0xFFD94452);

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

    return Container(
      key: const ValueKey('spiritual_growth_card'),
      decoration: appCardDecoration(tint: _gold),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const SpiritualGrowthPage()),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleIcon(
                      icon: Icons.emoji_events_outlined,
                      color: _gold,
                      size: 42,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.growthCardTitle,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryText,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            l10n.growthCardCounter(
                              snapshot.achievedCount,
                              snapshot.totalCount,
                            ),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: _gold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: AppColors.secondaryText,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    _StreakPill(
                      icon: Icons.local_fire_department_outlined,
                      color: _gardenGreen,
                      label: l10n.growthChipPrayer(snapshot.currentPrayerStreak),
                    ),
                    _StreakPill(
                      icon: Icons.auto_awesome,
                      color: _rosaryRed,
                      label: l10n.growthChipRosary(snapshot.currentRosaryStreak),
                    ),
                    _StreakPill(
                      icon: Icons.church_outlined,
                      color: _gold,
                      label: l10n.growthChipMass(snapshot.currentSundayMassStreak),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (next != null) ...[
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          l10n.growthNextGoalLabel(next.title(l10n)),
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        l10n.growthProgressRatio(
                          next.clampedCurrent,
                          next.target,
                        ),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _gold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: next.progress,
                      minHeight: 6,
                      backgroundColor: _gold.withValues(alpha: 0.14),
                      valueColor: const AlwaysStoppedAnimation<Color>(_gold),
                    ),
                  ),
                ] else
                  Text(
                    l10n.growthAllDoneLabel,
                    style: const TextStyle(
                      fontSize: 13,
                      color: _gardenGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StreakPill extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const _StreakPill({
    required this.icon,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
