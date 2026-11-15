// Terço × Rosário: um Rosário completo são 3 terços no modo tradicional ou
// 4 no modo atual (contados por dia).
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/services/database_service.dart';
import 'package:sanctaconscientia/services/notification_service.dart';
import 'package:sanctaconscientia/services/reminder_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final dbDirReady = databaseFactoryFfi.setDatabasesPath('.dart_tool/test_db_rosary_count');

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

  int completes(PrayerProvider p) => p.prayerLogs.where((l) => l['prayerId'] == 'rosary_complete').length;

  Future<void> pray(String id, {DateTime? at}) =>
      provider.logPrayer('Terço', at ?? DateTime.now(), prayerId: id);

  test('quantos terços formam um Rosário', () {
    expect(PrayerProvider.chapletsPerRosary(traditional: true), 3);
    expect(PrayerProvider.chapletsPerRosary(traditional: false), 4);
  });

  test('modo tradicional (padrão): 3 terços = 1 Rosário', () async {
    await pray('rosary_joyful');
    expect(provider.chapletsToday, 1);
    expect(completes(provider), 0);
    await pray('rosary_sorrowful');
    expect(completes(provider), 0);
    await pray('rosary_glorious');
    expect(provider.chapletsToday, 3);
    expect(completes(provider), 1);
    expect(provider.prayerLogs.firstWhere((l) => l['prayerId'] == 'rosary_complete')['title'], contains('3'));
  });

  test('modo atual: precisa de 4 terços (com os luminosos)', () async {
    await DatabaseService().saveSetting('rosary_traditional', 'false');
    await pray('rosary_joyful');
    await pray('rosary_luminous');
    await pray('rosary_sorrowful');
    expect(completes(provider), 0, reason: '3 terços ainda não completam no modo atual');
    await pray('rosary_glorious');
    expect(completes(provider), 1);
  });

  test('mais terços no mesmo dia = mais Rosários', () async {
    for (final id in ['rosary_joyful', 'rosary_sorrowful', 'rosary_glorious']) {
      await pray(id);
    }
    expect(completes(provider), 1);
    await pray('rosary_joyful');
    await pray('rosary_joyful');
    expect(completes(provider), 1);
    await pray('rosary_joyful');
    expect(provider.chapletsToday, 6);
    expect(completes(provider), 2);
  });

  test('cada dia conta separado', () async {
    final ontem = DateTime.now().subtract(const Duration(days: 1));
    await pray('rosary_joyful', at: ontem);
    await pray('rosary_sorrowful', at: ontem);
    await pray('rosary_glorious');
    expect(provider.chapletsOn(ontem), 2);
    expect(provider.chapletsToday, 1);
    expect(completes(provider), 0);
  });

  test('apagar um terço desfaz o Rosário completo do dia', () async {
    for (final id in ['rosary_joyful', 'rosary_sorrowful', 'rosary_glorious']) {
      await pray(id);
    }
    expect(completes(provider), 1);
    final glorious = provider.prayerLogs.firstWhere((l) => l['prayerId'] == 'rosary_glorious');
    await provider.deletePrayerLog(glorious);
    expect(provider.chapletsToday, 2);
    expect(completes(provider), 0);

    // e o registro some também depois de reiniciar o app
    final reloaded = PrayerProvider(
      reminderService: ReminderService(
        databaseService: DatabaseService(),
        notificationService: NotificationService(),
      ),
    );
    await reloaded.loadData();
    expect(completes(reloaded), 0);
  });

  test('marcar o terço no check conta como 1 terço (e desmarcar desconta)', () async {
    final today = DateFormat('yyyyMMdd').format(DateTime.now());
    await provider.toggleDailyPrayer(today, 'rosary', title: 'Santo Terço');
    expect(provider.chapletsToday, 1);
    await provider.toggleDailyPrayer(today, 'rosary');
    expect(provider.chapletsToday, 0);
  });

  test('check do terço + terços rezados na página não contam em dobro; 3 checks-dia completam o Rosário', () async {
    final today = DateFormat('yyyyMMdd').format(DateTime.now());
    // fluxo da página do terço: mistério + marca do plano
    await pray('rosary_joyful');
    await provider.toggleDailyPrayer(today, 'rosary', title: 'Santo Terço');
    expect(provider.chapletsToday, 1);
    await pray('rosary_sorrowful');
    await pray('rosary_glorious');
    expect(provider.chapletsToday, 3);
    expect(completes(provider), 1);
  });

  test('várias cópias do terço no plano marcadas no check completam o Rosário', () async {
    final today = DateFormat('yyyyMMdd').format(DateTime.now());
    for (final id in ['rosary', 'rosary_1700000000001', 'rosary_1700000000002']) {
      await provider.toggleDailyPrayer(today, id, title: 'Santo Terço');
    }
    expect(provider.chapletsToday, 3);
    expect(completes(provider), 1);
    await provider.toggleDailyPrayer(today, 'rosary_1700000000002');
    expect(completes(provider), 0);
  });

  test('outras orações não contam como terço', () async {
    await pray('rosary_joyful');
    await provider.logPrayer('Pai Nosso', DateTime.now(), prayerId: 'pater_noster');
    await provider.logPrayer('Santo Terço (plano)', DateTime.now(), prayerId: 'rosary');
    expect(provider.chapletsToday, 1);
  });
}
