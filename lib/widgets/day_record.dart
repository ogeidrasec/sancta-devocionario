import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sanctaconscientia/data/novena_data.dart';
import 'package:sanctaconscientia/data/prayer_data.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';

/// Tipo de um registro de um dia (define o ícone, a cor e o rótulo).
enum DayEntryKind { prayer, rosary, rosaryComplete, novena, mass, confession, penance }

/// Um item já feito em um dia: oração, terço, novena, missa, confissão ou
/// penitência. Usado em "Feito hoje" (aba Hoje) e no registro do dia (Calendário).
class DayEntry {
  final DayEntryKind kind;
  final String title;

  /// Horário em que foi feito (nulo quando não se sabe).
  final DateTime? time;
  final IconData? icon;

  /// Desfaz o registro (marca de novo como pendente ou apaga). Nulo = não pode.
  final Future<void> Function()? onUndo;

  /// Pede confirmação antes de desfazer (apagar um registro avulso).
  final bool confirmUndo;

  const DayEntry({
    required this.kind,
    required this.title,
    this.time,
    this.icon,
    this.onUndo,
    this.confirmUndo = false,
  });

  static final RegExp _novenaDayId = RegExp(r'^(novena_[a-z_]+)_day_(\d+)$');

  /// Transforma um registro de oração (`prayerLogs`) em item do dia.
  ///
  /// [synthetic]: o registro foi inferido de uma marcação do plano (sem
  /// horário real); desfazer então só desmarca o plano.
  static DayEntry fromLog(
    BuildContext context,
    PrayerProvider prayers,
    Map<String, String> log, {
    bool synthetic = false,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final plan = prayers.availablePrayers;
    final id = log['prayerId'] ?? '';
    final stamp = DateTime.parse(log['timestamp']!);
    final dateKey = log['dateKey'] ?? DateFormat('yyyyMMdd').format(stamp);
    // Registros de dias passados feitos "sem hora" ficam à meia-noite: sem horário
    final hasTime = !synthetic && !(stamp.hour == 0 && stamp.minute == 0 && stamp.second == 0);
    final time = hasTime ? stamp : null;
    final inPlan = plan.any((p) => p['id'] == id);
    final novenaMatch = _novenaDayId.firstMatch(id);

    Future<void> uncheckPlan() => prayers.toggleDailyPrayer(dateKey, id);
    Future<void> deleteLog() => prayers.removePrayerLogAndUncheck(log);

    if (id == 'rosary_complete') {
      return DayEntry(kind: DayEntryKind.rosaryComplete, title: log['title'] ?? '', time: time);
    }
    if (novenaMatch != null) {
      final day = int.parse(novenaMatch.group(2)!);
      String novenaTitle;
      try {
        novenaTitle = NovenaData.getNovenaById(context, novenaMatch.group(1)!).title;
      } catch (_) {
        novenaTitle = novenaMatch.group(1)!;
      }
      return DayEntry(
        kind: DayEntryKind.novena,
        title: '$novenaTitle · ${l10n.novenaDay(day)}',
        time: time,
        onUndo: uncheckPlan,
      );
    }
    if (id.startsWith('rosary') && !inPlan) {
      return DayEntry(
        kind: DayEntryKind.rosary,
        title: PrayerData.localizedLogTitle(context, log),
        time: time,
        onUndo: deleteLog,
        confirmUndo: true,
      );
    }
    final data = id.isEmpty ? null : PrayerData.getPrayerById(context, id);
    return DayEntry(
      kind: id.startsWith('rosary') ? DayEntryKind.rosary : DayEntryKind.prayer,
      title: inPlan
          ? PrayerData.localizedPlanTitle(context, plan.firstWhere((p) => p['id'] == id))
          : PrayerData.localizedLogTitle(context, log),
      time: time,
      icon: data?['icon'] as IconData?,
      onUndo: inPlan || synthetic ? uncheckPlan : deleteLog,
      confirmUndo: !(inPlan || synthetic),
    );
  }
}

/// Cartão de um item do dia: ícone por tipo com selo de "feito", título,
/// horário e rótulo, e o botão de desfazer (ou apagar, com confirmação).
class DayEntryTile extends StatelessWidget {
  final DayEntry entry;
  const DayEntryTile({super.key, required this.entry});

  (IconData, Color, String) _style(AppLocalizations l10n) {
    switch (entry.kind) {
      case DayEntryKind.mass:
        return (Icons.church, const Color(0xFFB7791F), l10n.todayKindMass);
      case DayEntryKind.confession:
        return (Icons.volunteer_activism, Colors.purple, l10n.todayKindConfession);
      case DayEntryKind.penance:
        return (Icons.assignment_turned_in, Colors.orange, l10n.todayKindPenance);
      case DayEntryKind.novena:
        return (Icons.local_florist, AppColors.accentGold, l10n.todayKindNovena);
      case DayEntryKind.rosary:
        return (Icons.auto_awesome, AppColors.accentGold, l10n.todayKindRosary);
      case DayEntryKind.rosaryComplete:
        return (Icons.stars, AppColors.accentGold, l10n.todayKindRosary);
      case DayEntryKind.prayer:
        return (entry.icon ?? Icons.favorite_border, AppColors.themeColor, l10n.todayKindPrayer);
    }
  }

  Future<void> _undo(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    if (entry.confirmUndo) {
      final ok = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(l10n.removeRosaryTitle),
          content: Text(l10n.removeRosaryContent(entry.title)),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l10n.cancelButton)),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(l10n.removeButton, style: const TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );
      if (ok != true) return;
    }
    await entry.onUndo!();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final style = _style(l10n);
    final subtitle = [
      if (entry.time != null) DateFormat('HH:mm').format(entry.time!),
      style.$3,
    ].join(' · ');

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        decoration: appCardDecoration(tint: style.$2),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 4, 10),
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleIcon(icon: style.$1, color: style.$2, size: 42),
                  const Positioned(
                    right: -2,
                    bottom: -2,
                    child: Icon(Icons.check_circle, size: 16, color: AppColors.successColor),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.title,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.primaryText),
                    ),
                    const SizedBox(height: 2),
                    Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.secondaryText)),
                  ],
                ),
              ),
              if (entry.onUndo != null)
                IconButton(
                  tooltip: l10n.undoAction,
                  icon: Icon(
                    entry.confirmUndo ? Icons.delete_outline : Icons.undo,
                    size: 20,
                    color: entry.confirmUndo ? Colors.red : AppColors.secondaryText,
                  ),
                  onPressed: () => _undo(context),
                )
              else
                const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
