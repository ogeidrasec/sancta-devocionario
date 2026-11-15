// Procura overflows de layout com fontes grandes e telas "densas" (DPI alto).
// Execute: flutter test test/layout_scale_test.dart
import 'dart:io';

import 'package:sanctaconscientia/pages/adoration_guide_page.dart';
import 'package:sanctaconscientia/pages/intentions_page.dart';
import 'package:sanctaconscientia/pages/mass_guide_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:sanctaconscientia/data/novena_data.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/theme/app_theme.dart';
import 'package:sanctaconscientia/pages/configuracoes_page.dart';
import 'package:sanctaconscientia/pages/main_scaffold.dart';
import 'package:sanctaconscientia/pages/novena_detail_page.dart';
import 'package:sanctaconscientia/models/categoria.dart';
import 'package:sanctaconscientia/pages/support_project_page.dart';
import 'package:sanctaconscientia/pages/categoria_pecados_page.dart';
import 'package:sanctaconscientia/pages/devotional_home_page.dart';
import 'package:sanctaconscientia/pages/exame_diario_page.dart';
import 'package:sanctaconscientia/pages/luta_tentacoes_page.dart';
import 'package:sanctaconscientia/pages/metodo_confissao_page.dart';
import 'package:sanctaconscientia/pages/novena_home_page.dart';
import 'package:sanctaconscientia/pages/oracao_page.dart';
import 'package:sanctaconscientia/pages/relatorio_page.dart';
import 'package:sanctaconscientia/pages/examination_home_page.dart';
import 'package:sanctaconscientia/pages/plano_vida_page.dart';
import 'package:sanctaconscientia/widgets/confession_confirmation_dialog.dart';
import 'package:sanctaconscientia/widgets/confession_scheduling_dialog.dart';
import 'package:sanctaconscientia/pages/jornada_confissao_page.dart';
import 'package:sanctaconscientia/pages/onboarding_page.dart';
import 'package:sanctaconscientia/pages/plano_vida/widgets/reminder_edit_dialog.dart';
import 'package:sanctaconscientia/pages/prayer_detail_page.dart';
import 'package:sanctaconscientia/pages/rosary_mysteries_page.dart';
import 'package:sanctaconscientia/pages/rosary_prayer_page.dart';
import 'package:sanctaconscientia/providers/app_state.dart';
import 'package:sanctaconscientia/providers/confession_provider.dart';
import 'package:sanctaconscientia/providers/liturgical_provider.dart';
import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/providers/settings_provider.dart';
import 'package:sanctaconscientia/services/database_service.dart';
import 'package:sanctaconscientia/services/notification_service.dart';
import 'package:sanctaconscientia/services/reminder_service.dart';

const _screens = {
  'normal 411x891': Size(411, 891),
  'DPI alto 360x640': Size(360, 640),
  'DPI muito alto 320x568': Size(320, 568),
};
const _scales = [1.0, 1.3, 1.6];

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  // Cada arquivo de teste usa o próprio banco: os testes rodam em paralelo e
  // compartilhar o mesmo arquivo SQLite causava "database is locked".
  final dbDirReady = databaseFactoryFfi.setDatabasesPath('.dart_tool/test_db_layout');

  // Carrega a fonte Roboto real. Sem isso o teste usa a fonte "Ahem", em que
  // cada letra é um quadrado largo, e acusa overflows que não existem no app.
  Future<void> loadRoboto() async {
    final root = Platform.environment['FLUTTER_ROOT'] ?? 'D:/flutter';
    final dir = '$root/bin/cache/artifacts/material_fonts';
    Future<ByteData> bytes(String f) async {
      final b = await File('$dir/$f').readAsBytes();
      return ByteData.view(b.buffer);
    }
    final loader = FontLoader('Roboto')
      ..addFont(bytes('roboto-regular.ttf'))
      ..addFont(bytes('roboto-bold.ttf'));
    await loader.load();
  }

  setUpAll(() async {
    await dbDirReady;
    await loadRoboto();
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

  final pages = <String, Widget Function()>{
    'Aba Jardim': () => const MainScaffold(initialIndex: 0),
    'Aba Orações': () => const MainScaffold(initialIndex: 1),
    'Aba Novenas': () => const MainScaffold(initialIndex: 2),
    'Aba Terço': () => const MainScaffold(initialIndex: 3),
    'Aba Exame': () => const MainScaffold(initialIndex: 4),
    'Onboarding': () => const OnboardingPage(),
    'Exame (home)': () => const ExaminationHomePage(),
    'Janela: confirmar confissão': () => _Opener((c) => showDialog(context: c, builder: (_) => const ConfessionConfirmationDialog())),
    'Janela: agendar confissão': () => _Opener((c) => showDialog(context: c, builder: (_) => const ConfessionSchedulingDialog())),
    'Folha: adicionar oração': () => _Opener((c) => PlanoVidaPage.showPrayerSelectionDialog(c, DateTime.now())),
    'Exame diário': () => const ExameDiarioPage(),
    'Luta contra tentações': () => const LutaTentacoesPage(),
    'Método da confissão': () => const MetodoConfissaoPage(),
    'Oração preparatória': () => const OracaoPage(),
    'Relatório (guia)': () => const RelatorioPage(),
    'Sobre': () => const SupportProjectPage(),
    'Intenções de oração': () => const IntentionsPage(),
    'Guia da Missa': () => const MassGuidePage(),
    'Adoração Eucarística': () => const AdorationGuidePage(),
    'Orações (lista)': () => const DevotionalHomePage(),
    'Novenas (lista)': () => const NovenaHomePage(),
    'Terço (mistérios)': () => const RosaryMysteriesPage(),
    'Categoria de pecados': () => Builder(builder: (c) {
          final cats = Categoria.getExaminationCategories(c).where((x) => x.itens.isNotEmpty).toList();
          return CategoriaPecadosPage(categoria: cats[1]);
        }),
    'Jornada da confissão': () => const JornadaConfissaoPage(),
    // Imita o showDialog: o próprio Dialog aplica a margem de 40 dp.
    'Novo lembrete': () => Scaffold(
          body: LayoutBuilder(
            builder: (context, c) => Center(
              child: SizedBox(
                width: c.maxWidth,
                height: c.maxHeight,
                child: const ReminderEditDialog(),
              ),
            ),
          ),
        ),
    'Configurações': () => const ConfiguracoesPage(),
    'Oração (detalhe)': () => const PrayerDetailPage(
          title: 'Pai Nosso',
          content:
              'Pai nosso, que estais nos céus, santificado seja o vosso nome, venha a nós o vosso reino, seja feita a vossa vontade assim na terra como no céu. O pão nosso de cada dia nos dai hoje, perdoai-nos as nossas ofensas assim como nós perdoamos a quem nos tem ofendido, e não nos deixeis cair em tentação, mas livrai-nos do mal. Amém.',
        ),
    'Novena (detalhe)': () => Builder(
        builder: (c) => NovenaDetailPage(
            novenaId: NovenaData.getAllNovenas(c).first.id)),
    'Terço gozosos': () =>
        const RosaryPrayerPage(mysteryType: MysteryType.joyful),
    'Terço luminosos': () =>
        const RosaryPrayerPage(mysteryType: MysteryType.luminous),
  };

  for (final screen in _screens.entries) {
    for (final scale in _scales) {
      for (final page in pages.entries) {
        final label = '${page.key} | ${screen.key} | texto ${scale}x';
        testWidgets(label, (tester) async {
          tester.view.physicalSize = screen.value * 2;
          tester.view.devicePixelRatio = 2;
          addTearDown(tester.view.reset);

          final overflows = <String>[];
          final other = <String>[];
          final oldHandler = FlutterError.onError;
          FlutterError.onError = (d) {
            // ignore: avoid_print
            final msg = d.exceptionAsString();
            if (msg.contains('overflowed')) {
              final full = d.toString(minLevel: DiagnosticLevel.fine);
              final where = RegExp(r'(?:lib|pages|widgets)[/\\][\w/\\]+\.dart:\d+')
                  .allMatches(full)
                  .map((m) => m.group(0))
                  .toSet()
                  .take(2)
                  .join(', ');
              overflows.add('${msg.split('\n').first} @ $where');
            } else {
              other.add(msg.split('\n').first);
              // ignore: avoid_print
              print('STACK: ${d.stack.toString().split('\n').take(10).join(' <- ')}');
            }
          };

          final db = DatabaseService();
          final reminders = ReminderService(
              databaseService: db, notificationService: NotificationService());
          final settings = SettingsProvider()
            ..setLocale(const Locale('pt'));
          await tester.runAsync(() => settings.setTextScale(scale));

          await tester.pumpWidget(MultiProvider(
            providers: [
              ChangeNotifierProvider(
                  create: (_) => AppState(reminderService: reminders)),
              ChangeNotifierProvider.value(value: settings),
              ChangeNotifierProvider(
                  create: (_) => ConfessionProvider(reminderService: reminders)),
              ChangeNotifierProvider(
                  create: (_) => PrayerProvider(reminderService: reminders)),
              ChangeNotifierProvider(
                  create: (_) => LiturgicalProvider(reminderService: reminders)),
            ],
            child: MaterialApp(
              theme: buildAppTheme(fontFamily: 'Roboto'),
              locale: const Locale('pt'),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              builder: (context, child) {
                final mq = MediaQuery.of(context);
                return MediaQuery(
                  data: mq.copyWith(textScaler: TextScaler.linear(scale)),
                  child: child!,
                );
              },
              home: page.value(),
            ),
          ));
          await tester.runAsync(
              () => Future.delayed(const Duration(milliseconds: 300)));
          await tester.pump(const Duration(milliseconds: 500));
          await tester.pump(const Duration(seconds: 2));

          FlutterError.onError = oldHandler;
          if (other.isNotEmpty) {
            // ignore: avoid_print
            print('OUTROS ERROS [$label]: ${other.toSet().take(3).join(' || ')}');
          }
          expect(overflows, isEmpty, reason: overflows.toSet().join('\n'));
        });
      }
    }
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
