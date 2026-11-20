import 'package:flutter/material.dart';
import 'package:sanctaconscientia/widgets/app_tour.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/pages/rosary_prayer_page.dart';

import 'package:provider/provider.dart';
import 'package:sanctaconscientia/providers/settings_provider.dart';
import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';

enum MysteryType { joyful, sorrowful, glorious, luminous }

/// Cor, ícone e imagem de cada grupo de mistérios (usado nas duas telas do terço).
class MysteryStyle {
  final Color color;
  final IconData icon;
  final String image;
  const MysteryStyle(this.color, this.icon, this.image);
}

class RosaryMysteriesPage extends StatelessWidget {
  const RosaryMysteriesPage({super.key});

  static MysteryStyle styleOf(MysteryType type) {
    switch (type) {
      case MysteryType.joyful:
        return const MysteryStyle(Color(0xFF2E7D32), Icons.child_care, 'lib/imgs/misterios_gozosos.webp');
      case MysteryType.sorrowful:
        return const MysteryStyle(Color(0xFFB71C1C), Icons.favorite, 'lib/imgs/misterios_dolorosos.webp');
      case MysteryType.glorious:
        return const MysteryStyle(Color(0xFFB7791F), Icons.wb_sunny, 'lib/imgs/misterios_gloriosos.webp');
      case MysteryType.luminous:
        // Sem imagem própria ainda: reaproveita a dos gloriosos
        return const MysteryStyle(Color(0xFF8A6D00), Icons.light_mode, 'lib/imgs/misterios_gloriosos.webp');
    }
  }

  /// Mistério do dia, conforme o modo (tradicional ou com luminosos).
  static MysteryType todaysMystery(bool isTraditional) {
    final weekday = DateTime.now().weekday;

    if (isTraditional) {
      // Tradicional (antes de 2002):
      // Seg/Qui: Gozosos · Ter/Sex: Dolorosos · Qua/Sáb/Dom: Gloriosos
      switch (weekday) {
        case DateTime.monday:
        case DateTime.thursday:
          return MysteryType.joyful;
        case DateTime.tuesday:
        case DateTime.friday:
          return MysteryType.sorrowful;
        case DateTime.wednesday:
        case DateTime.saturday:
        case DateTime.sunday:
          return MysteryType.glorious;
        default:
          return MysteryType.joyful;
      }
    } else {
      // Com luminosos (depois de 2002):
      // Seg/Sáb: Gozosos · Ter/Sex: Dolorosos · Qua/Dom: Gloriosos · Qui: Luminosos
      switch (weekday) {
        case DateTime.monday:
        case DateTime.saturday:
          return MysteryType.joyful;
        case DateTime.tuesday:
        case DateTime.friday:
          return MysteryType.sorrowful;
        case DateTime.wednesday:
        case DateTime.sunday:
          return MysteryType.glorious;
        case DateTime.thursday:
          return MysteryType.luminous;
        default:
          return MysteryType.joyful;
      }
    }
  }

  void _open(BuildContext context, MysteryType type) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => RosaryPrayerPage(mysteryType: type)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final isTraditional = settingsProvider.isTraditionalRosary;
    final today = todaysMystery(isTraditional);

    final entries = <(MysteryType, String, String)>[
      (MysteryType.joyful, l10n.mysteryJoyfulTitle,
          isTraditional ? l10n.mysteryJoyfulDays : l10n.mysteryJoyfulDaysLuminous),
      if (!isTraditional)
        (MysteryType.luminous, l10n.mysteryLuminousTitle, l10n.mysteryLuminousDays),
      (MysteryType.sorrowful, l10n.mysterySorrowfulTitle, l10n.mysterySorrowfulDays),
      (MysteryType.glorious, l10n.mysteryGloriousTitle,
          isTraditional ? l10n.mysteryGloriousDays : l10n.mysteryGloriousDaysLuminous),
    ];
    final todayEntry = entries.firstWhere((e) => e.$1 == today);
    final others = entries.where((e) => e.$1 != today).toList();

    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      body: CustomScrollView(
        controller: AppTourScroll.rosary,
        slivers: [
          SliverAppBar(
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primaryText,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                l10n.rosaryTitle,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('lib/imgs/terco_page.webp', fit: BoxFit.cover, cacheWidth: 900),
                  Container(color: Colors.black.withValues(alpha: 0.3)),
                ],
              ),
            ),
            automaticallyImplyLeading: false,
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Quantos terços de hoje faltam para completar o Rosário
                TourAnchor(ref: AppTourKeys.rosaryProgress, child: _RosaryProgress(traditional: isTraditional)),
                const SizedBox(height: 16),
                // Mistério de hoje: destaque
                TourAnchor(
                  ref: AppTourKeys.rosaryToday,
                  child: _TodayCard(
                  type: todayEntry.$1,
                  title: todayEntry.$2,
                  days: todayEntry.$3,
                  onTap: () => _open(context, todayEntry.$1),
                )),
                const SizedBox(height: 28),
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 10),
                  child: Text(
                    l10n.rosaryOtherMysteries.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                      color: AppColors.secondaryText,
                    ),
                  ),
                ),
                for (final e in others)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _MysteryTile(
                      type: e.$1,
                      title: e.$2,
                      days: e.$3,
                      onTap: () => _open(context, e.$1),
                    ),
                  ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

/// Progresso do dia: bolinhas por terço rezado até completar o Rosário
/// (3 terços no modo tradicional, 4 no atual).
class _RosaryProgress extends StatelessWidget {
  final bool traditional;
  const _RosaryProgress({required this.traditional});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final prayers = Provider.of<PrayerProvider>(context);
    final per = PrayerProvider.chapletsPerRosary(traditional: traditional);
    final done = prayers.chapletsToday;
    final full = done > 0 && done % per == 0;
    final filled = full ? per : done % per;
    final text = full ? l10n.rosaryFullComplete : l10n.rosaryProgress(done % per, per);
    const gold = AppColors.accentGold;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: appCardDecoration(tint: gold),
      child: Row(
        children: [
          for (var i = 0; i < per; i++)
            Container(
              width: 18,
              height: 18,
              margin: const EdgeInsets.only(right: 6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i < filled ? gold : Colors.transparent,
                border: Border.all(color: gold, width: 2),
              ),
            ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                fontWeight: full ? FontWeight.bold : FontWeight.w500,
                color: AppColors.primaryText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Cartão grande do mistério de hoje.
class _TodayCard extends StatelessWidget {
  final MysteryType type;
  final String title;
  final String days;
  final VoidCallback onTap;

  const _TodayCard({
    required this.type,
    required this.title,
    required this.days,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final style = RosaryMysteriesPage.styleOf(type);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [style.color, Color.lerp(style.color, Colors.black, 0.25)!],
        ),
        boxShadow: [
          BoxShadow(
            color: style.color.withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          l10n.rosaryTodaysMystery.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(style.icon, color: Colors.white.withValues(alpha: 0.9), size: 30),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  days,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 22),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: onTap,
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: Text(
                      l10n.rosaryPrayNow,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: style.color,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
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

/// Linha compacta dos outros mistérios.
class _MysteryTile extends StatelessWidget {
  final MysteryType type;
  final String title;
  final String days;
  final VoidCallback onTap;

  const _MysteryTile({
    required this.type,
    required this.title,
    required this.days,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final style = RosaryMysteriesPage.styleOf(type);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: style.color.withValues(alpha: 0.18)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: style.color.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(style.icon, color: style.color, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: AppColors.primaryText,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        days,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.secondaryText.withValues(alpha: 0.85),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: style.color),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
