// Resposta tátil (vibração) ao avançar no terço.
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/pages/rosary_mysteries_page.dart';
import 'package:sanctaconscientia/pages/rosary_prayer_page.dart';
import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/providers/settings_provider.dart';
import 'package:sanctaconscientia/services/database_service.dart';
import 'package:sanctaconscientia/services/haptics_service.dart';

/// Motor de vibração falso: guarda o que foi pedido.
class FakeBackend implements HapticsBackend {
  final bool vibrator;
  final bool amplitude;
  final calls = <String>[]; // 'vibrate:<ms>:<amp>' ou 'fallback:<tipo>'
  FakeBackend({this.vibrator = true, this.amplitude = true});

  @override
  Future<bool> hasVibrator() async => vibrator;
  @override
  Future<bool> hasAmplitudeControl() async => amplitude;
  @override
  Future<void> vibrate({required int durationMs, required int amplitude}) async =>
      calls.add('vibrate:$durationMs:$amplitude');
  @override
  Future<void> vibratePattern({required List<int> pattern, required List<int> intensities}) async =>
      calls.add('pattern:${pattern.join(',')}');
  @override
  Future<void> systemFallback(HapticKind kind) async => calls.add('fallback:${kind.name}');
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final dbDirReady = databaseFactoryFfi.setDatabasesPath('.dart_tool/test_db_haptics');

  late FakeBackend backend;

  setUp(() async {
    await dbDirReady;
    SharedPreferences.setMockInitialValues({});
    await DatabaseService().wipeAllDataForTests();
    backend = FakeBackend();
    HapticsService.backend = backend;
    HapticsService.resetCache();
  });

  group('HapticsService', () {
    test('usa o motor de vibração com a duração de cada intensidade', () async {
      await HapticsService.play(HapticKind.light);
      await HapticsService.play(HapticKind.medium);
      await HapticsService.play(HapticKind.heavy);

      expect(backend.calls, ['vibrate:25:110', 'vibrate:45:170', 'vibrate:90:255']);
    });

    test('quanto mais forte, mais longa a vibração', () async {
      for (final k in [HapticKind.selection, HapticKind.light, HapticKind.medium, HapticKind.heavy]) {
        await HapticsService.play(k);
      }
      final durations =
          backend.calls.map((c) => int.parse(c.split(':')[1])).toList();
      final sorted = [...durations]..sort();
      expect(durations, sorted);
    });

    test('fim de mistério: uma vibração longa, mais longa que todas as outras', () async {
      await HapticsService.play(HapticKind.decade);
      expect(backend.calls, ['vibrate:400:255']);
    });

    test('terço concluído: três vibrações curtas', () async {
      await HapticsService.play(HapticKind.finale);
      expect(backend.calls, ['pattern:0,90,110,90,110,90']);
    });

    test('sem controle de amplitude, só a duração é enviada', () async {
      backend = FakeBackend(amplitude: false);
      HapticsService.backend = backend;
      HapticsService.resetCache();

      await HapticsService.play(HapticKind.medium);
      expect(backend.calls, ['vibrate:45:-1']);
    });

    test('sem motor de vibração, cai para o recurso do sistema', () async {
      backend = FakeBackend(vibrator: false);
      HapticsService.backend = backend;
      HapticsService.resetCache();

      await HapticsService.play(HapticKind.light);
      expect(backend.calls, ['fallback:light']);
    });
  });

  group('Terço', () {
    Future<void> pumpRosary(WidgetTester tester, {required bool hapticsOn}) async {
      tester.view.physicalSize = const Size(822, 1782);
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);

      final settings = SettingsProvider();
      await tester.runAsync(() => settings.setHapticsEnabled(hapticsOn));

      await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: settings),
          ChangeNotifierProvider(create: (_) => PrayerProvider()),
        ],
        child: MaterialApp(
          locale: const Locale('pt'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const RosaryPrayerPage(mysteryType: MysteryType.joyful),
        ),
      ));
      await tester.pump(const Duration(milliseconds: 300));
    }

    testWidgets('Próxima vibra de leve a cada oração', (tester) async {
      await pumpRosary(tester, hapticsOn: true);

      await tester.tap(find.text('Próxima'));
      await tester.pump(const Duration(milliseconds: 300));

      expect(backend.calls, ['vibrate:25:110']);
    });

    testWidgets('Anterior dá um toque mais sutil', (tester) async {
      await pumpRosary(tester, hapticsOn: true);

      await tester.tap(find.text('Próxima'));
      await tester.pump(const Duration(milliseconds: 300));
      backend.calls.clear();

      await tester.tap(find.byIcon(Icons.chevron_left));
      await tester.pump(const Duration(milliseconds: 300));

      expect(backend.calls, ['vibrate:15:60']);
    });

    testWidgets('mudar de fase (iniciais -> 1º mistério) vibra mais forte', (tester) async {
      await pumpRosary(tester, hapticsOn: true);

      // 7 passos iniciais; o 7º toque entra no 1º mistério
      for (var i = 0; i < 7; i++) {
        await tester.tap(find.text('Próxima'));
        await tester.pump(const Duration(milliseconds: 250));
      }
      expect(backend.calls.first, 'vibrate:25:110');
      expect(backend.calls.last, 'vibrate:45:170');
    });

    testWidgets('fim do mistério vibra longo; terço concluído vibra 3x e celebra', (tester) async {
      await pumpRosary(tester, hapticsOn: true);
      Future<void> next() async {
        await tester.tap(find.text('Próxima'));
        await tester.pump(const Duration(milliseconds: 120));
      }

      for (var i = 0; i < 7; i++) {
        await next();
      }
      backend.calls.clear();
      // anúncio -> Pai-Nosso -> 1ª ... 10ª Ave-Maria: tudo leve
      for (var i = 0; i < 11; i++) {
        await next();
      }
      expect(backend.calls.where((c) => c == 'vibrate:25:110').length, 11);
      backend.calls.clear();
      await next(); // terminou a 10ª Ave-Maria
      expect(backend.calls, ['vibrate:400:255']);
      backend.calls.clear();
      await next(); // Glória -> Ó meu Jesus: leve
      await next(); // entra no 2º mistério: médio, não longo
      expect(backend.calls, ['vibrate:25:110', 'vibrate:45:170']);

      for (var i = 0; i < 14 * 3 + 11; i++) {
        await next();
      }
      backend.calls.clear();
      await next(); // 10ª Ave-Maria do 5º mistério
      expect(backend.calls, ['vibrate:400:255']);
      await next();
      await next(); // fecha o 5º mistério (vai para a Salve-Rainha)
      expect(backend.calls.last, 'vibrate:45:170');
      await tester.runAsync(() async {
        await tester.tap(find.text('Finalizar'));
        await Future.delayed(const Duration(milliseconds: 800));
      });
      for (var i = 0; i < 400 && find.byType(AlertDialog).evaluate().isEmpty; i++) {
        await tester.runAsync(() => Future.delayed(const Duration(milliseconds: 50)));
        await tester.pump(const Duration(milliseconds: 100));
      }
      expect(backend.calls.last, 'pattern:0,90,110,90,110,90');
      expect(find.byType(AlertDialog), findsOneWidget);
      for (var i = 0; i < 30; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }
    });

    testWidgets('com a vibração desligada nas configurações, nada vibra', (tester) async {
      await pumpRosary(tester, hapticsOn: false);

      await tester.tap(find.text('Próxima'));
      await tester.pump(const Duration(milliseconds: 300));

      expect(backend.calls, isEmpty);
    });
  });
}
