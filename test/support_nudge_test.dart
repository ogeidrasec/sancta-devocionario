// Lembrete gentil de apoio: quando aparece, quando some e o cartão na aba Hoje.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/services/database_service.dart';
import 'package:sanctaconscientia/services/support_nudge.dart';
import 'package:sanctaconscientia/widgets/support_nudge_card.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final dbDirReady = databaseFactoryFfi.setDatabasesPath('.dart_tool/test_db_support_nudge');

  final first = DateTime(2026, 3, 1, 10);
  DateTime day(int n) => first.add(Duration(days: n));

  group('regras', () {
    test('nada nos 3 primeiros dias de uso', () {
      for (final n in [0, 1, 2]) {
        expect(SupportNudge.decide(now: day(n), firstOpen: first).show, isFalse, reason: 'dia $n');
      }
      final r = SupportNudge.decide(now: day(3), firstOpen: first);
      expect(r.show, isTrue);
      expect(r.newCycle, DateTime(2026, 3, 4));
    });

    test('aparece só no dia do ciclo e volta um mês depois', () {
      final cycle = DateTime(2026, 3, 4);
      expect(SupportNudge.decide(now: day(3), firstOpen: first, cycleStart: cycle).show, isTrue);
      expect(SupportNudge.decide(now: day(4), firstOpen: first, cycleStart: cycle).show, isFalse,
          reason: 'some sozinho no dia seguinte');
      expect(SupportNudge.decide(now: day(32), firstOpen: first, cycleStart: cycle).show, isFalse);
      final back = SupportNudge.decide(now: day(33), firstOpen: first, cycleStart: cycle);
      expect(back.show, isTrue);
      expect(back.newCycle, DateTime(2026, 4, 3));
    });

    test('"Agora não" esconde no mesmo dia', () {
      final cycle = DateTime(2026, 3, 4);
      expect(SupportNudge.decide(now: day(3), firstOpen: first, cycleStart: cycle, dismissedOn: day(3)).show, isFalse);
    });

    test('adiamento (oração ou já apoiou) vale até a data', () {
      final until = day(3).add(SupportNudge.prayerSnooze);
      expect(SupportNudge.decide(now: day(30), firstOpen: first, snoozeUntil: until).show, isFalse);
      expect(SupportNudge.decide(now: until, firstOpen: first, snoozeUntil: until).show, isTrue);
    });
  });

  group('com o banco', () {
    setUp(() async {
      await dbDirReady;
      SharedPreferences.setMockInitialValues({});
      await DatabaseService().wipeAllDataForTests();
    });

    test('primeiro uso é gravado; no 3º dia aparece e grava o ciclo', () async {
      expect(await SupportNudge.shouldShow(now: day(0)), isFalse);
      expect(await DatabaseService().getSetting(SupportNudge.firstOpenKey), isNotNull);
      expect(await SupportNudge.shouldShow(now: day(3)), isTrue);
      expect(await SupportNudge.shouldShow(now: day(3).add(const Duration(hours: 5))), isTrue, reason: 'o dia todo');
      await SupportNudge.notNow(now: day(3));
      expect(await SupportNudge.shouldShow(now: day(3)), isFalse);
      expect(await SupportNudge.shouldShow(now: day(17)), isFalse);
      expect(await SupportNudge.shouldShow(now: day(32)), isFalse);
      expect(await SupportNudge.shouldShow(now: day(33)), isTrue, reason: 'um mês depois');
    });

    test('"Já apoiei" some por 90 dias', () async {
      await SupportNudge.shouldShow(now: day(0));
      await SupportNudge.snooze(SupportNudge.supportedSnooze, now: day(3));
      expect(await SupportNudge.shouldShow(now: day(60)), isFalse);
      expect(await SupportNudge.shouldShow(now: day(93)), isTrue);
    });
  });

  Widget app(Widget child) => MaterialApp(
        locale: const Locale('pt'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: ListView(children: [child])),
      );

  testWidgets('cartão aparece quando é a vez e some ao fechar', (tester) async {
    await tester.pumpWidget(app(SupportNudgeCard(shouldShowOverride: () async => true)));
    await tester.pumpAndSettle();
    expect(find.text('Um pedido dos noivos'), findsOneWidget);
    expect(find.byKey(const ValueKey('nudge_support')), findsOneWidget);
    expect(find.byKey(const ValueKey('nudge_pray')), findsOneWidget);
    expect(find.byKey(const ValueKey('nudge_supported')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('nudge_close')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('support_nudge')), findsNothing);
  });

  testWidgets('cartão não aparece fora da vez', (tester) async {
    await tester.pumpWidget(app(SupportNudgeCard(shouldShowOverride: () async => false)));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('support_nudge')), findsNothing);
  });
}
