import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/data/novena_data.dart';
import 'package:sanctaconscientia/data/novena_feasts.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/models/novena_content.dart';
import 'package:sanctaconscientia/pages/novena_detail_page.dart';
import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/utils/date_text.dart';

/// Sugestões de novena para esta época (a festa se aproxima), sem repetir as
/// que já estão em andamento ou agendadas.
List<NovenaSuggestion> pendingNovenaSuggestions(PrayerProvider prayers, {DateTime? now, int max = 2}) {
  return NovenaFeasts.suggestionsFor(now ?? DateTime.now())
      .where((s) => !prayers.isNovenaActive(s.novenaId) && prayers.getNovenaStartDate(s.novenaId) == null)
      .take(max)
      .toList();
}

/// Cartão que sugere começar uma novena no tempo certo.
class NovenaSuggestionCard extends StatelessWidget {
  final NovenaSuggestion suggestion;
  const NovenaSuggestionCard({super.key, required this.suggestion});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final all = NovenaData.getAllNovenas(context);
    final matches = all.where((n) => n.id == suggestion.novenaId);
    if (matches.isEmpty) return const SizedBox.shrink();
    final NovenaContent novena = matches.first;

    final days = suggestion.daysUntilStart(DateTime.now());
    final feast = fmtDayMonth(context, suggestion.feast);
    final text = days == 0
        ? l10n.novenaSuggestToday(feast)
        : (days > 0 ? l10n.novenaSuggestSoon(days, feast) : l10n.novenaSuggestLate(feast));

    const gold = Color(0xFFB7791F);
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E6),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: gold.withValues(alpha: 0.4)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => NovenaDetailPage(novenaId: novena.id)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(color: gold.withValues(alpha: 0.15), shape: BoxShape.circle),
                  child: Icon(novena.icon, color: gold, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.novenaSuggestLabel.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                          color: gold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        novena.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        text,
                        style: const TextStyle(fontSize: 13, height: 1.3, color: AppColors.secondaryText),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: gold),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Lista de sugestões prontas para colocar em uma tela (vazia se não houver).
class NovenaSuggestions extends StatelessWidget {
  const NovenaSuggestions({super.key});

  @override
  Widget build(BuildContext context) {
    final prayers = Provider.of<PrayerProvider>(context);
    final list = pendingNovenaSuggestions(prayers);
    if (list.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        for (final s in list)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: NovenaSuggestionCard(suggestion: s),
          ),
      ],
    );
  }
}
