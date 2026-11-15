// Opções de uma oração em "Hoje": botão de mais opções (ou segurar) abre o menu
// (abrir, ajustar, excluir). Deslizar não faz nada: fica livre para trocar de aba.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/pages/plano_vida/widgets/prayer_tile.dart';
import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/services/database_service.dart';
import 'package:sanctaconscientia/services/notification_service.dart';
import 'package:sanctaconscientia/services/reminder_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final dbDirReady = databaseFactoryFfi.setDatabasesPath('.dart_tool/test_db_prayer_tile_swipe');

  late PrayerProvider provider;

  setUp(() async {
    await dbDirReady;
    SharedPreferences.setMockInitialValues({});
    AndroidFlutterLocalNotificationsPlugin.registerWith();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        const MethodChannel('dexterous.com/flutter/local_notifications'), (c) async => null);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('flutter_timezone'), (c) async => 'America/Sao_Paulo');
    await DatabaseService().wipeAllDataForTests();
    provider = PrayerProvider(
      reminderService: ReminderService(
        databaseService: DatabaseService(),
        notificationService: NotificationService(),
      ),
    );
    await provider.loadData();
  });

  Future<void> pumpTile(WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(ChangeNotifierProvider<PrayerProvider>.value(
      value: provider,
      child: MaterialApp(
        locale: const Locale('pt'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: PrayerTile(
            prayer: PrayerListItem(id: 'pater_noster', title: 'Pai Nosso', type: PrayerType.planned, isCompleted: false),
            dateKey: '20260101',
            prayerProvider: provider,
          ),
        ),
      ),
    ));
    await tester.pumpAndSettle();
  }

  testWidgets('o botão de mais opções abre o menu com "Abrir oração" e "Excluir do plano"', (tester) async {
    await pumpTile(tester);
    await tester.tap(find.byKey(const ValueKey('more_pater_noster')));
    await tester.pumpAndSettle();

    expect(find.text('Abrir oração'), findsOneWidget);
    expect(find.text('Excluir do plano'), findsOneWidget);
    expect(find.text('Momento e lembrete'), findsOneWidget);
    expect(find.text('Remover oração'), findsNothing, reason: 'a confirmação só vem depois de escolher excluir');
  });

  testWidgets('fechar o menu mantém a oração na lista', (tester) async {
    await pumpTile(tester);
    await tester.tap(find.byKey(const ValueKey('more_pater_noster')));
    await tester.pumpAndSettle();
    await tester.tapAt(const Offset(400, 40)); // fora da folha
    await tester.pumpAndSettle();
    expect(find.byType(PrayerTile), findsOneWidget);
    expect(find.text('Abrir oração'), findsNothing);
  });

  testWidgets('"Abrir oração" abre a oração e não exclui', (tester) async {
    await pumpTile(tester);
    await tester.tap(find.byKey(const ValueKey('more_pater_noster')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('prayer_action_open')));
    await tester.pumpAndSettle();
    expect(find.text('Abrir oração'), findsNothing);
    expect(find.text('Remover oração'), findsNothing);
    // saiu da tela do menu e navegou para a oração
    expect(find.text('Pai Nosso'), findsWidgets);
  });

  testWidgets('"Excluir do plano" pede confirmação antes de remover', (tester) async {
    await pumpTile(tester);
    await tester.tap(find.byKey(const ValueKey('more_pater_noster')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('prayer_action_remove')));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);

    await tester.tap(find.text('Cancelar'));
    await tester.pumpAndSettle();
    expect(find.byType(PrayerTile), findsOneWidget);
  });

  testWidgets('deslizar para o lado não abre nada nem exclui', (tester) async {
    await pumpTile(tester);
    await tester.drag(find.byType(PrayerTile), const Offset(-500, 0));
    await tester.pumpAndSettle();
    expect(find.text('Abrir oração'), findsNothing);
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(PrayerTile), findsOneWidget);
  });

  testWidgets('segurar a oração também abre o menu', (tester) async {
    await pumpTile(tester);
    await tester.longPress(find.byType(PrayerTile));
    await tester.pumpAndSettle();
    expect(find.text('Abrir oração'), findsOneWidget);
  });
}
