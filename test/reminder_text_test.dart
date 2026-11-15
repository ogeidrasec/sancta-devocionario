// Título do lembrete no idioma do app (o texto salvo pode estar em outro idioma).
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/models/reminder_model.dart';
import 'package:sanctaconscientia/utils/reminder_text.dart';

ReminderModel _reminder(String id, String title, {ReminderType type = ReminderType.custom, String? novenaId, String? prayerId}) =>
    ReminderModel(
      id: id,
      title: title,
      type: type,
      times: const [TimeOfDay(hour: 8, minute: 0)],
      recurrence: RecurrenceType.daily,
      createdAt: DateTime(2026, 1, 1),
      novenaId: novenaId,
      prayerId: prayerId,
    );

Future<BuildContext> _ctx(WidgetTester tester, String lang) async {
  late BuildContext captured;
  await tester.pumpWidget(MaterialApp(
    locale: Locale(lang),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Builder(builder: (c) {
      captured = c;
      return const SizedBox();
    }),
  ));
  await tester.pumpAndSettle();
  return captured;
}

void main() {
  testWidgets('avisos litúrgicos usam o texto do app, não o título salvo em inglês', (tester) async {
    final c = await _ctx(tester, 'pt');
    final l10n = AppLocalizations.of(c)!;
    expect(localizedReminderTitle(c, _reminder('liturgical_abstinence', 'Abstinence')), l10n.liturgicalReminderAbstinence);
    expect(localizedReminderTitle(c, _reminder('liturgical_abstinence', 'Abstinence')), isNot('Abstinence'));
    expect(localizedReminderTitle(c, _reminder('liturgical_precept', 'Precept')), l10n.liturgicalReminderPrecept);
    expect(localizedReminderTitle(c, _reminder('liturgical_ash_wednesday', 'Fasting')), l10n.liturgicalReminderFasting);
  });

  testWidgets('novena e oração aparecem pelo título atual do catálogo', (tester) async {
    final c = await _ctx(tester, 'pt');
    expect(
      localizedReminderTitle(c, _reminder('novena_novena_aparecida', 'Novena to Our Lady of Aparecida',
          type: ReminderType.novena, novenaId: 'novena_aparecida')),
      'Novena a Nossa Senhora Aparecida',
    );
    expect(
      localizedReminderTitle(c, _reminder('prayer_1', 'Hora de Rezar', type: ReminderType.prayer, prayerId: 'pater_noster')),
      'Pai Nosso',
    );
  });

  testWidgets('lembrete personalizado mantém o texto escolhido pelo usuário', (tester) async {
    final c = await _ctx(tester, 'en');
    expect(localizedReminderTitle(c, _reminder('custom_1', 'Levar o terço')), 'Levar o terço');
  });

  test('cada tipo de lembrete tem ícone e cor', () {
    for (final t in ReminderType.values) {
      final s = reminderTypeStyle(t);
      expect(s.icon, isNotNull);
    }
  });
}
