import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/pages/splash_screen.dart';
import 'package:sanctaconscientia/providers/app_state.dart';
import 'package:sanctaconscientia/providers/settings_provider.dart';
import 'package:sanctaconscientia/providers/confession_provider.dart';
import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/providers/liturgical_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/services/database_service.dart';
import 'package:sanctaconscientia/services/reminder_service.dart';
import 'package:sanctaconscientia/services/notification_service.dart';
import 'package:sanctaconscientia/theme/app_theme.dart';
import 'package:sanctaconscientia/widgets/privacy_shield.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initialize();
  
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final databaseService = DatabaseService();
    final notificationService = NotificationService();
    final reminderService = ReminderService(
      databaseService: databaseService,
      notificationService: notificationService,
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          final appState = AppState(reminderService: reminderService);
          // Data loading is now handled by SplashScreen
          return appState;
        }),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => ConfessionProvider(reminderService: reminderService)),
        ChangeNotifierProvider(create: (_) => PrayerProvider(reminderService: reminderService)),
        ChangeNotifierProvider(create: (_) => LiturgicalProvider(reminderService: reminderService)),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
            locale: settingsProvider.currentLocale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            theme: buildAppTheme(),
            builder: (context, child) {
              // Multiplica a escala do sistema pela escolhida pelo usuário.
              final mq = MediaQuery.of(context);
              return MediaQuery(
                data: mq.copyWith(
                  textScaler: TextScaler.linear(
                    mq.textScaler.scale(1.0) * settingsProvider.textScale,
                  ),
                ),
                child: PrivacyShield(child: child!),
              );
            },
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
