import 'dart:ui' as ui;

import 'package:sanctaconscientia/services/database_service.dart';

/// Helper class to provide localized notification strings
/// without needing a BuildContext. Uses saved locale preference.
class NotificationStrings {
  /// Get the prayer reminder title
  static Future<String> getPrayerReminderTitle() async {
    final locale = await _getSavedLocale();
    return _getLocalizedString('prayerReminderTitle', locale);
  }
  
  /// Get the confession reminder title
  static Future<String> getConfessionReminderTitle() async {
    final locale = await _getSavedLocale();
    return _getLocalizedString('confessionReminderTitle', locale);
  }
  
  /// Get the novena reminder title
  static Future<String> getNovenaReminderTitle() async {
    final locale = await _getSavedLocale();
    return _getLocalizedString('novenaReminderTitle', locale);
  }
  
  /// Get the penance reminder title
  static Future<String> getPenanceReminderTitle() async {
    final locale = await _getSavedLocale();
    return _getLocalizedString('penanceReminderTitle', locale);
  }
  
  /// Get the rosary reminder title
  static Future<String> getRosaryReminderTitle() async {
    final locale = await _getSavedLocale();
    return _getLocalizedString('rosaryReminderTitle', locale);
  }

  static Future<String> getPreceptTitle() async {
    final locale = await _getSavedLocale();
    return _getLocalizedString('preceptNotificationTitle', locale);
  }

  static Future<String> getPreceptBody() async {
    final locale = await _getSavedLocale();
    return _getLocalizedString('preceptNotificationBody', locale);
  }

  static Future<String> getAbstinenceTitle() async {
    final locale = await _getSavedLocale();
    return _getLocalizedString('abstinenceNotificationTitle', locale);
  }

  static Future<String> getAbstinenceBody() async {
    final locale = await _getSavedLocale();
    return _getLocalizedString('abstinenceNotificationBody', locale);
  }

  static Future<String> getFastingTitle() async {
    final locale = await _getSavedLocale();
    return _getLocalizedString('fastingNotificationTitle', locale);
  }

  static Future<String> getAshWednesdayBody() async {
    final locale = await _getSavedLocale();
    return _getLocalizedString('ashWednesdayBody', locale);
  }

  static Future<String> getGoodFridayBody() async {
    final locale = await _getSavedLocale();
    return _getLocalizedString('goodFridayBody', locale);
  }
  
  /// Idioma do app: o escolhido nas configurações ('app_locale') ou, se nunca
  /// foi escolhido, o do aparelho (inglês se for inglês, senão português).
  static Future<String> _getSavedLocale() async {
    try {
      final saved = await DatabaseService().getSetting('app_locale');
      if (saved == 'pt' || saved == 'en') return saved!;
    } catch (_) {}
    return ui.PlatformDispatcher.instance.locale.languageCode == 'en' ? 'en' : 'pt';
  }

  /// Texto simples (sem parâmetros) no idioma do app.
  static Future<String> text(String key) async =>
      _getLocalizedString(key, await _getSavedLocale());

  /// "Rosário Completo (3 Terços)" / "Full Rosary (3 five-decade Rosaries)"
  static Future<String> rosaryCompleteLog(int chaplets) async =>
      (await text('rosaryCompleteLog')).replaceAll('{n}', '$chaplets');

  /// "Dia 3" / "Day 3"
  static Future<String> novenaDay(int n) async =>
      (await text('novenaDay')).replaceAll('{n}', '$n');

  /// Get localized string based on key and locale
  static String _getLocalizedString(String key, String locale) {
    final strings = _localizedStrings[locale] ?? _localizedStrings['pt']!;
    return strings[key] ?? _localizedStrings['pt']![key] ?? key;
  }
  
  /// Map of all localized notification strings
  static final Map<String, Map<String, String>> _localizedStrings = {
    'pt': {
      'prayerReminderTitle': 'Lembrete de Oração',
      'confessionReminderTitle': 'Lembrete de Confissão',
      'confessionReminderDescription': 'Prepare-se com o Exame de Consciência!',
      'confessionDayToday': 'Hoje',
      'confessionDayTomorrow': 'Amanhã',
      'confessionDayInDays': 'Em {days} dias',
      'confessionReminderBody': '{dayLabel} é o dia da sua confissão. Prepare-se com o Exame de Consciência!',
      'penanceReminderTitle': 'Lembrete de Penitência',
      'novenaReminderTitle': 'Lembrete de Novena',
      'rosaryReminderTitle': 'Hora do Santo Terço',
      'preceptNotificationTitle': 'Dia de Preceito',
      'preceptNotificationBody': 'Hoje é Domingo! Dia do Senhor.',
      'abstinenceNotificationTitle': 'Abstinência',
      'abstinenceNotificationBody': 'Hoje é Sexta-feira. Dia de penitência.',
      'fastingNotificationTitle': 'Jejum e Abstinência',
      'ashWednesdayBody': 'Quarta-feira de Cinzas',
      'goodFridayBody': 'Sexta-feira Santa',
      'novenaDay': 'Dia {n}',
      'rosaryCompleteLog': 'Rosário Completo ({n} Terços)',
      'prayerFallback': 'Oração',
      'channelConfessionName': 'Confissão',
      'channelConfessionDesc': 'Lembretes de Confissão',
      'channelNovenaName': 'Novenas',
      'channelNovenaDesc': 'Lembretes de Novenas',
      'channelPrayerName': 'Orações',
      'channelPrayerDesc': 'Lembretes de Orações e AppSancta',
    },
    'en': {
      'prayerReminderTitle': 'Prayer Reminder',
      'confessionReminderTitle': 'Confession Reminder',
      'confessionReminderDescription': 'Prepare yourself with the Examination of Conscience!',
      'confessionDayToday': 'Today',
      'confessionDayTomorrow': 'Tomorrow',
      'confessionDayInDays': 'In {days} days',
      'confessionReminderBody': '{dayLabel} is your confession day. Prepare yourself with the Examination of Conscience!',
      'penanceReminderTitle': 'Penance Reminder',
      'novenaReminderTitle': 'Novena Reminder',
      'rosaryReminderTitle': 'Rosary Time',
      'preceptNotificationTitle': 'Holy Day of Obligation',
      'preceptNotificationBody': 'Today is Sunday! The Lord\'s Day.',
      'abstinenceNotificationTitle': 'Abstinence',
      'abstinenceNotificationBody': 'Today is Friday. Day of penance.',
      'fastingNotificationTitle': 'Fasting and Abstinence',
      'ashWednesdayBody': 'Ash Wednesday',
      'goodFridayBody': 'Good Friday',
      'novenaDay': 'Day {n}',
      'rosaryCompleteLog': 'Full Rosary ({n} five-decade Rosaries)',
      'prayerFallback': 'Prayer',
      'channelConfessionName': 'Confession',
      'channelConfessionDesc': 'Confession reminders',
      'channelNovenaName': 'Novenas',
      'channelNovenaDesc': 'Novena reminders',
      'channelPrayerName': 'Prayers',
      'channelPrayerDesc': 'Prayer and AppSancta reminders',
    },
  };
  
  /// Get the confession reminder body with day label
  static Future<String> getConfessionReminderBody(int daysInAdvance) async {
    final locale = await _getSavedLocale();
    final strings = _localizedStrings[locale] ?? _localizedStrings['pt']!;
    
    String dayLabel;
    if (daysInAdvance == 0) {
      dayLabel = strings['confessionDayToday']!;
    } else if (daysInAdvance == 1) {
      dayLabel = strings['confessionDayTomorrow']!;
    } else {
      dayLabel = strings['confessionDayInDays']!.replaceAll('{days}', daysInAdvance.toString());
    }
    
    return strings['confessionReminderBody']!.replaceAll('{dayLabel}', dayLabel);
  }
  
  /// Get the confession reminder description
  static Future<String> getConfessionReminderDescription() async {
    final locale = await _getSavedLocale();
    return _getLocalizedString('confessionReminderDescription', locale);
  }
}
