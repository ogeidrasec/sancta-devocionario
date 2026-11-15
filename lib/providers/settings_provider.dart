import 'package:flutter/material.dart';
import 'package:sanctaconscientia/services/database_service.dart';

class SettingsProvider extends ChangeNotifier {
  Locale? _currentLocale;
  bool _isTraditionalRosary = true;
  int _prayerLevel = 1;
  double _textScale = 1.0;
  bool _onboardingDone = false;
  bool _hapticsEnabled = true;
  bool _massGuideTraditional = false;
  bool _isInitialized = false;

  Locale? get currentLocale => _currentLocale;
  bool get isTraditionalRosary => _isTraditionalRosary;
  int get prayerLevel => _prayerLevel;
  double get textScale => _textScale;
  bool get onboardingDone => _onboardingDone;
  bool get hapticsEnabled => _hapticsEnabled;

  /// Guia da Missa: false = forma ordinária (português), true = tradicional (latim).
  bool get massGuideTraditional => _massGuideTraditional;
  bool get isInitialized => _isInitialized;

  Future<void> loadSettings() async {
    final dbService = DatabaseService();
    
    // Migrate if needed (this handles the legacy shared prefs migration)
    await dbService.migrateFromSharedPreferences();

    final localeStr = await dbService.getSetting('app_locale');
    if (localeStr != null) {
      _currentLocale = Locale(localeStr);
    }

    final traditionalRosaryStr = await dbService.getSetting('rosary_traditional');
    if (traditionalRosaryStr != null) _isTraditionalRosary = traditionalRosaryStr == 'true';

    final levelStr = await dbService.getSetting('prayer_level');
    if (levelStr != null) _prayerLevel = int.tryParse(levelStr) ?? 1;

    final scaleStr = await dbService.getSetting('text_scale');
    if (scaleStr != null) {
      _textScale = (double.tryParse(scaleStr) ?? 1.0).clamp(0.85, 1.6);
    }

    _onboardingDone = await dbService.getSetting('onboarding_done') == 'true';
    _hapticsEnabled = (await dbService.getSetting('haptics_enabled')) != 'false';
    _massGuideTraditional = (await dbService.getSetting('mass_guide_traditional')) == 'true';

    _isInitialized = true;
    notifyListeners();
  }

  Future<void> setHapticsEnabled(bool value) async {
    _hapticsEnabled = value;
    await DatabaseService().saveSetting('haptics_enabled', value.toString());
    notifyListeners();
  }

  Future<void> setMassGuideTraditional(bool value) async {
    _massGuideTraditional = value;
    await DatabaseService().saveSetting('mass_guide_traditional', value.toString());
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    _onboardingDone = true;
    await DatabaseService().saveSetting('onboarding_done', 'true');
    notifyListeners();
  }

  Future<void> setTextScale(double scale) async {
    _textScale = scale.clamp(0.85, 1.6);
    await DatabaseService().saveSetting('text_scale', _textScale.toString());
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    _currentLocale = locale;
    await DatabaseService().saveSetting('app_locale', locale.languageCode);
    notifyListeners();
  }

  Future<void> setTraditionalRosary(bool isTraditional) async {
    _isTraditionalRosary = isTraditional;
    await DatabaseService().saveSetting('rosary_traditional', isTraditional.toString());
    notifyListeners();
  }

  Future<void> setPrayerLevel(int level) async {
    _prayerLevel = level;
    await DatabaseService().saveSetting('prayer_level', level.toString());
    notifyListeners();
  }
}
