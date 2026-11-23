import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/pages/spiritual_growth_page.dart';
import 'package:sanctaconscientia/providers/confession_provider.dart';
import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/services/database_service.dart';
import 'package:sanctaconscientia/services/notification_service.dart';
import 'package:sanctaconscientia/services/reminder_service.dart';
import 'package:sanctaconscientia/utils/liturgical_calendar.dart';
import 'package:sanctaconscientia/utils/spiritual_milestones.dart';
import 'package:sanctaconscientia/widgets/milestone_celebration.dart';
import 'package:sanctaconscientia/widgets/spiritual_growth_card.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final dbReady = databaseFactoryFfi.setDatabasesPath('.dart_tool/test_db_spiritual_growth');

  group('SpiritualMilestonesCalculator (unit)', () {
    test('histórico vazio começa com 0 metas e indica próxima meta', () {
      final snap = SpiritualMilestonesCalculator.compute(
        prayerLogs: const [],
        dailyPrayers: const {},
        massDates: const [],
        confessionDates: const [],
        novenaCompletions: 0,
        now: DateTime(2026, 11, 22),
      );

      expect(snap.achievedCount, 0);
      expect(snap.totalCount, 20);
      expect(snap.currentPrayerStreak, 0);
      expect(snap.currentRosaryStreak, 0);
      expect(snap.currentSundayMassStreak, 0);
      expect(snap.nextMilestone, isNotNull);
    });

    test('sequência diária de oração e de Terço conta corretamente (inclusive antes de rezar hoje)', () {
      final now = DateTime(2026, 11, 22, 9, 0);
      // 7 dias seguidos terminando ontem (15..21 nov)
      final logs = <Map<String, String>>[
        for (var i = 1; i <= 7; i++)
          {
            'prayerId': 'rosary_joyful',
            'title': 'Santo Terço',
            'timestamp': DateTime(2026, 11, 22 - i, 18, 0).toIso8601String(),
          },
      ];
      // Entrada duplicada em dailyPrayers no mesmo dia não deve duplicar o total de terços
      final daily = <String, int>{
        '20261121_rosary_joyful': 1,
      };

      final snap = SpiritualMilestonesCalculator.compute(
        prayerLogs: logs,
        dailyPrayers: daily,
        massDates: const [],
        confessionDates: const [],
        novenaCompletions: 0,
        now: now,
      );

      expect(snap.currentPrayerStreak, 7);
      expect(snap.bestPrayerStreak, 7);
      expect(snap.currentRosaryStreak, 7);
      expect(snap.bestRosaryStreak, 7);
      expect(snap.totalRosaries, 7);
      expect(snap.achievedIds, containsAll(['prayer_streak_3', 'prayer_streak_7', 'rosary_total_1', 'rosary_streak_7']));
    });

    test('calcula domingos seguidos na Missa e mês fiel aos dias de preceito', () {
      // Fevereiro de 2026 (não tem festa fixa de preceito além dos 4 domingos: 1, 8, 15, 22)
      final febPreceptDays = <DateTime>[
        for (var d = 1; d <= 28; d++)
          if (LiturgicalCalendar.isDayOfObligation(DateTime(2026, 2, d)))
            DateTime(2026, 2, d),
      ];

      final snap = SpiritualMilestonesCalculator.compute(
        prayerLogs: const [],
        dailyPrayers: const {},
        massDates: febPreceptDays,
        confessionDates: const [],
        novenaCompletions: 0,
        now: DateTime(2026, 3, 1, 10, 0), // Domingo seguinte ainda sem registro
      );

      expect(snap.currentSundayMassStreak, 4);
      expect(snap.bestSundayMassStreak, 4);
      expect(snap.perfectPreceptMonths, 1);
      expect(snap.achievedIds, containsAll(['mass_total_1', 'mass_sunday_4', 'mass_perfect_month_1']));
    });

    test('calcula novenas concluídas e confissões registradas', () {
      final snap = SpiritualMilestonesCalculator.compute(
        prayerLogs: const [],
        dailyPrayers: const {},
        massDates: const [],
        confessionDates: [
          DateTime(2026, 1, 10),
          DateTime(2026, 3, 15),
          DateTime(2026, 6, 20),
          DateTime(2026, 9, 12),
        ],
        novenaCompletions: 3,
        now: DateTime(2026, 11, 22),
      );

      expect(snap.totalNovenasCompleted, 3);
      expect(snap.totalConfessions, 4);
      expect(
        snap.achievedIds,
        containsAll(['novena_completed_1', 'novena_completed_3', 'confession_total_1', 'confession_total_4']),
      );
    });
  });

  group('SpiritualGrowth UI e Pop-up de Celebração', () {
    late PrayerProvider prayers;
    late ConfessionProvider confessions;

    setUp(() async {
      await dbReady;
      SharedPreferences.setMockInitialValues({});
      await DatabaseService().wipeAllDataForTests();
      final reminderService = ReminderService(
        databaseService: DatabaseService(),
        notificationService: NotificationService(),
      );
      prayers = PrayerProvider(reminderService: reminderService);
      confessions = ConfessionProvider(reminderService: reminderService);
      await prayers.loadData();
      await confessions.loadData();
    });

    Widget wrap(Widget home, {Locale locale = const Locale('pt')}) => MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: prayers),
            ChangeNotifierProvider.value(value: confessions),
          ],
          child: MaterialApp(
            locale: locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: home,
          ),
        );

    testWidgets('SpiritualGrowthPage e SpiritualGrowthCard não dão overflow em 320x568 com texto 1.6x', (tester) async {
      tester.view.physicalSize = const Size(320, 568);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(320, 568), textScaler: TextScaler.linear(1.6)),
          child: wrap(const Scaffold(body: SingleChildScrollView(child: SpiritualGrowthCard()))),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('spiritual_growth_card')), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.tap(find.byKey(const ValueKey('spiritual_growth_card')));
      await tester.pumpAndSettle();
      expect(find.byType(SpiritualGrowthPage), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('pop-up celebra nova meta alcançada ao registrar primeira Missa e não repete', (tester) async {
      await tester.pumpWidget(
        wrap(
          const MilestoneCelebrationWatcher(
            child: Scaffold(body: Center(child: Text('Home'))),
          ),
        ),
      );
      await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
      await tester.pumpAndSettle();

      // Nenhuma meta conquistada ainda -> sem pop-up
      expect(find.byKey(const ValueKey('milestone_celebration_dialog')), findsNothing);

      // Registrar primeira Missa desbloqueia mass_total_1
      await tester.runAsync(() => prayers.toggleMass(DateTime.now()));
      await tester.pump();
      await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.byKey(const ValueKey('milestone_celebration_dialog')), findsOneWidget);
      expect(find.text('Primeira Missa registrada'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('milestone_dialog_continue')));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('milestone_celebration_dialog')), findsNothing);

      // Desmarcar e marcar de novo não deve repetir o pop-up da mesma meta
      await tester.runAsync(() async {
        await prayers.toggleMass(DateTime.now());
        await prayers.toggleMass(DateTime.now());
      });
      await tester.pump();
      await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
      await tester.pump();
      expect(find.byKey(const ValueKey('milestone_celebration_dialog')), findsNothing);
    });
  });
}
