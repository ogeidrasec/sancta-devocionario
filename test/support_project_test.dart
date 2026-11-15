// Página "Apoie o projeto" e o PIX copia e cola gerado no aparelho.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:sanctaconscientia/config/donation_config.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/pages/support_project_page.dart';
import 'package:sanctaconscientia/services/database_service.dart';
import 'package:sanctaconscientia/utils/pix_payload.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final dbDirReady = databaseFactoryFfi.setDatabasesPath('.dart_tool/test_db_support_project');

  group('PIX copia e cola', () {
    test('CRC16-CCITT confere com o valor de referência', () {
      expect(PixPayload.crc16('123456789'), '29B1');
    });

    test('monta o BR Code com chave, nome, cidade e CRC', () {
      final p = PixPayload.build(key: 'chave@exemplo.com', name: 'João da Silva', city: 'São Paulo');
      expect(p, startsWith('000201'));
      expect(p, contains('0014br.gov.bcb.pix'));
      expect(p, contains('0117chave@exemplo.com'));
      expect(p, contains('5303986'));
      expect(p, contains('5802BR'));
      expect(p, contains('5913Joao da Silva')); // sem acento
      expect(p, contains('6009Sao Paulo'));
      expect(p, contains('62070503***'));
      expect(p.substring(p.length - 8, p.length - 4), '6304');
      expect(p.substring(p.length - 4), PixPayload.crc16(p.substring(0, p.length - 4)));
    });

    test('nome e cidade são cortados no tamanho do padrão', () {
      final p = PixPayload.build(key: 'k', name: 'Um nome muito comprido demais para o PIX', city: 'Cidade de nome enorme');
      expect(p, contains('5925Um nome muito comprido de'));
      expect(p, contains('6015Cidade de nome '));
    });

    test('valor opcional entra no campo 54', () {
      expect(PixPayload.build(key: 'k', name: 'N', city: 'C', amount: 10), contains('540510.00'));
    });
  });

  setUp(() async {
    await dbDirReady;
    SharedPreferences.setMockInitialValues({});
    await DatabaseService().wipeAllDataForTests();
  });

  testWidgets('página mostra oração, PIX, cartão e cripto; promessa de oração é guardada', (tester) async {
    tester.view.physicalSize = const Size(800, 4000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    String? clipboard;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform,
        (call) async {
      if (call.method == 'Clipboard.setData') clipboard = (call.arguments as Map)['text'] as String;
      return null;
    });

    await tester.pumpWidget(MaterialApp(
      locale: const Locale('pt'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const SupportProjectPage(),
    ));
    for (var i = 0; i < 3; i++) {
      await tester.runAsync(() => Future.delayed(const Duration(milliseconds: 100)));
      await tester.pump();
    }

    expect(find.text('Prefere ajudar com oração?'), findsOneWidget);
    // em português começa pelo PIX
    expect(find.byKey(const ValueKey('pix_qr')), findsOneWidget);
    expect(find.byKey(const ValueKey('card_button')), findsNothing);

    await tester.tap(find.byKey(const ValueKey('pix_copy_paste')));
    await tester.pump();
    expect(clipboard, startsWith('000201'));
    expect(clipboard, contains(DonationConfig.pixKey));
    expect(clipboard, isNot(contains('5405')), reason: 'sem valor escolhido');

    // valor sugerido entra no código
    await tester.tap(find.byKey(const ValueKey('pix_amount_25')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('pix_copy_paste')));
    await tester.pump();
    expect(clipboard, contains('540525.00'));

    // trocar para cartão e cripto
    await tester.tap(find.byKey(const ValueKey('method_card')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('card_button')), findsOneWidget);
    expect(find.byKey(const ValueKey('pix_qr')), findsNothing);
    await tester.tap(find.byKey(const ValueKey('method_crypto')));
    await tester.pumpAndSettle();
    expect(find.text(DonationConfig.crypto.first.name), findsOneWidget);

    await tester.ensureVisible(find.byKey(const ValueKey('prayer_promise')));
    await tester.tap(find.byKey(const ValueKey('prayer_promise')));
    for (var i = 0; i < 60 && find.byKey(const ValueKey('prayer_thanks')).evaluate().isEmpty; i++) {
      await tester.runAsync(() => Future.delayed(const Duration(milliseconds: 50)));
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(find.byKey(const ValueKey('prayer_thanks')), findsOneWidget);
    // a promessa fica guardada: ao reabrir a página, já aparece o agradecimento
    for (var i = 0; i < 15; i++) {
      await tester.runAsync(() => Future.delayed(const Duration(milliseconds: 100)));
      await tester.pump();
    }
    await tester.pumpWidget(const SizedBox());
    await tester.pumpWidget(MaterialApp(
      locale: const Locale('pt'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const SupportProjectPage(),
    ));
    // espera a leitura do banco (máquina carregada pode demorar)
    for (var i = 0; i < 40 && find.byKey(const ValueKey('prayer_thanks')).evaluate().isEmpty; i++) {
      await tester.runAsync(() => Future.delayed(const Duration(milliseconds: 100)));
      await tester.pump();
    }
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.byKey(const ValueKey('prayer_thanks')), findsOneWidget);
    expect(find.byKey(const ValueKey('prayer_promise')), findsNothing);
  });

  testWidgets('em celular pequeno a página rola até o fim, sem cortar', (tester) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(MaterialApp(
      locale: const Locale('pt'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const SupportProjectPage(),
    ));
    await tester.pump();
    final prayer = find.byKey(const ValueKey('prayer_promise'));
    await tester.scrollUntilVisible(prayer, 300, scrollable: find.byType(Scrollable).first);
    await tester.pump();
    expect(prayer.hitTestable(), findsOneWidget);
  });
}
