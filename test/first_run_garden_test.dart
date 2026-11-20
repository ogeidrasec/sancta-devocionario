// Primeira execução de verdade (banco e preferências vazios): o Jardim
// precisa aparecer na aba Hoje, com ou sem o guia.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:sanctaconscientia/main.dart';
import 'package:sanctaconscientia/pages/plano_vida/widgets/garden_heatmap.dart';
import 'package:sanctaconscientia/services/database_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final dbDirReady = databaseFactoryFfi.setDatabasesPath('.dart_tool/test_db_first_run');

  setUp(() async {
    await dbDirReady;
    SharedPreferences.setMockInitialValues({});
    await DatabaseService().wipeAllDataForTests();
    AndroidFlutterLocalNotificationsPlugin.registerWith();
    final m = TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    m.setMockMethodCallHandler(const MethodChannel('dexterous.com/flutter/local_notifications'), (c) async => null);
    m.setMockMethodCallHandler(const MethodChannel('flutter_timezone'), (c) async => 'America/Sao_Paulo');
  });

  Future<void> pumpFor(WidgetTester tester, Finder f, {int max = 120}) async {
    for (var i = 0; i < max && f.evaluate().isEmpty; i++) {
      await tester.runAsync(() => Future.delayed(const Duration(milliseconds: 30)));
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  for (final withTour in [true, false]) {
    testWidgets('primeira execução ${withTour ? 'com' : 'sem'} o guia: o Jardim aparece', (tester) async {
      tester.view.physicalSize = const Size(393, 852) * 2.75;
      tester.view.devicePixelRatio = 2.75;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(const MyApp());
      await pumpFor(tester, find.byKey(const ValueKey('onb_skip')));
      await tester.tap(find.byKey(const ValueKey('onb_skip')));
      await pumpFor(tester, find.byKey(ValueKey(withTour ? 'onb_tour_start' : 'onb_tour_skip')));
      await tester.pump(const Duration(milliseconds: 600));
      await tester.runAsync(() async {
        await tester.tap(find.byKey(ValueKey(withTour ? 'onb_tour_start' : 'onb_tour_skip')));
        await Future.delayed(const Duration(milliseconds: 500));
      });
      for (var i = 0; i < 40; i++) {
        await tester.runAsync(() => Future.delayed(const Duration(milliseconds: 20)));
        await tester.pump(const Duration(milliseconds: 100));
      }
      final garden = find.byType(GardenHeatmap);
      await pumpFor(tester, garden, max: 200);
      for (var i = 0; i < 100 && tester.getRect(garden).height < 200; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }
      expect(garden, findsOneWidget);
      final r = tester.getRect(garden);
      expect(r.height, greaterThan(200), reason: 'o Jardim tem conteúdo');
      // o idioma da 1ª execução vem do sistema (aqui, inglês)
      expect(find.byWidgetPredicate((w) => w is Text && (w.data == 'Jardim da Alma' || w.data == 'Garden of the Soul')), findsOneWidget);
      expect(tester.takeException(), isNull);
      if (withTour) {
        await pumpFor(tester, find.byKey(const ValueKey('tour_skip')), max: 200);
        await tester.pump(const Duration(milliseconds: 800));
        await tester.tap(find.byKey(const ValueKey('tour_skip')));
        await pumpFor(tester, find.byKey(const ValueKey('project_dialog')), max: 200);
        await tester.tap(find.byKey(const ValueKey('project_dialog_later')));
      }
      for (var i = 0; i < 30; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }
      await tester.runAsync(() => Future.delayed(const Duration(milliseconds: 800)));
    });
  }
}
