import 'package:sanctaconscientia/utils/date_text.dart';
import 'package:flutter/material.dart';
import 'package:sanctaconscientia/utils/app_images.dart';
import 'package:sanctaconscientia/widgets/app_tour.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/models/novena_content.dart';
import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/pages/novena_detail_page.dart';
import 'package:sanctaconscientia/data/novena_data.dart';
import 'package:sanctaconscientia/widgets/novena_suggestion_card.dart';
import 'package:sanctaconscientia/utils/content_search.dart';
import 'package:sanctaconscientia/widgets/search_field.dart';

/// Lista de novenas: as que estão em andamento ganham destaque no topo.
class NovenaHomePage extends StatefulWidget {
  const NovenaHomePage({super.key});

  @override
  State<NovenaHomePage> createState() => _NovenaHomePageState();
}

class _NovenaHomePageState extends State<NovenaHomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _open(BuildContext context, String novenaId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => NovenaDetailPage(novenaId: novenaId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final prayerProvider = Provider.of<PrayerProvider>(context);
    final all = NovenaData.getAllNovenas(context);
    final active = all.where((n) => prayerProvider.isNovenaActive(n.id)).toList();

    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      body: CustomScrollView(
        controller: AppTourScroll.novenas,
        slivers: [
          SliverAppBar(
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primaryText,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                l10n.novenaTitle,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('lib/imgs/novenas_page.webp', fit: BoxFit.cover, cacheWidth: AppImages.headerWidth),
                  Container(color: Colors.black.withValues(alpha: 0.3)),
                ],
              ),
            ),
            leading: null,
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                TourAnchor(
                  ref: AppTourKeys.novenaSearch,
                  child: AppSearchField(
                    controller: _searchController,
                    hint: l10n.searchNovenasHint,
                    onChanged: (v) => setState(() => _query = v),
                  ),
                ),
                const SizedBox(height: 16),
                if (_query.trim().isNotEmpty)
                  ..._searchResults(context, l10n)
                else ...[
                const NovenaSuggestions(),
                if (active.isNotEmpty) ...[
                  _sectionLabel(l10n.novenasInProgress),
                  for (final n in active)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: _ActiveNovenaCard(
                        novena: n,
                        onTap: () => _open(context, n.id),
                      ),
                    ),
                  const SizedBox(height: 14),
                ] else ...[
                  _IntroCard(text: l10n.novenasIntro),
                  const SizedBox(height: 24),
                ],
                _sectionLabel(l10n.novenasAll),
                for (final n in all)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: n == all.first
                        ? TourAnchor(ref: AppTourKeys.novenaList, child: _NovenaTile(novena: n, onTap: () => _open(context, n.id)))
                        : _NovenaTile(novena: n, onTap: () => _open(context, n.id)),
                  ),
                ],
              ]),
            ),
          ),
        ],
      ),
    );
  }

  /// Resultados da busca: novenas parecidas com o que foi digitado.
  List<Widget> _searchResults(BuildContext context, AppLocalizations l10n) {
    final result = NovenaSearch.search(context, _query);
    if (result.hits.isEmpty) return [SearchEmpty(l10n.searchNoNovenas)];
    return [
      if (result.approximate) const SearchApproximateNote(),
      for (final n in result.hits)
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _NovenaTile(novena: n, onTap: () => _open(context, n.id)),
        ),
    ];
  }

  static Widget _sectionLabel(String text) => Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 10),
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: AppColors.secondaryText,
          ),
        ),
      );
}

/// Mensagem curta quando nenhuma novena está em andamento.
class _IntroCard extends StatelessWidget {
  final String text;
  const _IntroCard({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.accentGold.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.accentGold.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.local_florist, color: AppColors.accentGold, size: 30),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15, height: 1.4, color: AppColors.primaryText),
            ),
          ),
        ],
      ),
    );
  }
}

/// Novena em andamento: dia atual, progresso de 9 etapas e botão para continuar.
class _ActiveNovenaCard extends StatelessWidget {
  final NovenaContent novena;
  final VoidCallback onTap;

  const _ActiveNovenaCard({required this.novena, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final prayerProvider = Provider.of<PrayerProvider>(context);
    final day = prayerProvider.getNovenaDay(novena.id);
    final todayKey = DateFormat('yyyyMMdd').format(DateTime.now());
    final doneToday = prayerProvider.isDailyPrayerCompleted(todayKey, '${novena.id}_day_$day');
    const color = AppColors.themeColor;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, Color.lerp(color, Colors.black, 0.28)!],
        ),
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.35), blurRadius: 16, offset: const Offset(0, 8)),
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
                          l10n.novenaDayProgress(day, 9).toUpperCase(),
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
                    Icon(novena.icon, color: Colors.white.withValues(alpha: 0.9), size: 28),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  novena.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 16),
                // 9 etapas
                Row(
                  children: List.generate(9, (i) {
                    final d = i + 1;
                    final isPast = d < day;
                    final isCurrent = d == day;
                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        height: 6,
                        decoration: BoxDecoration(
                          color: isCurrent
                              ? Colors.white
                              : (isPast ? Colors.white.withValues(alpha: 0.75) : Colors.white.withValues(alpha: 0.25)),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: onTap,
                    icon: Icon(doneToday ? Icons.check_circle : Icons.play_arrow_rounded),
                    label: Text(
                      doneToday ? l10n.novenaDayDoneLabel(day) : l10n.novenaContinue,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: doneToday ? AppColors.successColor : color,
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

/// Linha de uma novena na lista geral.
class _NovenaTile extends StatelessWidget {
  final NovenaContent novena;
  final VoidCallback onTap;

  const _NovenaTile({required this.novena, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final prayerProvider = Provider.of<PrayerProvider>(context);

    final currentDay = prayerProvider.getNovenaDay(novena.id);
    final isActive = prayerProvider.isNovenaActive(novena.id);
    final timesCompleted = prayerProvider.novenaTimesCompleted(novena.id);
    final recentlyCompleted = prayerProvider.novenaRecentlyCompleted(novena.id);
    final lastCompletion = prayerProvider.lastNovenaCompletion(novena.id);
    final startDate = prayerProvider.getNovenaStartDate(novena.id);
    final isScheduled = startDate != null && !isActive && currentDay < 1;

    String? status;
    Color statusColor = AppColors.secondaryText;
    if (isActive) {
      status = l10n.novenaDay(currentDay);
      statusColor = AppColors.themeColor;
    } else if (isScheduled) {
      status = l10n.novenaScheduled(fmtDayMonth(context, startDate));
      statusColor = AppColors.accentGold;
    } else if (recentlyCompleted && lastCompletion != null) {
      // Destaque temporário logo após concluir
      status = l10n.novenaCompletedOn(fmtDayMonth(context, lastCompletion));
      statusColor = Colors.green;
    } else if (timesCompleted > 0) {
      status = l10n.novenaPrayedTimes(timesCompleted);
    }

    const accent = AppColors.themeColor;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isActive ? accent.withValues(alpha: 0.5) : accent.withValues(alpha: 0.15),
          width: isActive ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 3)),
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
                    color: accent.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(novena.icon, color: accent, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        novena.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: AppColors.primaryText,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        novena.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.3,
                          color: AppColors.secondaryText.withValues(alpha: 0.85),
                        ),
                      ),
                      if (status != null) ...[
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.chevron_right, color: accent),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
