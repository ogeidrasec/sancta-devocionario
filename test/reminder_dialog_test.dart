// Janela de lembrete: criação personalizada, dias da semana (segunda = 1) e
// edição de lembretes ligados a oração ou novena.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/models/reminder_model.dart';
import 'package:sanctaconscientia/pages/plano_vida/widgets/reminder_edit_dialog.dart';

void main() {
  ReminderModel? result;

  Future<void> open(WidgetTester tester, {ReminderModel? reminder, String lang = 'pt'}) async {
    tester.view.physicalSize = const Size(800, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    result = null;
    await tester.pumpWidget(MaterialApp(
      locale: Locale(lang),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: Builder(
          builder: (context) => Center(
            child: ElevatedButton(
              onPressed: () async {
                result = await showDialog<ReminderModel>(
                  context: context,
                  builder: (_) => ReminderEditDialog(reminder: reminder),
                );
              },
              child: const Text('abrir'),
            ),
          ),
        ),
      ),
    ));
    await tester.tap(find.text('abrir'));
    await tester.pumpAndSettle();
  }

  testWidgets('novo lembrete é personalizado: título, horário e repetição', (tester) async {
    await open(tester);
    expect(find.text('Novo Lembrete'), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.text('Diariamente'), findsOneWidget);
    expect(find.text('Semanalmente'), findsOneWidget);

    // título obrigatório
    await tester.tap(find.text('Criar'));
    await tester.pumpAndSettle();
    expect(result, isNull);
    expect(find.byType(TextFormField), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'Levar o terço');
    await tester.tap(find.text('Criar'));
    await tester.pumpAndSettle();
    expect(result, isNotNull);
    expect(result!.title, 'Levar o terço');
    expect(result!.type, ReminderType.custom);
    expect(result!.recurrence, RecurrenceType.daily);
    expect(result!.times, [const TimeOfDay(hour: 8, minute: 0)]);
  });

  testWidgets('semanal: segunda é 1 e domingo é 7 (a ordem mostrada começa na segunda)', (tester) async {
    await open(tester);
    await tester.enterText(find.byType(TextFormField), 'Terço da semana');
    await tester.tap(find.text('Semanalmente'));
    await tester.pumpAndSettle();

    final chips = find.byType(FilterChip);
    expect(chips, findsNWidgets(7));
    // primeira = segunda-feira (S), última = domingo (D)
    expect(tester.widget<FilterChip>(chips.first).label is Text, isTrue);
    expect(((tester.widget<FilterChip>(chips.last)).label as Text).data, 'D');

    // sem nenhum dia: avisa e não cria
    await tester.tap(find.text('Criar'));
    await tester.pumpAndSettle();
    expect(result, isNull);

    await tester.tap(chips.first); // segunda
    await tester.tap(chips.last); // domingo
    await tester.pumpAndSettle();
    await tester.tap(find.text('Criar'));
    await tester.pumpAndSettle();
    expect(result!.weekDays, [1, 7]);
  });

  testWidgets('lembrete de oração: mostra o nome (sem campo de texto) e preserva as ligações', (tester) async {
    final original = ReminderModel(
      id: 'prayer_1',
      title: 'Hora de Rezar',
      type: ReminderType.prayer,
      times: const [TimeOfDay(hour: 7, minute: 0)],
      recurrence: RecurrenceType.weekly,
      weekDays: const [1, 3],
      createdAt: DateTime(2026, 1, 1),
      startDate: DateTime(2026, 2, 2),
      prayerId: 'pater_noster',
    );
    await open(tester, reminder: original);
    expect(find.text('Editar Lembrete'), findsOneWidget);
    expect(find.byType(TextFormField), findsNothing);
    expect(find.text('Pai Nosso'), findsOneWidget);

    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();
    expect(result!.id, 'prayer_1');
    expect(result!.prayerId, 'pater_noster');
    expect(result!.startDate, DateTime(2026, 2, 2));
    expect(result!.weekDays, [1, 3]);
    expect(result!.type, ReminderType.prayer);
  });

  testWidgets('novena: sem escolha de repetição; continua diária por 9 dias', (tester) async {
    final novena = ReminderModel(
      id: 'novena_novena_aparecida',
      title: 'Novena',
      type: ReminderType.novena,
      times: const [TimeOfDay(hour: 20, minute: 0)],
      recurrence: RecurrenceType.daily,
      maxOccurrences: 9,
      createdAt: DateTime(2026, 1, 1),
      startDate: DateTime(2026, 10, 3),
      novenaId: 'novena_aparecida',
    );
    await open(tester, reminder: novena);
    expect(find.text('Diariamente'), findsNothing);
    expect(find.text('Novena a Nossa Senhora Aparecida'), findsOneWidget);

    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();
    expect(result!.maxOccurrences, 9);
    expect(result!.recurrence, RecurrenceType.daily);
    expect(result!.startDate, DateTime(2026, 10, 3));
  });

  testWidgets('inglês: textos e dias da semana começando na segunda', (tester) async {
    await open(tester, lang: 'en');
    expect(find.text('New Reminder'), findsOneWidget);
    await tester.tap(find.text('Weekly'));
    await tester.pumpAndSettle();
    final chips = find.byType(FilterChip);
    expect(((tester.widget<FilterChip>(chips.first)).label as Text).data, 'M');
    expect(((tester.widget<FilterChip>(chips.last)).label as Text).data, 'S');
  });
}
