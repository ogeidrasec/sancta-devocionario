// Backup leva os lembretes e as preferências (menos a senha do Exame).
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:sanctaconscientia/models/reminder_model.dart';
import 'package:sanctaconscientia/services/backup_service.dart';
import 'package:sanctaconscientia/services/database_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final dbDirReady = databaseFactoryFfi.setDatabasesPath('.dart_tool/test_db_backup_reminders');

  setUp(() async {
    await dbDirReady;
    SharedPreferences.setMockInitialValues({});
    AndroidFlutterLocalNotificationsPlugin.registerWith();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        const MethodChannel('dexterous.com/flutter/local_notifications'), (c) async => null);
    await DatabaseService().wipeAllDataForTests();
  });

  test('lembretes e preferências vão e voltam no backup; senha não vai', () async {
    final db = DatabaseService();
    await db.saveReminder(ReminderModel(
      id: 'custom_1',
      title: 'Levar o terço',
      type: ReminderType.custom,
      times: const [TimeOfDay(hour: 7, minute: 30)],
      recurrence: RecurrenceType.weekly,
      weekDays: const [1, 5],
      createdAt: DateTime(2026, 1, 1),
    ));
    await db.saveSetting('confession_interval', '14');
    await db.saveSetting('mass_guide_traditional', 'true');
    await db.saveSetting('password_hash', 'segredo');

    final data = await BackupService().collectDataForTests();
    expect((data['reminders'] as List).length, 1);
    expect((data['settings'] as Map)['confession_interval'], '14');
    expect(data.toString(), isNot(contains('segredo')));

    await db.wipeAllDataForTests();
    expect(await db.loadReminders(), isEmpty);

    await BackupService().restoreDataForTests(data);
    final restored = (await db.loadReminders()).map((j) => ReminderModel.fromJson(j as Map<String, dynamic>)).toList();
    expect(restored.single.title, 'Levar o terço');
    expect(restored.single.weekDays, [1, 5]);
    expect(restored.single.times.single, const TimeOfDay(hour: 7, minute: 30));
    expect(await db.getSetting('confession_interval'), '14');
    expect(await db.getSetting('mass_guide_traditional'), 'true');
  });

  test('backup antigo (sem lembretes) continua sendo aceito', () async {
    await BackupService().restoreDataForTests({'version': 1, 'settings': {'prayer_level': '2'}});
    expect(await DatabaseService().loadReminders(), isEmpty);
    expect(await DatabaseService().getSetting('prayer_level'), '2');
  });
}
