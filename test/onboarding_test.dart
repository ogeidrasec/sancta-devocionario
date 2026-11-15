// Boas-vindas: 6 telas, "Pular" leva ao convite do guia; "Começar sem o guia"
// abre o app sem o tour e "Ver o guia" abre com o tour.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/pages/main_scaffold.dart';
import 'package:sanctaconscientia/pages/onboarding_page.dart';
import 'package:sanctaconscientia/providers/app_state.dart';
import 'package:sanctaconscientia/providers/confession_provider.dart';
import 'package:sanctaconscientia/providers/liturgical_provider.dart';
import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/providers/settings_provider.dart';
import 'package:sanctaconscientia/services/database_service.dart';
import 'package:sanctaconscientia/services/notification_service.dart';
import 'package:sanctaconscientia/services/reminder_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final dbDirReady = databaseFactoryFfi.setDatabasesPath('.dart_tool/test_db_onboarding');

  setUpAll(() async {
    await dbDirReady;
    SharedPreferences.setMockInitialValues({});
    AndroidFlutterLocalNotificationsPlugin.registerWith();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        const MethodChannel('dexterous.com/flutter/local_notifications'), (c) async => null);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('flutter_timezone'), (c) async => 'America/Sao_Paulo');
  });

  Future<void> pumpOnb(WidgetTester tester) async {
    tester.view.physicalSize = const Size(360, 640) * 2;
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    final reminders = ReminderService(databaseService: DatabaseService(), notificationService: NotificationService());
    final settings = SettingsProvider();
    await tester.runAsync(() async => settings.setLocale(const Locale('pt')));
    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState(reminderService: reminders)),
        ChangeNotifierProvider.value(value: settings),
        ChangeNotifierProvider(create: (_) => ConfessionProvider(reminderService: reminders)),
        ChangeNotifierProvider(create: (_) => PrayerProvider(reminderService: reminders)),
        ChangeNotifierProvider(create: (_) => LiturgicalProvider(reminderService: reminders)),
      ],
      child: MaterialApp(
        locale: const Locale('pt'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const OnboardingPage(),
      ),
    ));
    await tester.pump();
  }

  Future<void> wait(WidgetTester tester, [int n = 8]) async {
    for (var i = 0; i < n; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  testWidgets('percorre as telas até o convite do guia', (tester) async {
    await pumpOnb(tester);
    expect(find.text('Bem-vindo ao Sancta Devocionário Católico'), findsOneWidget);
    for (final title in ['Tudo em um só lugar', 'Sua oração é só sua', 'Gratuito, feito com amor', 'Lembretes no seu horário']) {
      await tester.tap(find.byKey(const ValueKey('onb_next')));
      await wait(tester);
      expect(find.text(title), findsOneWidget);
    }
    await tester.tap(find.byKey(const ValueKey('onb_notif_later')));
    await wait(tester);
    expect(find.text('Tudo pronto!'), findsOneWidget);
    expect(find.byKey(const ValueKey('onb_tour_start')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Pular vai ao convite; começar sem o guia não abre o tour', (tester) async {
    await pumpOnb(tester);
    await tester.tap(find.byKey(const ValueKey('onb_skip')));
    await wait(tester);
    expect(find.text('Tudo pronto!'), findsOneWidget);
    await tester.runAsync(() async {
      await tester.tap(find.byKey(const ValueKey('onb_tour_skip')));
      await Future.delayed(const Duration(milliseconds: 300));
    });
    for (var i = 0; i < 150 && find.byType(MainScaffold).evaluate().isEmpty; i++) {
      await tester.runAsync(() => Future.delayed(const Duration(milliseconds: 100)));
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(find.byType(MainScaffold), findsOneWidget);
    expect(tester.widget<MainScaffold>(find.byType(MainScaffold)).startTour, isFalse);
  });
}
