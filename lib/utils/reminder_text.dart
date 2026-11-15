import 'package:flutter/material.dart';
import 'package:sanctaconscientia/data/novena_data.dart';
import 'package:sanctaconscientia/data/prayer_data.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/models/reminder_model.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';

/// Título de um lembrete no idioma do app. O texto salvo no banco pode estar em
/// outro idioma (ou ser um título padrão antigo), então, quando o lembrete vem
/// de uma novena, de uma oração ou do calendário litúrgico, usa o título atual.
String localizedReminderTitle(BuildContext context, ReminderModel reminder) {
  final l10n = AppLocalizations.of(context)!;

  if (reminder.id == 'liturgical_precept') return l10n.liturgicalReminderPrecept;
  if (reminder.id == 'liturgical_abstinence') return l10n.liturgicalReminderAbstinence;
  if (reminder.id == 'liturgical_ash_wednesday' || reminder.id == 'liturgical_good_friday') {
    return l10n.liturgicalReminderFasting;
  }

  // Novena: pelo novenaId (ou extraído do id do lembrete)
  String? novenaId = reminder.novenaId;
  if ((novenaId == null || novenaId.isEmpty) && reminder.id.startsWith('novena_')) {
    novenaId = reminder.id.replaceFirst('novena_', '');
  }
  if (novenaId != null && novenaId.isNotEmpty) {
    if (!novenaId.startsWith('novena_')) novenaId = 'novena_$novenaId';
    try {
      final content = NovenaData.getNovenaById(context, novenaId);
      // getNovenaById devolve a primeira novena se não achar: confere o id
      if (content.id == novenaId || novenaId == 'novena_natal') return content.title;
    } catch (_) {}
  }

  // Oração do catálogo
  if (reminder.prayerId != null && reminder.prayerId!.isNotEmpty) {
    final prayerData = PrayerData.getPrayerById(context, reminder.prayerId!);
    if (prayerData != null && prayerData['title'] != null) return prayerData['title'] as String;
  }

  // Título salvo (menos os títulos padrão antigos)
  if (reminder.title.isNotEmpty && !const {'Hora de Rezar', 'Lembrete de Oração', 'Prayer Reminder'}.contains(reminder.title)) {
    return reminder.title;
  }
  return reminder.title.isNotEmpty ? reminder.title : l10n.statsDefaultTitle;
}

/// Ícone e cor de cada tipo de lembrete.
({IconData icon, Color color}) reminderTypeStyle(ReminderType type) {
  switch (type) {
    case ReminderType.prayer:
      return (icon: Icons.favorite_border, color: AppColors.themeColor);
    case ReminderType.novena:
      return (icon: Icons.local_florist, color: AppColors.accentGold);
    case ReminderType.examination:
      return (icon: Icons.assignment, color: const Color(0xFF6A1B9A));
    case ReminderType.rosary:
      return (icon: Icons.auto_awesome, color: const Color(0xFFD94452));
    case ReminderType.confession:
      return (icon: Icons.volunteer_activism, color: const Color(0xFF8E44AD));
    case ReminderType.penance:
      return (icon: Icons.assignment_turned_in, color: Colors.orange);
    case ReminderType.custom:
      return (icon: Icons.notifications_none, color: AppColors.secondaryText);
  }
}

/// Descrição do ciclo automático da confissão ("A cada 2 semanas, depois de cada
/// confissão marcada como realizada"), a partir do intervalo em dias.
String confessionCycleText(AppLocalizations l10n, int? days) {
  if (days == null || days <= 0) return l10n.confessionCycleNone;
  final String period;
  if (days == 30) {
    period = l10n.cyclePeriodMonth;
  } else if (days % 7 == 0) {
    period = l10n.cyclePeriodWeeks(days ~/ 7);
  } else {
    period = l10n.cyclePeriodDays(days);
  }
  return l10n.confessionCycleText(period);
}
