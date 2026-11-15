// Guia da Missa: alternar entre a forma ordinária (português) e a tradicional
// (latim), e lembrar a escolha.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/pages/mass_guide_page.dart';
import 'package:sanctaconscientia/providers/settings_provider.dart';
import 'package:sanctaconscientia/services/database_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final dbDirReady = databaseFactoryFfi.setDatabasesPath('.dart_tool/test_db_mass_guide');

  setUp(() async {
    await dbDirReady;
    SharedPreferences.setMockInitialValues({});
    await DatabaseService().wipeAllDataForTests();
  });

  Widget app(SettingsProvider settings, Locale locale) => ChangeNotifierProvider.value(
        value: settings,
        child: MaterialApp(
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const MassGuidePage(),
        ),
      );

  // Tela alta: a lista é preguiçosa e só monta o que cabe na tela
  void tall(WidgetTester tester) {
    tester.view.physicalSize = const Size(800, 6000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
  }

  testWidgets('alterna para a Missa tradicional e mostra o latim', (tester) async {
    tall(tester);
    final settings = SettingsProvider();
    await tester.runAsync(() => settings.loadSettings());
    await tester.pumpWidget(app(settings, const Locale('pt')));
    await tester.pumpAndSettle();

    // começa na forma ordinária
    expect(find.text('1. Ritos iniciais'), findsOneWidget);
    expect(find.text('1. Ao pé do altar'), findsNothing);

    // a gravação no banco é assíncrona de verdade: dá tempo real e atualiza a tela
    await tester.tap(find.text('Missa tradicional (latim)'));
    for (var i = 0; i < 150 && find.text('1. Ao pé do altar').evaluate().isEmpty; i++) {
      await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 100)));
      await tester.pump();
    }
    await tester.pumpAndSettle();

    expect(settings.massGuideTraditional, isTrue);
    expect(find.text('1. Ao pé do altar'), findsOneWidget);
    expect(find.text('1. Ritos iniciais'), findsNothing);
    expect(find.text('Introibo ad altare Dei.'), findsOneWidget);
  });

  testWidgets('a escolha é lembrada e o inglês também funciona', (tester) async {
    tall(tester);
    final settings = SettingsProvider();
    await tester.runAsync(() async {
      await settings.loadSettings();
      await settings.setMassGuideTraditional(true);
    });

    final reloaded = SettingsProvider();
    await tester.runAsync(() => reloaded.loadSettings());
    expect(reloaded.massGuideTraditional, isTrue);

    await tester.pumpWidget(app(reloaded, const Locale('en')));
    await tester.pumpAndSettle();
    expect(find.text('Traditional Latin Mass'), findsOneWidget);
    expect(find.text('1. At the foot of the altar'), findsOneWidget);
    expect(find.text('Sanctus, Sanctus, Sanctus Dominus Deus Sabaoth. Pleni sunt caeli et terra gloria tua. Hosanna in excelsis. Benedictus qui venit in nomine Domini. Hosanna in excelsis.'),
        findsOneWidget);
  });

  testWidgets('sem estouro de layout em tela pequena com texto grande (as duas formas)', (tester) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    for (final traditional in [false, true]) {
      final settings = SettingsProvider();
      await tester.runAsync(() async {
        await settings.loadSettings();
        await settings.setMassGuideTraditional(traditional);
      });
      await tester.pumpWidget(MediaQuery(
        data: const MediaQueryData(size: Size(320, 568), textScaler: TextScaler.linear(1.6)),
        child: app(settings, const Locale('en')),
      ));
      await tester.pumpAndSettle();
      // rola a página inteira para montar todos os cartões
      final list = find.byType(ListView);
      for (var i = 0; i < 12; i++) {
        await tester.drag(list, const Offset(0, -600));
        await tester.pump();
      }
      expect(tester.takeException(), isNull, reason: 'traditional=$traditional');
    }
  });
}
