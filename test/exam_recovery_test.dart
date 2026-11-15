// "Recuperar acesso" (senha esquecida) precisa apagar de verdade os dados do
// exame: antes só limpava dados antigos e deixava o exame acessível com a nova senha.
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:sanctaconscientia/providers/confession_provider.dart';
import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/services/database_service.dart';
import 'package:sanctaconscientia/services/notification_service.dart';
import 'package:sanctaconscientia/services/reminder_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final dbDirReady = databaseFactoryFfi.setDatabasesPath('.dart_tool/test_db_exam_recovery');

  setUp(() async {
    await dbDirReady;
    SharedPreferences.setMockInitialValues({});
    AndroidFlutterLocalNotificationsPlugin.registerWith();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        const MethodChannel('dexterous.com/flutter/local_notifications'), (c) async => null);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('flutter_timezone'), (c) async => 'America/Sao_Paulo');
    await DatabaseService().wipeAllDataForTests();
  });

  test('apagarDadosDoExame remove exame, histórico, datas e senha, mas preserva orações', () async {
    final db = DatabaseService();
    final reminders = ReminderService(databaseService: db, notificationService: NotificationService());
    final confession = ConfessionProvider(reminderService: reminders);
    final prayers = PrayerProvider(reminderService: reminders);
    await confession.loadData();
    await prayers.loadData();

    await confession.incrementarPecado('antes-1-0');
    await confession.incrementarPecado('mandamentos-1-0');
    await confession.confirmarConfissao(date: DateTime(2026, 1, 10), penanceNote: 'Rezar um terço');
    await confession.incrementarPecado('antes-1-1');
    await db.saveSetting('password_hash', 'hash-antigo');
    await db.saveSetting('next_confession', DateTime(2026, 2, 1).toIso8601String());
    await prayers.logPrayer('Santo Terço', DateTime.now(), prayerId: 'rosary');
    await prayers.addIntention('Pela paz');

    expect((await db.loadPecados()), isNotEmpty);
    expect((await db.loadConfessionHistory()), isNotEmpty);

    await confession.apagarDadosDoExame();

    expect(await db.loadPecados(), isEmpty);
    expect(await db.loadConfessionHistory(), isEmpty);
    expect(await db.getSetting('last_confession'), isNull);
    expect(await db.getSetting('next_confession'), isNull);
    expect(await db.getSetting('password_hash'), isNull);
    expect(confession.totalPecados, 0);
    expect(confession.dataUltimaConfissao, isNull);
    expect(confession.confessionHistory, isEmpty);

    // orações e intenções não são exame: continuam
    final reloaded = PrayerProvider(reminderService: reminders);
    await reloaded.loadData();
    expect(reloaded.prayerLogs, isNotEmpty);
    expect(reloaded.intentions, hasLength(1));
  });
}
