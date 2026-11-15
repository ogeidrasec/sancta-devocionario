import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/models/reminder_model.dart';
import 'package:sanctaconscientia/providers/app_state.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/pages/plano_vida/widgets/reminder_edit_dialog.dart';
import 'package:sanctaconscientia/utils/reminder_text.dart';
import 'package:sanctaconscientia/providers/confession_provider.dart';
import 'package:sanctaconscientia/utils/date_text.dart';
import 'package:sanctaconscientia/widgets/confession_scheduling_dialog.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';
import 'package:intl/intl.dart';

/// Cartão de um lembrete: tipo, título, horários, frequência, próximo toque e
/// as ações (liga/desliga, editar, apagar).
class ReminderCard extends StatelessWidget {
  final ReminderModel reminder;

  const ReminderCard({super.key, required this.reminder});

  Widget _line(IconData icon, String text, {Color? color, FontWeight? weight}) => Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 16, color: color ?? AppColors.secondaryText),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 13, height: 1.3, color: color ?? AppColors.primaryText, fontWeight: weight),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final style = reminderTypeStyle(reminder.type);
    final nextOccurrence = reminder.calculateNextOccurrence();
    final isLiturgical = reminder.id.startsWith('liturgical_');
    final isConfession = reminder.id == 'confession_reminder';
    final active = reminder.isActive;
    // O lembrete da confissão toca uma vez por data; quem repete é o ciclo
    // ("a cada 2 semanas depois de cada confissão"), guardado na confissão.
    final confession = isConfession ? Provider.of<ConfessionProvider>(context) : null;

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 6, 6),
      decoration: appCardDecoration(tint: style.color),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Opacity(opacity: active ? 1 : 0.5, child: CircleIcon(icon: style.icon, color: style.color, size: 44)),
              const SizedBox(width: 12),
              Expanded(
                child: Opacity(
                  opacity: active ? 1 : 0.55,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizedReminderTitle(context, reminder),
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryText),
                      ),
                      Text(
                        reminder.getTypeLabel(context),
                        style: const TextStyle(fontSize: 12, color: AppColors.secondaryText),
                      ),
                    ],
                  ),
                ),
              ),
              Switch(
                value: active,
                onChanged: (value) async {
                  final appState = Provider.of<AppState>(context, listen: false);
                  await appState.toggleReminderActive(reminder.id);
                },
              ),
            ],
          ),
          Opacity(
            opacity: active ? 1 : 0.55,
            child: Padding(
              padding: const EdgeInsets.only(right: 8, bottom: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _line(Icons.access_time, reminder.getTimesString()),
                  _line(
                    Icons.repeat,
                    isConfession
                        ? confessionCycleText(l10n, confession!.confessionInterval)
                        : reminder.getFrequencyDescription(context),
                  ),
                  if (isConfession && confession!.nextConfessionDate != null)
                    _line(
                      Icons.volunteer_activism,
                      l10n.confessionReminderPlanned(fmtDate(context, confession.nextConfessionDate!)),
                    ),
                  if (reminder.maxOccurrences != null && reminder.startDate != null)
                    _line(Icons.timelapse, _getRemainingText(context), color: AppColors.themeColor),
                  if (nextOccurrence != null)
                    _line(
                      Icons.event,
                      '${l10n.statsNext}${_formatOccurrence(context, nextOccurrence)}',
                      weight: FontWeight.w600,
                    )
                  else if (active && reminder.maxOccurrences != null)
                    _line(Icons.check_circle, l10n.novenaCompleted, color: AppColors.successColor, weight: FontWeight.w600),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Wrap(
              children: [
                if (isLiturgical)
                  TextButton.icon(
                    onPressed: () => _editLiturgicalTime(context),
                    icon: const Icon(Icons.access_time, size: 18),
                    label: Text(l10n.editButton),
                  )
                else ...[
                  TextButton.icon(
                    onPressed: () => isConfession ? _editConfession(context) : _editReminder(context),
                    icon: const Icon(Icons.edit_outlined, size: 18),
                    label: Text(l10n.editButton),
                  ),
                  TextButton.icon(
                    onPressed: () => _deleteReminder(context),
                    icon: const Icon(Icons.delete_outline, size: 18),
                    label: Text(l10n.removeButton),
                    style: TextButton.styleFrom(foregroundColor: Colors.red.shade400),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _editLiturgicalTime(BuildContext context) async {
    final TimeOfDay initialTime = reminder.times.isNotEmpty
        ? TimeOfDay(hour: reminder.times.first.hour, minute: reminder.times.first.minute)
        : const TimeOfDay(hour: 8, minute: 0);

    final time = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (time != null && context.mounted) {
      final appState = Provider.of<AppState>(context, listen: false);
      final updatedReminder = reminder.copyWith(times: [time]);
      await appState.updateReminder(updatedReminder);

      if (reminder.id == 'liturgical_ash_wednesday') {
        final gFriday = appState.getAllReminders().where((r) => r.id == 'liturgical_good_friday').firstOrNull;
        if (gFriday != null) {
          await appState.updateReminder(gFriday.copyWith(times: [time]));
        }
      }
    }
  }

  String _formatOccurrence(BuildContext context, DateTime occurrence) {
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

  /// A confissão se configura na janela da própria confissão (data, repetição,
  /// antecedência e horário), para não ficar diferente do que o Exame mostra.
  Future<void> _editConfession(BuildContext context) =>
      showDialog(context: context, builder: (_) => const ConfessionSchedulingDialog());

  Future<void> _editReminder(BuildContext context) async {
    final result = await showDialog<ReminderModel>(
      context: context,
      builder: (context) => ReminderEditDialog(reminder: reminder),
    );

    if (result != null && context.mounted) {
      final appState = Provider.of<AppState>(context, listen: false);
      await appState.updateReminder(result);
      if (context.mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.reminderUpdatedMessage(result.title))),
        );
      }
    }
  }

  Future<void> _deleteReminder(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final title = localizedReminderTitle(context, reminder);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.removeReminderTitle),
        content: Text(l10n.removeReminderContent(title)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.removeButton, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final appState = Provider.of<AppState>(context, listen: false);
      await appState.deleteReminder(reminder.id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.reminderRemovedMessage(title))),
        );
      }
    }
  }

  String _getRemainingText(BuildContext context) {
    if (reminder.startDate == null || reminder.maxOccurrences == null) return '';

    final l10n = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final start = DateTime(reminder.startDate!.year, reminder.startDate!.month, reminder.startDate!.day);
    final today = DateTime(now.year, now.month, now.day);

    final daysElapsed = today.difference(start).inDays + 1; // +1 porque o dia 1 é o de início
    final total = reminder.maxOccurrences!;

    if (daysElapsed < 1) {
      return l10n.novenaNotStarted;
    } else if (daysElapsed > total) {
      return l10n.novenaCompleted;
    } else {
      return l10n.novenaDayProgress(daysElapsed, total);
    }
  }
}
