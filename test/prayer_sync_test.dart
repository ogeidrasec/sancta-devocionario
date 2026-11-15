// Testes da comunicação entre as telas: tudo passa pelo PrayerProvider, então
// o que é feito em uma tela precisa aparecer nas outras (Hoje, jardim, novenas).
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

DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  // Cada arquivo de teste usa o próprio banco: os testes rodam em paralelo e
  // compartilhar o mesmo arquivo SQLite causava "database is locked".
  final dbDirReady = databaseFactoryFfi.setDatabasesPath('.dart_tool/test_db_prayer_sync');

  late PrayerProvider provider;

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

    // Banco limpo a cada teste
    await DatabaseService().wipeAllDataForTests();

    provider = PrayerProvider(
      reminderService: ReminderService(
        databaseService: DatabaseService(),
        notificationService: NotificationService(),
      ),
    );
    await provider.loadData();
  });

  group('Novenas', () {
    test('novena concluída vai para o histórico e pode ser rezada de novo', () async {
      final now = _day(DateTime.now());
      final start = now.subtract(const Duration(days: 12)); // terminou há 3 dias

      await provider.startNovena('novena_sao_jose', startDate: start);
      expect(provider.activeNovenas.containsKey('novena_sao_jose'), isTrue);

      await provider.archiveFinishedNovenas();

      // saiu das ativas e não "invalida": conta como 1 vez concluída
      expect(provider.activeNovenas, isEmpty);
      expect(provider.novenaTimesCompleted('novena_sao_jose'), 1);
      expect(provider.isNovenaActive('novena_sao_jose'), isFalse);
      expect(provider.getNovenaStartDate('novena_sao_jose'), isNull);
      expect(provider.lastNovenaCompletion('novena_sao_jose'),
          start.add(const Duration(days: 8)));

      // o jardim continua marcando os dias em que foi rezada
      final midRun = start.add(const Duration(days: 3));
      expect(provider.getNovenasForDate(midRun).map((n) => n['id']),
          contains('novena_sao_jose'));

      // pode ser iniciada novamente, sem apagar o histórico
      await provider.startNovena('novena_sao_jose');
      expect(provider.isNovenaActive('novena_sao_jose'), isTrue);
      expect(provider.novenaTimesCompleted('novena_sao_jose'), 1);
    });

    test('histórico sobrevive ao recarregar os dados', () async {
      final start = _day(DateTime.now()).subtract(const Duration(days: 20));
      await provider.startNovena('novena_natal', startDate: start);
      await provider.archiveFinishedNovenas();

      await provider.loadData(); // simula reabrir o app
      expect(provider.novenaTimesCompleted('novena_natal'), 1);
    });

    test('rezar a mesma novena várias vezes soma o contador', () async {
      final today = _day(DateTime.now());
      await provider.startNovena('novena_almas', startDate: today.subtract(const Duration(days: 30)));
      await provider.archiveFinishedNovenas();
      await provider.startNovena('novena_almas', startDate: today.subtract(const Duration(days: 15)));
      await provider.archiveFinishedNovenas();
      expect(provider.novenaTimesCompleted('novena_almas'), 2);
    });

    test('destaque de "recém concluída" é temporário', () async {
      final today = _day(DateTime.now());
      // terminou ontem -> destaque
      await provider.startNovena('novena_natal', startDate: today.subtract(const Duration(days: 9)));
      await provider.archiveFinishedNovenas();
      expect(provider.novenaRecentlyCompleted('novena_natal'), isTrue);

      // terminou há 10 dias -> sem destaque, mas segue contando
      await provider.startNovena('novena_sao_jose', startDate: today.subtract(const Duration(days: 18)));
      await provider.archiveFinishedNovenas();
      expect(provider.novenaRecentlyCompleted('novena_sao_jose'), isFalse);
      expect(provider.novenaTimesCompleted('novena_sao_jose'), 1);
    });

    test('cancelar no meio não conta como concluída', () async {
      await provider.startNovena('novena_sao_miguel');
      await provider.cancelNovena('novena_sao_miguel');
      expect(provider.novenaTimesCompleted('novena_sao_miguel'), 0);
    });
  });

  group('Orações do dia', () {
    final todayKey = DateFormat('yyyyMMdd').format(DateTime.now());

    test('marcar como feita aparece no dia e vira log', () async {
      await provider.markPrayerDoneToday('daily_examination', 'Exame Diário');
      expect(provider.isDailyPrayerCompleted(todayKey, 'daily_examination'), isTrue);
      expect(provider.prayerLogs.where((l) => l['prayerId'] == 'daily_examination'), hasLength(1));
      expect(provider.getHeatmapData()[_day(DateTime.now())], 1);
    });

    test('repetir não desfaz nem duplica', () async {
      await provider.markPrayerDoneToday('rosary', 'Santo Terço');
      await provider.markPrayerDoneToday('rosary', 'Santo Terço');
      expect(provider.isDailyPrayerCompleted(todayKey, 'rosary'), isTrue);
      expect(provider.prayerLogs.where((l) => l['prayerId'] == 'rosary'), hasLength(1));
    });

    test('dia da novena marcado em um lugar vale no outro (mesmo id)', () async {
      await provider.toggleDailyPrayer(todayKey, 'novena_natal_day_3', title: 'Natal - Dia 3');
      expect(provider.isDailyPrayerCompleted(todayKey, 'novena_natal_day_3'), isTrue);
      await provider.toggleDailyPrayer(todayKey, 'novena_natal_day_3');
      expect(provider.isDailyPrayerCompleted(todayKey, 'novena_natal_day_3'), isFalse);
    });

    test('terço pelo mistério registra no jardim', () async {
      await provider.logPrayer('Mistérios Gozosos', DateTime.now(), prayerId: 'rosary_joyful');
      expect(provider.isDailyPrayerCompleted(todayKey, 'rosary_joyful'), isTrue);
      expect(provider.getHeatmapData()[_day(DateTime.now())], greaterThanOrEqualTo(1));
    });
  });
}
