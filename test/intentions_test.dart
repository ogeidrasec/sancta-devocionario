// Intenções de oração: criar, editar, marcar graça recebida, apagar/desfazer,
// persistência e união no backup.
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
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
  final dbDirReady = databaseFactoryFfi.setDatabasesPath('.dart_tool/test_db_intentions');

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

  test('adicionar, editar, marcar e apagar com desfazer', () async {
    await provider.addIntention('  Pela saúde da minha avó ');
    expect(provider.intentions, hasLength(1));
    final item = provider.intentions.first;
    expect(item['text'], 'Pela saúde da minha avó');
    expect(item['answered'], false);

    await provider.updateIntention(item['id'] as String, 'Pela saúde da vovó');
    expect(provider.intentions.first['text'], 'Pela saúde da vovó');

    await provider.toggleIntentionAnswered(item['id'] as String);
    expect(provider.intentions.first['answered'], true);
    await provider.toggleIntentionAnswered(item['id'] as String);
    expect(provider.intentions.first['answered'], false);

    final snapshot = Map<String, dynamic>.from(provider.intentions.first);
    await provider.deleteIntention(item['id'] as String);
    expect(provider.intentions, isEmpty);
    await provider.restoreIntention(snapshot);
    await provider.restoreIntention(snapshot); // não duplica
    expect(provider.intentions, hasLength(1));
  });

  test('as intenções sobrevivem ao reiniciar o app', () async {
    await provider.addIntention('Pela paz');
    final reloaded = newProvider();
    await reloaded.loadData();
    expect(reloaded.intentions.single['text'], 'Pela paz');
  });

  test('leitura tolera dados inválidos', () {
    expect(PrayerProvider.decodeIntentions('lixo'), isEmpty);
    expect(PrayerProvider.decodeIntentions(null), isEmpty);
    expect(PrayerProvider.decodeIntentions('[{"id":1,"text":"x"},{"id":"a","text":"ok"}]').single['id'], 'a');
  });
}
