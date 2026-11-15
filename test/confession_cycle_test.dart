// Ciclo da confissão: o lembrete toca uma vez por data, e quem repete é o
// intervalo ("a cada 2 semanas depois de cada confissão").
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/models/reminder_model.dart';
import 'package:sanctaconscientia/providers/confession_provider.dart';
import 'package:sanctaconscientia/services/database_service.dart';
import 'package:sanctaconscientia/services/notification_service.dart';
import 'package:sanctaconscientia/services/reminder_service.dart';
import 'package:sanctaconscientia/utils/reminder_text.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final dbDirReady = databaseFactoryFfi.setDatabasesPath('.dart_tool/test_db_confession_cycle');

  setUpAll(() {
    tzdata.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/Sao_Paulo'));
  });

  late ReminderService reminders;
  late ConfessionProvider confession;

  setUp(() async {
    await dbDirReady;
    SharedPreferences.setMockInitialValues({});
    AndroidFlutterLocalNotificationsPlugin.registerWith();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        const MethodChannel('dexterous.com/flutter/local_notifications'), (c) async => null);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('flutter_timezone'), (c) async => 'America/Sao_Paulo');
    await DatabaseService().wipeAllDataForTests();
    reminders = ReminderService(databaseService: DatabaseService(), notificationService: NotificationService());
    await reminders.loadReminders();
    confession = ConfessionProvider(reminderService: reminders);
    await confession.loadData();
  });

  DateTime day(DateTime d) => DateTime(d.year, d.month, d.day);

  test('confirmar a confissão recria o lembrete para o próximo ciclo', () async {
    await confession.setConfessionInterval(14);
    await confession.setNextConfessionDate(DateTime.now().add(const Duration(days: 3)));
    await confession.setConfessionReminder(const TimeOfDay(hour: 9, minute: 0), daysInAdvance: 1);

    final before = reminders.getReminderById('confession_reminder')!;
    expect(before.recurrence, RecurrenceType.once, reason: 'o lembrete em si não repete: o ciclo é que repete');

    final done = day(DateTime.now());
    await confession.confirmarConfissao(date: done);

    expect(day(confession.nextConfessionDate!), done.add(const Duration(days: 14)));
    final after = reminders.getReminderById('confession_reminder')!;
    // 1 dia antes da confissão seguinte, às 9h
    expect(after.startDate, DateTime(done.year, done.month, done.day + 13, 9, 0));
    expect(after.times.single, const TimeOfDay(hour: 9, minute: 0));
    expect(confession.confessionInterval, 14);
  });

  test('lembrete pausado em Lembretes continua pausado depois de cada confissão', () async {
    await confession.setConfessionInterval(14);
    await confession.setNextConfessionDate(DateTime.now().add(const Duration(days: 3)));
    await confession.setConfessionReminder(const TimeOfDay(hour: 9, minute: 0), daysInAdvance: 1);

    await reminders.toggleActive('confession_reminder'); // usuário pausa
    expect(reminders.getReminderById('confession_reminder')!.isActive, isFalse);

    await confession.confirmarConfissao(date: DateTime.now());
    expect(reminders.getReminderById('confession_reminder')!.isActive, isFalse,
        reason: 'antes ele voltava ligado sozinho');
  });

  test('sem intervalo não há próximo ciclo: a data some e o lembrete é cancelado', () async {
    await confession.setNextConfessionDate(DateTime.now().add(const Duration(days: 3)));
    await confession.setConfessionReminder(const TimeOfDay(hour: 9, minute: 0), daysInAdvance: 1);
    await confession.confirmarConfissao(date: DateTime.now());
    expect(confession.nextConfessionDate, isNull);
    expect(reminders.getReminderById('confession_reminder'), isNull);
  });

  testWidgets('o texto do ciclo aparece em português e inglês', (tester) async {
    late BuildContext captured;
    Future<AppLocalizations> l10nFor(String lang) async {
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
      return AppLocalizations.of(captured)!;
    }

    final pt = await l10nFor('pt');
    expect(confessionCycleText(pt, 14), 'A cada 2 semanas, depois de cada confissão marcada como realizada');
    expect(confessionCycleText(pt, 7), 'A cada semana, depois de cada confissão marcada como realizada');
    expect(confessionCycleText(pt, 30), 'A cada mês, depois de cada confissão marcada como realizada');
    expect(confessionCycleText(pt, 10), 'A cada 10 dias, depois de cada confissão marcada como realizada');
    expect(confessionCycleText(pt, null), contains('Sem repetição'));

    final en = await l10nFor('en');
    expect(confessionCycleText(en, 14), 'Every 2 weeks, after each confession marked as done');
    expect(confessionCycleText(en, 7), 'Every week, after each confession marked as done');
  });
}
