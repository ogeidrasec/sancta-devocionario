// Folha única de adicionar oração: busca, escolha do que fazer conforme o dia
// (hoje: "rezei agora" ou plano; passado: registra; lembrete: agenda).
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/pages/plano_vida_page.dart';
import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/providers/settings_provider.dart';
import 'package:sanctaconscientia/services/database_service.dart';
import 'package:sanctaconscientia/services/notification_service.dart';
import 'package:sanctaconscientia/services/reminder_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final dbDirReady = databaseFactoryFfi.setDatabasesPath('.dart_tool/test_db_add_sheet');

  late PrayerProvider prayers;

  setUp(() async {
    await dbDirReady;
    SharedPreferences.setMockInitialValues({});
    AndroidFlutterLocalNotificationsPlugin.registerWith();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        const MethodChannel('dexterous.com/flutter/local_notifications'), (c) async => null);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('flutter_timezone'), (c) async => 'America/Sao_Paulo');
    await DatabaseService().wipeAllDataForTests();
    prayers = PrayerProvider(
      reminderService: ReminderService(
        databaseService: DatabaseService(),
        notificationService: NotificationService(),
      ),
    );
    await prayers.loadData();
  });

  Future<void> openSheet(WidgetTester tester, DateTime date, {bool reminderMode = false}) async {
    tester.view.physicalSize = const Size(800, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider<PrayerProvider>.value(value: prayers),
        ChangeNotifierProvider<SettingsProvider>(create: (_) => SettingsProvider()),
      ],
      child: MaterialApp(
        locale: const Locale('pt'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Builder(
            builder: (context) => Center(
              child: ElevatedButton(
                onPressed: () => PlanoVidaPage.showPrayerSelectionDialog(context, date, reminderMode: reminderMode),
                child: const Text('abrir'),
              ),
            ),
          ),
        ),
      ),
    ));
    await tester.tap(find.text('abrir'));
    await tester.pumpAndSettle();
  }

  /// Dá tempo real para a gravação no banco e atualiza a tela.
  Future<void> settleDb(WidgetTester tester) async {
    for (var i = 0; i < 10; i++) {
      await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 100)));
      await tester.pump();
    }
  }

  testWidgets('hoje: escolher uma oração pergunta "Rezei agora" ou "plano"; "agora" registra', (tester) async {
    final today = DateTime.now();
    await openSheet(tester, today);
    expect(find.text('Adicionar Oração'), findsOneWidget);
    expect(find.text('Para hoje'), findsOneWidget);

    await tester.tap(find.text('Pai Nosso').first);
    await tester.pumpAndSettle();
    expect(find.text('Rezei agora'), findsOneWidget);
    expect(find.text('Adicionar ao meu plano'), findsOneWidget);

    await tester.tap(find.text('Rezei agora'));
    await tester.pumpAndSettle();
    await settleDb(tester);
    expect(prayers.prayerLogs.where((l) => l['prayerId'] == 'pater_noster'), isNotEmpty);
  });

  testWidgets('dia passado: registra direto, sem perguntar', (tester) async {
    final past = DateTime.now().subtract(const Duration(days: 3));
    await openSheet(tester, past);
    expect(find.textContaining('Registrar como rezada em'), findsOneWidget);

    await tester.tap(find.text('Pai Nosso').first);
    await tester.pumpAndSettle();
    expect(find.text('Rezei agora'), findsNothing);
    await settleDb(tester);
    final logs = prayers.prayerLogs.where((l) => l['prayerId'] == 'pater_noster').toList();
    expect(logs, hasLength(1));
    expect(DateTime.parse(logs.first['timestamp']!).day, past.day);
  });

  testWidgets('a busca mistura orações e novenas e tolera erros', (tester) async {
    await openSheet(tester, DateTime.now());
    await tester.enterText(find.byType(TextField), 'apareceda');
    await tester.pumpAndSettle();
    expect(find.text('Novena a Nossa Senhora Aparecida'), findsOneWidget);
    expect(find.text('Novena'), findsWidgets); // rótulo do tipo no resultado

    await tester.enterText(find.byType(TextField), 'contriçao');
    await tester.pumpAndSettle();
    expect(find.text('Ato de Contrição'), findsWidgets);

    await tester.enterText(find.byType(TextField), 'qwertyuiop');
    await tester.pumpAndSettle();
    expect(find.textContaining('Nenhuma oração encontrada'), findsOneWidget);
  });

  testWidgets('modo lembrete: título próprio e vai direto ao horário do lembrete', (tester) async {
    await openSheet(tester, DateTime.now(), reminderMode: true);
    expect(find.text('Novo lembrete de oração'), findsOneWidget);

    await tester.tap(find.text('Pai Nosso').first);
    await tester.pumpAndSettle();
    // Diálogo de agendamento com o lembrete já ligado e um horário sugerido
    final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
    expect(checkbox.value, isTrue);
    expect(checkbox.onChanged, isNull, reason: 'no modo lembrete o lembrete é obrigatório');
    expect(find.byIcon(Icons.access_time), findsOneWidget);
  });
}
