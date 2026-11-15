// Folha "Ajustar oração": momento do dia e lembrete em botões, com retorno
// no mesmo formato de antes.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/pages/plano_vida/widgets/prayer_edit_dialog.dart';
import 'package:sanctaconscientia/providers/app_state.dart';
import 'package:sanctaconscientia/services/database_service.dart';
import 'package:sanctaconscientia/services/notification_service.dart';
import 'package:sanctaconscientia/services/reminder_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final dbDirReady = databaseFactoryFfi.setDatabasesPath('.dart_tool/test_db_prayer_edit_sheet');

  late ReminderService reminders;

  setUp(() async {
    await dbDirReady;
    SharedPreferences.setMockInitialValues({});
    AndroidFlutterLocalNotificationsPlugin.registerWith();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        const MethodChannel('dexterous.com/flutter/local_notifications'), (c) async => null);
    await DatabaseService().wipeAllDataForTests();
    reminders = ReminderService(databaseService: DatabaseService(), notificationService: NotificationService());
  });

  testWidgets('escolher momento e ligar lembrete devolve o resultado', (tester) async {
    tester.view.physicalSize = const Size(800, 1800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    Map<String, dynamic>? result;
    await tester.pumpWidget(ChangeNotifierProvider(
      create: (_) => AppState(reminderService: reminders),
      child: MaterialApp(
        locale: const Locale('pt'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () async {
                result = await showModalBottomSheet<Map<String, dynamic>>(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => const PrayerEditDialog(
                    prayerId: 'pater_noster',
                    prayerTitle: 'Pai Nosso',
                    currentDefaultTime: 'morning',
                  ),
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

    expect(find.text('Ajustar oração'), findsOneWidget);
    expect(find.text('Pai Nosso'), findsOneWidget);
    expect(find.text('Sem lembrete'), findsOneWidget);
    expect(find.byKey(const ValueKey('freq_daily')), findsNothing);

    await tester.tap(find.byKey(const ValueKey('moment_night')));
    await tester.tap(find.byKey(const ValueKey('reminder_switch')));
    await tester.pumpAndSettle();
    expect(find.text('O app vai avisar você'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('freq_weekly')));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();
    expect(result!['defaultTime'], 'night');
    expect(result!['hasReminder'], isTrue);
    expect(result!['frequency'], 'weekly');
    expect(result!['reminderTime'], isA<TimeOfDay>());
  });
}
