// Missa: registro por dia, persistência, sequência de domingos e união no backup.
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/services/database_service.dart';
import 'package:sanctaconscientia/services/notification_service.dart';
import 'package:sanctaconscientia/services/reminder_service.dart';

DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final dbDirReady = databaseFactoryFfi.setDatabasesPath('.dart_tool/test_db_mass');

  PrayerProvider newProvider() => PrayerProvider(
        reminderService: ReminderService(
          databaseService: DatabaseService(),
          notificationService: NotificationService(),
        ),
      );

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
    provider = newProvider();
    await provider.loadData();
  });

  test('marcar e desmarcar a missa do dia', () async {
    final today = _day(DateTime.now());
    expect(provider.hasMassOn(today), isFalse);
    expect(await provider.toggleMass(today), isTrue);
    expect(provider.hasMassOn(today), isTrue);
    expect(provider.massDates.map(_day), contains(today));
    expect(await provider.toggleMass(today), isFalse);
    expect(provider.hasMassOn(today), isFalse);
  });

  test('o registro sobrevive ao reiniciar o app', () async {
    final yesterday = _day(DateTime.now()).subtract(const Duration(days: 1));
    await provider.toggleMass(yesterday);

    final reloaded = newProvider();
    await reloaded.loadData();
    expect(reloaded.hasMassOn(yesterday), isTrue);
  });

  test('contagem do mês', () async {
    final now = DateTime.now();
    final first = DateTime(now.year, now.month, 1);
    await provider.toggleMass(first);
    await provider.toggleMass(DateTime(now.year, now.month, 2));
    expect(provider.massCountInMonth(now), 2);
    expect(provider.massCountInMonth(DateTime(now.year - 1, now.month)), 0);
  });

  test('sequência de domingos: o domingo de hoje sem registro não quebra', () async {
    final now = _day(DateTime.now());
    final lastSunday = now.subtract(Duration(days: now.weekday % 7));
    // três domingos seguidos terminando no domingo atual (ou no mais recente)
    for (var i = 0; i < 3; i++) {
      await provider.toggleMass(lastSunday.subtract(Duration(days: 7 * i)));
    }
    expect(provider.sundayMassStreak, 3);

    // um domingo faltando interrompe a contagem
    await provider.toggleMass(lastSunday.subtract(const Duration(days: 7)));
    expect(provider.sundayMassStreak, 1);
  });

  test('backup: dias de missa são unidos aos existentes', () {
    final merged = {
      ...PrayerProvider.decodeMassDays('["2026-01-04","2026-01-11"]'),
      ...PrayerProvider.decodeMassDays('["2026-01-11","2026-01-18"]'),
    };
    expect(merged, {'2026-01-04', '2026-01-11', '2026-01-18'});
    expect(PrayerProvider.decodeMassDays('lixo'), isEmpty);
    expect(PrayerProvider.decodeMassDays(null), isEmpty);
  });
}
