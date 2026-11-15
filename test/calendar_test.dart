// Calendário: resumo do mês, navegação, botão Hoje e registro do dia.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/pages/plano_vida/historico_tab.dart';
import 'package:sanctaconscientia/providers/confession_provider.dart';
import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/services/database_service.dart';
import 'package:sanctaconscientia/services/notification_service.dart';
import 'package:sanctaconscientia/services/reminder_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final dbDirReady = databaseFactoryFfi.setDatabasesPath('.dart_tool/test_db_calendar');

  late PrayerProvider prayers;
  late ConfessionProvider confessions;

  setUp(() async {
    await dbDirReady;
    SharedPreferences.setMockInitialValues({});
    AndroidFlutterLocalNotificationsPlugin.registerWith();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        const MethodChannel('dexterous.com/flutter/local_notifications'), (c) async => null);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('flutter_timezone'), (c) async => 'America/Sao_Paulo');
    await DatabaseService().wipeAllDataForTests();
    final reminders = ReminderService(
      databaseService: DatabaseService(),
      notificationService: NotificationService(),
    );
    prayers = PrayerProvider(reminderService: reminders);
    confessions = ConfessionProvider(reminderService: reminders);
    await prayers.loadData();
    await confessions.loadData();
  });

  Future<void> pumpCalendar(WidgetTester tester, {String lang = 'pt'}) async {
    tester.view.physicalSize = const Size(800, 4000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider<PrayerProvider>.value(value: prayers),
        ChangeNotifierProvider<ConfessionProvider>.value(value: confessions),
      ],
      child: MaterialApp(
        locale: Locale(lang),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(body: HistoricoTab()),
      ),
    ));
    await tester.pumpAndSettle();
  }

  testWidgets('resumo do mês conta dias com oração, missas e terços', (tester) async {
    final now = DateTime.now();
    await tester.runAsync(() async {
      await prayers.logPrayer('Pai Nosso', now, prayerId: 'pater_noster');
      await prayers.logPrayer('Mistérios Gozosos', now, prayerId: 'rosary_joyful');
      await prayers.toggleMass(now);
    });
    await pumpCalendar(tester);

    expect(find.text('RESUMO DO MÊS'), findsOneWidget);
    expect(find.text('1 dia com oração'), findsOneWidget);
    expect(find.text('1 dia de terço'), findsOneWidget);
    expect(find.text('1 missa'), findsOneWidget);
    expect(find.text('0 confissões'), findsOneWidget);
  });

  testWidgets('registro do dia mostra o que foi feito e o botão Hoje aparece ao navegar', (tester) async {
    final now = DateTime.now();
    await tester.runAsync(() async {
      await prayers.logPrayer('Pai Nosso', now, prayerId: 'pater_noster');
      await prayers.toggleMass(now);
    });
    await pumpCalendar(tester);

    expect(find.text('REGISTRO DO DIA'), findsOneWidget);
    expect(find.text('Pai Nosso'), findsOneWidget); // oração do dia
    expect(find.text('Missa'), findsWidgets); // missa no registro e no atalho
    expect(find.text('Hoje'), findsNothing); // já está em hoje

    await tester.tap(find.byIcon(Icons.chevron_right).first);
    await tester.pumpAndSettle();
    expect(find.text('Hoje'), findsOneWidget);

    await tester.tap(find.text('Hoje'));
    await tester.pumpAndSettle();
    expect(find.text('Hoje'), findsNothing);
    expect(find.text('Pai Nosso'), findsOneWidget);
  });

  testWidgets('dia futuro mostra a dica e sem atalhos de missa e confissão', (tester) async {
    await pumpCalendar(tester);
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    // só testa se amanhã cai no mesmo mês exibido
    if (tomorrow.month != DateTime.now().month) return;
    await tester.tap(find.text('${tomorrow.day}').last);
    await tester.pumpAndSettle();
    expect(find.textContaining('Dia futuro'), findsOneWidget);
    expect(find.text('Confissão'), findsOneWidget); // só a legenda, não o botão de atalho
  });

  testWidgets('próximos dias: seção presente e em inglês', (tester) async {
    await pumpCalendar(tester, lang: 'en');
    expect(find.text('COMING UP'), findsOneWidget);
    expect(find.text('MONTH SUMMARY'), findsOneWidget);
    expect(find.text('RECORD OF THE DAY'), findsOneWidget);
  });
}
