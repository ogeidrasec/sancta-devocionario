import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/models/reminder_model.dart';
import 'package:sanctaconscientia/providers/app_state.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/utils/reminder_text.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';
import 'package:intl/intl.dart';

/// Resumo no topo dos Lembretes: quantos estão ativos e qual toca em seguida.
class ReminderStatisticsWidget extends StatelessWidget {
  const ReminderStatisticsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final appState = Provider.of<AppState>(context);
    final stats = appState.getReminderStatistics();

    final totalActive = stats['totalActive'] as int? ?? 0;
    final next = stats['nextReminder'];
    final nextOccurrence = stats['nextOccurrence'] as DateTime?;
    // título no idioma do app (o texto salvo pode estar em outro idioma)
    final nextTitle = next is ReminderModel ? localizedReminderTitle(context, next) : l10n.statsDefaultTitle;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: appCardDecoration(tint: AppColors.accentGold, radius: 20),
      child: Row(
        children: [
          const CircleIcon(icon: Icons.notifications_active, color: AppColors.accentGold, size: 46),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.statsActive(totalActive),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryText),
                ),
                const SizedBox(height: 2),
                if (nextOccurrence != null)
                  Text(
                    '${l10n.statsNext}$nextTitle · ${_formatNextOccurrence(context, nextOccurrence)}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13, height: 1.3, color: AppColors.secondaryText),
                  )
                else
                  Text(
                    l10n.statsSummary,
                    style: const TextStyle(fontSize: 13, color: AppColors.secondaryText),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatNextOccurrence(BuildContext context, DateTime occurrence) {
    final l10n = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final occurrenceDate = DateTime(occurrence.year, occurrence.month, occurrence.day);
    final timeStr = DateFormat('HH:mm').format(occurrence);

    if (occurrenceDate == today) {
      return l10n.statsTodayTime(timeStr);
    } else if (occurrenceDate == today.add(const Duration(days: 1))) {
      return l10n.statsTomorrowTime(timeStr);
    } else {
      return DateFormat('dd/MM, HH:mm', l10n.localeName).format(occurrence);
    }
  }
}
