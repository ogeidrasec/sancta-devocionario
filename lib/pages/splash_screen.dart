import 'package:sanctaconscientia/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/providers/app_state.dart';
import 'package:sanctaconscientia/providers/settings_provider.dart';
import 'package:sanctaconscientia/providers/confession_provider.dart';
import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/providers/liturgical_provider.dart';
import 'package:sanctaconscientia/pages/main_scaffold.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/pages/onboarding_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeApp();
    });
  }

  Future<void> _initializeApp() async {
    // Decodifica as fotos das páginas enquanto a splash aparece (mesmo tamanho
    // dos cabeçalhos), para nenhuma página abrir sem imagem.
    final images = AppImages.precacheStart(context);

    // Minimum delay to ensure the splash screen is visible
    final minDelay = Future.delayed(const Duration(milliseconds: 800));
    
    // Load app data
    final appState = Provider.of<AppState>(context, listen: false);
    final settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
    final confessionProvider = Provider.of<ConfessionProvider>(context, listen: false);
    final prayerProvider = Provider.of<PrayerProvider>(context, listen: false);
    final liturgicalProvider = Provider.of<LiturgicalProvider>(context, listen: false);

    try {
      // 1. Primeiramente, carregar o AppState que inicializa e carrega os Reminders
      await appState.loadSavedData();
      
      // 2. Em seguida, carregar dados de outros providers paralelamente (sem usar loadReminders() de novo)
      final providersLoad = Future.wait([
        settingsProvider.loadSettings(),
        confessionProvider.loadData(),
        prayerProvider.loadData(),
      ]);
      await providersLoad;
      
      // 3. Liturgical provider precisa que reminders e configs base existam
      await liturgicalProvider.loadSettings();

      // Aguardar o restante (minDelay e as imagens, que costumam
      // ficar prontas dentro do tempo mínimo; no máximo 1,5 s a mais)
      await Future.wait([
        minDelay,
        images.timeout(const Duration(milliseconds: 1500), onTimeout: () {}),
      ]);
    } catch (e) {
      debugPrint("Error during initialization: $e");
      // Proceed even on error to avoid sticking on splash screen
      await minDelay;
    }
    
    if (mounted) {
      // Fade out the loading indicator first
      setState(() {
        _showLoading = false;
      });
      
      // 5. Agora que todos os providers e dados foram carregados,
      // reagendar as notificações num estado limpo.
      // Em segundo plano: não bloqueia a abertura do app.
      appState.rescheduleAllReminders().catchError((e) {
        debugPrint("Error rescheduling reminders: $e");
      });

      // Wait for the fade out animation
      await Future.delayed(const Duration(milliseconds: 200));
      
      if (mounted) {
        // Decide agora (e não dentro do pageBuilder, que pode ser chamado de
        // novo): senão, ao concluir as boas-vindas, esta rota também virava
        // uma segunda tela principal por baixo da nova.
        final next = settingsProvider.onboardingDone ? const MainScaffold() : const OnboardingPage();
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => next,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = 0.0;
              const end = 1.0;
              const curve = Curves.easeInOut;
              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return FadeTransition(
                opacity: animation.drive(tween),
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 400),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Splash Image
            Image.asset(
              AppImages.logo,
              width: 250, 
              height: 250,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 24),
            // Loading indicator with fade animation
            AnimatedOpacity(
              opacity: _showLoading ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentGold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
