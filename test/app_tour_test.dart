// Guia do app: percorre todos os passos no app montado, trocando de aba e
// iluminando os pontos certos; pode ser reaberto pelo menu lateral.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/l10n/app_localizations_pt.dart';
import 'package:sanctaconscientia/pages/main_scaffold.dart';
import 'package:sanctaconscientia/pages/devotional_home_page.dart';
import 'package:sanctaconscientia/pages/novena_home_page.dart';
import 'package:sanctaconscientia/providers/app_state.dart';
import 'package:sanctaconscientia/providers/confession_provider.dart';
import 'package:sanctaconscientia/providers/liturgical_provider.dart';
import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/providers/settings_provider.dart';
import 'package:sanctaconscientia/services/auth_service.dart';
import 'package:sanctaconscientia/services/database_service.dart';
import 'package:sanctaconscientia/services/notification_service.dart';
import 'package:sanctaconscientia/services/reminder_service.dart';
import 'package:sanctaconscientia/pages/plano_vida/widgets/garden_heatmap.dart';
import 'package:sanctaconscientia/widgets/app_tour.dart';

final _total = buildAppTourSteps(AppLocalizationsPt()).length;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final dbDirReady = databaseFactoryFfi.setDatabasesPath('.dart_tool/test_db_app_tour');

  setUpAll(() async {
    await dbDirReady;
    SharedPreferences.setMockInitialValues({});
    AndroidFlutterLocalNotificationsPlugin.registerWith();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        const MethodChannel('dexterous.com/flutter/local_notifications'), (c) async => null);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('flutter_timezone'), (c) async => 'America/Sao_Paulo');
  });

  Future<void> pumpApp(WidgetTester tester, {bool startTour = true}) async {
    tester.view.physicalSize = const Size(411, 891) * 2;
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    final reminders = ReminderService(databaseService: DatabaseService(), notificationService: NotificationService());
    // grava o idioma antes de montar: nada assíncrono fica para depois do teste
    final settings = SettingsProvider();
    await tester.runAsync(() async => settings.setLocale(const Locale('pt')));
    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState(reminderService: reminders)),
        ChangeNotifierProvider.value(value: settings),
        ChangeNotifierProvider(create: (_) => ConfessionProvider(reminderService: reminders)),
        ChangeNotifierProvider(create: (_) => PrayerProvider(reminderService: reminders)),
        ChangeNotifierProvider(create: (_) => LiturgicalProvider(reminderService: reminders)),
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
        home: MainScaffold(startTour: startTour),
      ),
    ));
    await tester.runAsync(() => Future.delayed(const Duration(milliseconds: 300)));
    await tester.pump(const Duration(milliseconds: 500));
  }

  Future<void> settle(WidgetTester tester) async {
    // o guia tem transições calmas (~1,5 s por passo)
    for (var i = 0; i < 20; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  Future<void> waitFor(WidgetTester tester, Finder f) async {
    for (var i = 0; i < 60 && f.evaluate().isEmpty; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    await settle(tester);
  }

  testWidgets('percorre todos os passos e ilumina cada ponto', (tester) async {
    await pumpApp(tester);
    final l10n = await AppLocalizations.delegate.load(const Locale('pt'));
    final steps = buildAppTourSteps(l10n);

    await waitFor(tester, find.byKey(const ValueKey('garden_demo_banner')));
    expect(GardenDemo.active.value, isTrue, reason: 'durante o guia o Jardim mostra o exemplo');
    for (var i = 0; i < steps.length; i++) {
      await waitFor(tester, find.text('${i + 1}/${steps.length}'));
      expect(find.byKey(const ValueKey('tour_bubble')), findsOneWidget, reason: 'passo ${i + 1}');
      expect(find.text(steps[i].title), findsWidgets, reason: 'passo ${i + 1}');
      expect(find.text('${i + 1}/${steps.length}'), findsOneWidget);
      final target = steps[i].target;
      if (target != null) {
        expect(target.currentContext, isNotNull, reason: 'alvo do passo ${i + 1} (${steps[i].title}) não está na tela');
      }
      await tester.tap(find.byKey(const ValueKey('tour_next')));
    }
    await waitFor(tester, find.byKey(AppTourKeys.menu));
    await settle(tester);
    expect(find.byKey(const ValueKey('tour_bubble')), findsNothing, reason: 'termina e fecha');
    for (var i = 0; i < 20; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(GardenDemo.active.value, isFalse, reason: 'o Jardim volta aos dados reais');
    expect(tester.takeException(), isNull);
    // deixa as gravações assíncronas das configurações terminarem
    await tester.runAsync(() => Future.delayed(const Duration(milliseconds: 800)));
  });

  testWidgets('no primeiro uso, ao fim do guia, aparece o texto do projeto com botão', (tester) async {
    await pumpApp(tester);
    await waitFor(tester, find.text('1/$_total'));
    await tester.tap(find.byKey(const ValueKey('tour_skip')));
    await waitFor(tester, find.byKey(const ValueKey('project_dialog')));
    expect(find.byKey(const ValueKey('project_dialog')), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('project_dialog_go')));
    await waitFor(tester, find.text('Apoie o projeto'));
    expect(find.text('Apoie o projeto'), findsWidgets);
    await tester.runAsync(() => Future.delayed(const Duration(milliseconds: 800)));
  });

  testWidgets('as outras abas são montadas antes do passo que as mostra (sem travar)', (tester) async {
    await pumpApp(tester);
    await waitFor(tester, find.text('1/$_total'));
    for (var i = 0; i < 40; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(find.byType(DevotionalHomePage, skipOffstage: false), findsOneWidget);
    expect(find.byType(NovenaHomePage, skipOffstage: false), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('tour_skip')));
    await waitFor(tester, find.byKey(const ValueKey('project_dialog')));
    await tester.runAsync(() => Future.delayed(const Duration(milliseconds: 800)));
  });

  testWidgets('com senha criada, o guia mostra o Exame aberto só com dados de exemplo', (tester) async {
    await tester.runAsync(() => AuthService().definirSenha('segredo123'));
    addTearDown(() async => DatabaseService().wipeAllDataForTests());
    await pumpApp(tester);
    final steps = buildAppTourSteps(AppLocalizationsPt());
    final examStep = steps.indexWhere((s) => s.target == AppTourKeys.examJornada);
    await waitFor(tester, find.text('1/$_total'));
    for (var i = 0; i < examStep; i++) {
      await tester.tap(find.byKey(const ValueKey('tour_next')));
      await waitFor(tester, find.text('${i + 2}/$_total'));
    }
    // página do Exame aberta (não a tela de senha), com a Jornada iluminável
    expect(AppTourKeys.examJornada.currentContext, isNotNull);
    expect(find.text('Criar senha'), findsNothing);
    expect(find.text('Entrar'), findsNothing);
    // dados de exemplo: confissão de 45 dias atrás (e não "Não registrada")
    expect(find.text('Não registrada'), findsNothing);
    await tester.tap(find.byKey(const ValueKey('tour_skip')));
    await waitFor(tester, find.byKey(const ValueKey('project_dialog')));
    await tester.tap(find.byKey(const ValueKey('project_dialog_later')));
    // fora do guia o Exame volta a pedir a senha
    for (var i = 0; i < 30 && AppTourKeys.examJornada.currentContext != null; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    await tester.runAsync(() => Future.delayed(const Duration(milliseconds: 800)));
  });

  testWidgets('com a lista de Orações rolada e uma categoria aberta, o passo da busca mostra o campo', (tester) async {
    await pumpApp(tester, startTour: false);
    final state = tester.state<MainScaffoldState>(find.byType(MainScaffold));
    state.switchToTab(1);
    await settle(tester);
    // abre uma categoria (menu sanfonado) e rola bem para baixo
    final list = find.descendant(of: find.byType(DevotionalHomePage), matching: find.byType(Scrollable)).first;
    final tile = find.byType(ExpansionTile);
    for (var i = 0; i < 20 && tile.evaluate().isEmpty; i++) {
      await tester.drag(list, const Offset(0, -300));
      await tester.pump(const Duration(milliseconds: 100));
    }
    await tester.ensureVisible(tile.first);
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(tile.first);
    await settle(tester);
    await tester.drag(list, const Offset(0, -3000));
    await settle(tester);
    expect(AppTourScroll.prayers.offset, greaterThan(300));

    state.startTour();
    final steps = buildAppTourSteps(AppLocalizationsPt());
    final searchStep = steps.indexWhere((s) => s.target == AppTourKeys.prayerSearch);
    await waitFor(tester, find.text('1/$_total'));
    for (var i = 0; i < searchStep; i++) {
      await tester.tap(find.byKey(const ValueKey('tour_next')));
      await waitFor(tester, find.text('${i + 2}/$_total'));
    }
    final field = tester.getRect(find.byKey(AppTourKeys.prayerSearch));
    expect(field.top, greaterThan(100), reason: 'campo abaixo da barra do topo');
    expect(field.bottom, lessThan(891));
    expect(AppTourScroll.prayers.offset, lessThan(5), reason: 'a lista voltou ao topo');
    await tester.tap(find.byKey(const ValueKey('tour_skip')));
    await waitFor(tester, find.byKey(const ValueKey('project_dialog')));
    await tester.runAsync(() => Future.delayed(const Duration(milliseconds: 800)));
  });

  testWidgets('Voltar e Pular', (tester) async {
    await pumpApp(tester);
    await waitFor(tester, find.text('1/$_total'));
    await tester.tap(find.byKey(const ValueKey('tour_next')));
    await waitFor(tester, find.text('2/$_total'));
    expect(find.text('2/$_total'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('tour_back')));
    await waitFor(tester, find.text('1/$_total'));
    expect(find.text('1/$_total'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('tour_skip')));
    await settle(tester);
    expect(find.byKey(const ValueKey('tour_bubble')), findsNothing);
    await settle(tester);
  });

  testWidgets('quem já usa o app abre o guia pelo menu lateral', (tester) async {
    await pumpApp(tester, startTour: false);
    expect(find.byKey(const ValueKey('tour_bubble')), findsNothing);
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(find.byKey(AppTourKeys.menu));
    for (var i = 0; i < 30 && find.text('Guia do app').evaluate().isEmpty; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    await settle(tester);
    expect(find.text('Guia do app'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('drawer_tour')));
    await waitFor(tester, find.text('1/$_total'));
    expect(find.byKey(const ValueKey('tour_bubble')), findsOneWidget);
    expect(find.text('Bem-vindo! Vamos conhecer o app?'), findsOneWidget);
    // fecha o guia: também aqui (aberto pelo menu) aparece o pedido de apoio
    await tester.tap(find.byKey(const ValueKey('tour_skip')));
    await waitFor(tester, find.byKey(const ValueKey('project_dialog')));
    expect(find.byKey(const ValueKey('project_dialog_go')), findsOneWidget);
    for (var i = 0; i < 30; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
  });
}
