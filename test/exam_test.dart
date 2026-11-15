// Testes da página Exame: contagem de itens marcados, botão do guia e selos.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/pages/examination_home_page.dart';
import 'package:sanctaconscientia/providers/confession_provider.dart';
import 'package:sanctaconscientia/providers/liturgical_provider.dart';
import 'package:sanctaconscientia/services/database_service.dart';
import 'package:sanctaconscientia/services/notification_service.dart';
import 'package:sanctaconscientia/services/reminder_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  // Cada arquivo de teste usa o próprio banco: os testes rodam em paralelo e
  // compartilhar o mesmo arquivo SQLite causava "database is locked".
  final dbDirReady = databaseFactoryFfi.setDatabasesPath('.dart_tool/test_db_exam');

  late ReminderService reminders;
  late ConfessionProvider confession;

  setUp(() async {
    await dbDirReady;
    SharedPreferences.setMockInitialValues({});
    AndroidFlutterLocalNotificationsPlugin.registerWith();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
            const MethodChannel('dexterous.com/flutter/local_notifications'),
            (c) async => null);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
            const MethodChannel('flutter_timezone'), (c) async => 'America/Sao_Paulo');

    await DatabaseService().wipeAllDataForTests();
    reminders = ReminderService(
      databaseService: DatabaseService(),
      notificationService: NotificationService(),
    );
    confession = ConfessionProvider(reminderService: reminders);
    await confession.loadData();
  });

  group('Contagem de itens marcados', () {
    test('total e por categoria', () async {
      expect(confession.totalPecados, 0);

      await confession.incrementarPecado('antes-1-0');
      await confession.incrementarPecado('antes-1-0'); // mesmo item, 2 vezes
      await confession.incrementarPecado('mandamentos-3-1');

      expect(confession.totalPecados, 2); // itens distintos
      expect(confession.pecadosNaCategoria('antes'), 1);
      expect(confession.pecadosNaCategoria('mandamentos'), 1);
      expect(confession.pecadosNaCategoria('igreja'), 0);
    });

    test('desmarcar tudo zera a contagem', () async {
      await confession.incrementarPecado('igreja-1-2');
      await confession.decrementarPecado('igreja-1-2');
      expect(confession.totalPecados, 0);
    });
  });

  group('Home do Exame', () {
    Widget app() => MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: confession),
            ChangeNotifierProvider(
                create: (_) => LiturgicalProvider(reminderService: reminders)),
          ],
          child: MaterialApp(
            locale: const Locale('pt'),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: const ExaminationHomePage(),
          ),
        );

    ElevatedButton guideButton(WidgetTester tester) => tester.widget<ElevatedButton>(
          find.widgetWithText(ElevatedButton, 'GERAR GUIA PARA CONFISSÃO'),
        );

    testWidgets('sem nada marcado: botão desabilitado e dica visível', (tester) async {
      tester.view.physicalSize = const Size(822, 1782);
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(app());
      await tester.runAsync(() => Future.delayed(const Duration(milliseconds: 200)));
      await tester.pump(const Duration(milliseconds: 500));

      expect(guideButton(tester).onPressed, isNull);
      expect(find.text('Marque os pecados nas categorias para gerar o guia.'), findsOneWidget);
    });

    testWidgets('com itens marcados: botão habilitado, total e selo da categoria',
        (tester) async {
      tester.view.physicalSize = const Size(822, 1782);
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);

      await tester.runAsync(() => confession.incrementarPecado('antes-1-0'));
      await tester.pumpWidget(app());
      await tester.runAsync(() => Future.delayed(const Duration(milliseconds: 200)));
      await tester.pump(const Duration(milliseconds: 500));

      expect(guideButton(tester).onPressed, isNotNull);
      expect(find.text('1 item marcado no exame'), findsOneWidget);
      expect(find.text('1 marcado', skipOffstage: false), findsOneWidget); // selo no card "Antes da Confissão"
    });
  });
}
