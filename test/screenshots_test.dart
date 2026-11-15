// Ferramenta de desenvolvimento: gera imagens (PNG) das telas para conferir o
// visual sem um aparelho. Só roda com:  SCREENSHOTS=1 flutter test test/screenshots_test.dart
// As imagens vão para a pasta indicada em SCREENSHOT_DIR (padrão: build/screenshots).
import 'dart:io';
import 'dart:ui' as ui;

import 'package:sanctaconscientia/pages/adoration_guide_page.dart';
import 'package:sanctaconscientia/pages/intentions_page.dart';
import 'package:sanctaconscientia/pages/mass_guide_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanctaconscientia/pages/support_project_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/theme/app_theme.dart';
import 'package:sanctaconscientia/pages/categoria_pecados_page.dart';
import 'package:sanctaconscientia/data/novena_data.dart';
import 'package:sanctaconscientia/pages/plano_vida_page.dart';
import 'package:sanctaconscientia/pages/plano_vida/widgets/reminder_edit_dialog.dart';
import 'package:sanctaconscientia/widgets/confession_confirmation_dialog.dart';
import 'package:sanctaconscientia/widgets/confession_scheduling_dialog.dart';
import 'package:sanctaconscientia/pages/login_page.dart';
import 'package:sanctaconscientia/pages/configuracoes_page.dart';
import 'package:sanctaconscientia/pages/devotional_home_page.dart';
import 'package:sanctaconscientia/pages/main_scaffold.dart';
import 'package:sanctaconscientia/pages/plano_vida/widgets/garden_heatmap.dart';
import 'package:sanctaconscientia/pages/onboarding_page.dart';
import 'package:sanctaconscientia/pages/plano_vida/historico_tab.dart';
import 'package:sanctaconscientia/pages/plano_vida/lembretes_tab.dart';
import 'package:sanctaconscientia/pages/novena_detail_page.dart';
import 'package:sanctaconscientia/pages/novena_home_page.dart';
import 'package:sanctaconscientia/pages/rosary_mysteries_page.dart';
import 'package:sanctaconscientia/pages/rosary_prayer_page.dart';
import 'package:sanctaconscientia/pages/exame_diario_page.dart';
import 'package:sanctaconscientia/pages/luta_tentacoes_page.dart';
import 'package:sanctaconscientia/pages/prayer_detail_page.dart';
import 'package:sanctaconscientia/data/prayer_data.dart';
import 'package:sanctaconscientia/pages/examination_home_page.dart';
import 'package:sanctaconscientia/pages/jornada_confissao_page.dart';
import 'package:sanctaconscientia/pages/metodo_confissao_page.dart';
import 'package:sanctaconscientia/pages/oracao_page.dart';
import 'package:sanctaconscientia/pages/relatorio_page.dart';
import 'package:sanctaconscientia/models/categoria.dart';
import 'package:sanctaconscientia/providers/app_state.dart';
import 'package:sanctaconscientia/providers/confession_provider.dart';
import 'package:sanctaconscientia/providers/liturgical_provider.dart';
import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/providers/settings_provider.dart';
import 'package:sanctaconscientia/services/database_service.dart';
import 'package:sanctaconscientia/services/notification_service.dart';
import 'package:sanctaconscientia/services/reminder_service.dart';

void main() {
  final enabled = Platform.environment['SCREENSHOTS'] == '1';
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  // Cada arquivo de teste usa o próprio banco: os testes rodam em paralelo e
  // compartilhar o mesmo arquivo SQLite causava "database is locked".
  final dbDirReady = databaseFactoryFfi.setDatabasesPath('.dart_tool/test_db_screenshots');

  Future<void> loadFonts() async {
    final root = Platform.environment['FLUTTER_ROOT'] ?? 'D:/flutter';
    final dir = '$root/bin/cache/artifacts/material_fonts';
    Future<ByteData> bytes(String f) async {
      final b = await File('$dir/$f').readAsBytes();
      return ByteData.view(b.buffer);
    }

    final roboto = FontLoader('Roboto')
      ..addFont(bytes('roboto-regular.ttf'))
      ..addFont(bytes('roboto-bold.ttf'))
      ..addFont(bytes('roboto-medium.ttf'));
    await roboto.load();
    final icons = FontLoader('MaterialIcons')..addFont(bytes('materialicons-regular.otf'));
    await icons.load();
  }

  setUpAll(() async {
    await dbDirReady;
    tzdata.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/Sao_Paulo'));
    await loadFonts();
    SharedPreferences.setMockInitialValues({});
    AndroidFlutterLocalNotificationsPlugin.registerWith();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
            const MethodChannel('dexterous.com/flutter/local_notifications'),
            (c) async => null);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
            const MethodChannel('flutter_timezone'), (c) async => 'America/Sao_Paulo');
  });

  final outDir = Platform.environment['SCREENSHOT_DIR'] ?? 'build/screenshots';
  final widthDp = double.tryParse(Platform.environment['SCREENSHOT_WIDTH'] ?? '') ?? 411;
  final heightDp = double.tryParse(Platform.environment['SCREENSHOT_HEIGHT'] ?? '') ?? 891;
  final localeCode = Platform.environment['SCREENSHOT_LOCALE'] ?? 'pt';
  final textScale = double.tryParse(Platform.environment['SCREENSHOT_SCALE'] ?? '') ?? 1.0;

  final pages = <String, Widget Function()>{
    'exame_home': () => const ExaminationHomePage(),
    'jornada': () => const JornadaConfissaoPage(),
    'metodo': () => const MetodoConfissaoPage(),
    'oracao': () => const OracaoPage(),
    'exame_diario': () => const ExameDiarioPage(),
    'relatorio': () => const RelatorioPage(),
    'luta': () => const LutaTentacoesPage(),
    'oracao_detalhe': () => Builder(builder: (c) {
          final p = PrayerData.getPrayerById(c, 'pater_noster')!;
          return PrayerDetailPage(
            title: p['title'] as String,
            content: p['content'] as String,
            contentLatin: p['contentLatin'] as String?,
          );
        }),
    'exame_home_marcado': () => const ExaminationHomePage(),
    'relatorio_marcado': () => const RelatorioPage(),
    'jardim': () => const MainScaffold(initialIndex: 0),
    'jardim_exemplo': () => const MainScaffold(initialIndex: 0),
    'oracoes': () => const DevotionalHomePage(),
    'novenas': () => const NovenaHomePage(),
    'novena_detalhe': () => Builder(
        builder: (c) => NovenaDetailPage(novenaId: NovenaData.getAllNovenas(c).first.id)),
    'terco': () => const RosaryMysteriesPage(),
    'terco_rezando': () => const RosaryPrayerPage(mysteryType: MysteryType.joyful),
    'terco_dolorosos': () => const RosaryPrayerPage(mysteryType: MysteryType.sorrowful),
    'terco_dezena': () => const RosaryPrayerPage(mysteryType: MysteryType.sorrowful),
    'configuracoes': () => const ConfiguracoesPage(),
    // --- janelas e folhas (abertas assim que a tela aparece) ---
    'dlg_lembrete': () => _Opener((c) => showDialog(context: c, builder: (_) => const ReminderEditDialog())),
    'dlg_confissao': () => _Opener((c) => showDialog(context: c, builder: (_) => const ConfessionConfirmationDialog())),
    'dlg_agendar_confissao': () => _Opener((c) => showDialog(context: c, builder: (_) => const ConfessionSchedulingDialog())),
    'sheet_oracao': () => _Opener((c) => PlanoVidaPage.showPrayerSelectionDialog(c, DateTime.now())),
    'dlg_novena_iniciar': () => Builder(
        builder: (c) => NovenaDetailPage(novenaId: NovenaData.getAllNovenas(c).first.id)),
    'apoie': () => const SupportProjectPage(),
    'apoie_cripto': () => const SupportProjectPage(),
    // guia do app: passo N (contando do 0)
    'firstrun_1': () => const OnboardingPage(),
    'firstrun_2': () => const OnboardingPage(),
    'firstrun_3': () => const OnboardingPage(),
    'onb_0': () => const OnboardingPage(),
    'onb_1': () => const OnboardingPage(),
    'onb_2': () => const OnboardingPage(),
    'onb_3': () => const OnboardingPage(),
    'onb_5': () => const OnboardingPage(),
    'tour_13': () => const MainScaffold(startTour: true),
    'tour_16': () => const MainScaffold(startTour: true),
    'tour_19': () => const MainScaffold(startTour: true),
    'tour_20': () => const MainScaffold(startTour: true),
    'tour_21': () => const MainScaffold(startTour: true),
    'tour_22': () => const MainScaffold(startTour: true),
    'tour_00': () => const MainScaffold(startTour: true),
    'tour_02': () => const MainScaffold(startTour: true),
    'tour_03': () => const MainScaffold(startTour: true),
    'tour_04': () => const MainScaffold(startTour: true),
    'tour_09': () => const MainScaffold(startTour: true),
    'tour_12': () => const MainScaffold(startTour: true),
    'intencoes': () => const IntentionsPage(),
    'guia_missa': () => const MassGuidePage(),
    'adoracao': () => const AdorationGuidePage(),
    'login': () => LoginPage(onLoginSuccess: () {}),
    'historico': () => const Scaffold(body: HistoricoTab()),
    'lembretes': () => const Scaffold(body: LembretesTab()),
    'categoria_1': () => Builder(builder: (c) {
          final cats = Categoria.getExaminationCategories(c)
              .where((x) => x.itens.isNotEmpty)
              .toList();
          return CategoriaPecadosPage(categoria: cats.first);
        }),
  };

  for (final entry in pages.entries) {
    testWidgets('screenshot ${entry.key}', (tester) async {
      tester.view.physicalSize = Size(widthDp, heightDp) * 2;
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);

      // O flutter_test desliga as sombras (viram contornos pretos); aqui queremos o visual real.
      debugDisableShadows = false;
      final db = DatabaseService();
      await tester.runAsync(() async {
        await db.clearPecados();
        if (entry.key.endsWith('_marcado')) {
          await db.updatePecado('antes-1-0', 2);
          await db.updatePecado('antes-1-3', 1);
          await db.updatePecado('mandamentos-1-0', 1);
          await db.updatePecado('mandamentos-5-2', 3);
        }
      });
      final reminders = ReminderService(
          databaseService: db, notificationService: NotificationService());
      final key = GlobalKey();

      GardenDemo.active.value = entry.key == 'jardim_exemplo';
      await tester.pumpWidget(RepaintBoundary(
        key: key,
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AppState(reminderService: reminders)),
            ChangeNotifierProvider(create: (_) => SettingsProvider()),
            ChangeNotifierProvider(create: (_) => ConfessionProvider(reminderService: reminders)),
            ChangeNotifierProvider(create: (_) => PrayerProvider(reminderService: reminders)),
            ChangeNotifierProvider(create: (_) => LiturgicalProvider(reminderService: reminders)),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: buildAppTheme(fontFamily: 'Roboto'),
            locale: Locale(localeCode),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(textScale)),
              child: child!,
            ),
            home: entry.value(),
          ),
        ),
      ));
      // Dados de exemplo para o Jardim (hoje e dias anteriores)
      if (entry.key == 'jardim' || entry.key == 'historico') {
        await tester.runAsync(() async {
          final prayers = PrayerProvider(reminderService: reminders);
          await prayers.loadData();
          final now = DateTime.now();
          for (var i = 0; i < 40; i += 2) {
            await prayers.logPrayer('Exame Diário', now.subtract(Duration(days: i)), prayerId: 'daily_examination');
            if (i % 3 == 0) {
              await prayers.logPrayer('Mistérios Gozosos', now.subtract(Duration(days: i)), prayerId: 'rosary_joyful');
            }
          }
          await prayers.startNovena('novena_sao_jose', startDate: now.subtract(const Duration(days: 2)));
          // missas: domingos recentes e hoje
          final sunday = DateTime(now.year, now.month, now.day).subtract(Duration(days: now.weekday % 7));
          for (var w = 0; w < 6; w++) {
            if (w != 2) await prayers.toggleMass(sunday.subtract(Duration(days: 7 * w)));
          }
          await prayers.toggleMass(now);
        });
      }
      // Carrega os dados salvos (no app real isso é feito no splash)
      final ctx = tester.element(find.byType(MaterialApp));
      await tester.runAsync(() async {
        await ctx.read<ConfessionProvider>().loadData();
        await ctx.read<PrayerProvider>().loadData();
        await ctx.read<SettingsProvider>().loadSettings();
        await ctx.read<LiturgicalProvider>().loadSettings();
      });
      await tester.runAsync(() => Future.delayed(const Duration(milliseconds: 500)));
      if (entry.key == 'dlg_novena_iniciar') {
        await tester.tap(find.byIcon(Icons.play_arrow).first);
        await tester.pump(const Duration(milliseconds: 600));
      }
      if (entry.key == 'apoie_cripto') {
        await tester.tap(find.byKey(const ValueKey('method_crypto')));
        await tester.pump(const Duration(milliseconds: 600));
        await tester.drag(find.byType(SingleChildScrollView).first, const Offset(0, -500));
        await tester.pump(const Duration(milliseconds: 600));
      }
      if (entry.key.startsWith('firstrun_')) {
        // primeiro uso de verdade: boas-vindas › Ver o guia › passos
        await tester.tap(find.byKey(const ValueKey('onb_skip')));
        for (var f = 0; f < 8; f++) {
          await tester.pump(const Duration(milliseconds: 100));
        }
        await tester.runAsync(() async {
          await tester.tap(find.byKey(const ValueKey('onb_tour_start')));
          await Future.delayed(const Duration(milliseconds: 300));
        });
        for (var f = 0; f < 40; f++) {
          await tester.pump(const Duration(milliseconds: 100));
        }
        for (var i = 1; i < int.parse(entry.key.substring(9)); i++) {
          await tester.tap(find.byKey(const ValueKey('tour_next')));
          for (var f = 0; f < 20; f++) {
            await tester.pump(const Duration(milliseconds: 100));
          }
        }
      }
      if (entry.key.startsWith('onb_')) {
        final n = int.parse(entry.key.substring(4));
        if (n == 5) {
          await tester.tap(find.byKey(const ValueKey('onb_skip')));
          await tester.pump(const Duration(milliseconds: 800));
        } else {
          for (var i = 0; i < n; i++) {
            await tester.tap(find.byKey(const ValueKey('onb_next')));
            for (var f = 0; f < 8; f++) {
              await tester.pump(const Duration(milliseconds: 100));
            }
          }
        }
      }
      if (entry.key.startsWith('tour_')) {
        for (var f = 0; f < 20; f++) {
          await tester.pump(const Duration(milliseconds: 100));
        }
        for (var i = 0; i < int.parse(entry.key.substring(5)); i++) {
          await tester.tap(find.byKey(const ValueKey('tour_next')));
          for (var f = 0; f < 20; f++) {
            await tester.pump(const Duration(milliseconds: 100));
          }
        }
      }
      if (entry.key == 'terco_dezena') {
        // avança até a 4ª Ave-Maria do 2º mistério
        for (var i = 0; i < 7 + 14 + 2 + 4; i++) {
          await tester.tap(find.byIcon(Icons.chevron_right).first);
          await tester.pump(const Duration(milliseconds: 80));
        }
      }
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pump(const Duration(seconds: 1));

      await tester.runAsync(() async {
        final boundary =
            key.currentContext!.findRenderObject() as RenderRepaintBoundary;
        final ui.Image image = await boundary.toImage(pixelRatio: 1.5);
        final data = await image.toByteData(format: ui.ImageByteFormat.png);
        final file = File('$outDir/${entry.key}.png');
        await file.create(recursive: true);
        await file.writeAsBytes(data!.buffer.asUint8List());
      });
      debugDisableShadows = true;
    }, skip: !enabled);
  }
}

/// Abre uma janela/folha assim que a tela aparece.
class _Opener extends StatefulWidget {
  final void Function(BuildContext) open;
  const _Opener(this.open);

  @override
  State<_Opener> createState() => _OpenerState();
}

class _OpenerState extends State<_Opener> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) widget.open(context);
    });
  }

  @override
  Widget build(BuildContext context) => const Scaffold(body: SizedBox.expand());
}
