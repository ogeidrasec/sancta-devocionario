import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/config/donation_config.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/pages/main_scaffold.dart';
import 'package:sanctaconscientia/providers/settings_provider.dart';
import 'package:sanctaconscientia/services/notification_service.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';

const _wineDeep = Color(0xFF3A1420);
const _wine = Color(0xFF6D2424);
const _night = Color(0xFF1C2235);

/// Boas-vindas do primeiro uso (exibidas uma única vez):
/// o que o app faz, privacidade, o projeto, lembretes e o convite ao guia.
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  static const _pageCount = 6;
  static const _notifPage = 4;
  static const _readyPage = 5;
  final _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finish({required bool tour}) async {
    final settings = context.read<SettingsProvider>();
    final navigator = Navigator.of(context);
    await settings.completeOnboarding();
    navigator.pushReplacement(
      MaterialPageRoute(builder: (_) => MainScaffold(startTour: tour)),
    );
  }

  Future<void> _enableNotifications() async {
    try {
      await NotificationService().requestPermissions();
    } catch (e) {
      debugPrint('Onboarding: permissão de notificação falhou: $e');
    }
    if (mounted) _goTo(_readyPage);
  }

  void _goTo(int page) => _controller.animateToPage(
        page,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOutCubic,
      );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final slides = <Widget>[
      _Slide(
        icon: Icons.church,
        title: l10n.onbWelcomeTitle,
        body: l10n.onbWelcomeBody,
      ),
      _Slide(
        icon: Icons.auto_awesome,
        title: l10n.onbFeaturesTitle,
        items: [
          (Icons.park, l10n.onbFeatureGarden),
          (Icons.menu_book, l10n.onbFeaturePrayers),
          (Icons.radio_button_checked, l10n.onbFeatureRosary),
          (Icons.lock, l10n.onbFeatureExam),
          (Icons.local_fire_department, l10n.onbFeatureGuides),
        ],
      ),
      _Slide(
        icon: Icons.shield_moon,
        title: l10n.onbPrivacyTitle,
        body: l10n.onbPrivacyBody,
        items: [
          (Icons.person_off, l10n.onbPrivacyNoAccount),
          (Icons.block, l10n.onbPrivacyNoAds),
          (Icons.save_alt, l10n.onbPrivacyBackup),
        ],
      ),
      _Slide(
        icon: Icons.favorite,
        title: l10n.onbProjectTitle,
        body: DonationConfig.showPaymentLinks ? l10n.onbProjectBody : l10n.onbProjectBodyStore,
      ),
      _Slide(
        icon: Icons.notifications_active,
        title: l10n.onbNotifTitle,
        body: l10n.onbNotifBody,
      ),
      _Slide(
        icon: Icons.explore,
        title: l10n.onbReadyTitle,
        body: l10n.onbReadyBody,
      ),
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_wineDeep, _wine, _night],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 48,
                child: _page < _readyPage
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          key: const ValueKey('onb_skip'),
                          onPressed: () => _goTo(_readyPage),
                          child: Text(l10n.onbSkip, style: const TextStyle(color: Colors.white70)),
                        ),
                      )
                    : null,
              ),
              Expanded(
                child: PageView(
                  controller: _controller,
                  onPageChanged: (i) => setState(() => _page = i),
                  children: slides,
                ),
              ),
              _Dots(count: _pageCount, current: _page),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
                child: _primaryButton(l10n),
              ),
              SizedBox(height: 52, child: _secondaryButton(l10n)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _primaryButton(AppLocalizations l10n) {
    final (label, action, key) = switch (_page) {
      _notifPage => (l10n.onbEnableNotifications, _enableNotifications, 'onb_enable_notif'),
      _readyPage => (l10n.onbTourStart, () => _finish(tour: true), 'onb_tour_start'),
      _ => (l10n.onbNext, () => _goTo(_page + 1), 'onb_next'),
    };
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        key: ValueKey(key),
        onPressed: action,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentGold,
          foregroundColor: _night,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget? _secondaryButton(AppLocalizations l10n) {
    final (label, action, key) = switch (_page) {
      _notifPage => (l10n.onbStart, () => _goTo(_readyPage), 'onb_notif_later'),
      _readyPage => (l10n.onbTourSkip, () => _finish(tour: false), 'onb_tour_skip'),
      _ => (null, null, ''),
    };
    if (label == null) return null;
    return TextButton(
      key: ValueKey(key),
      onPressed: action,
      child: Text(label, style: const TextStyle(color: Colors.white70)),
    );
  }
}

class _Dots extends StatelessWidget {
  final int count;
  final int current;
  const _Dots({required this.count, required this.current});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: i == current ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: i == current ? AppColors.accentGold : Colors.white24,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? body;
  final List<(IconData, String)> items;

  const _Slide({required this.icon, required this.title, this.body, this.items = const []});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: c.maxHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              // ícone com halo dourado
              Container(
                width: 112,
                height: 112,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [
                    AppColors.accentGold.withValues(alpha: 0.35),
                    AppColors.accentGold.withValues(alpha: 0.0),
                  ]),
                ),
                child: Center(
                  child: Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.08),
                      border: Border.all(color: AppColors.accentGold, width: 1.5),
                    ),
                    child: Icon(icon, size: 38, color: AppColors.accentGold),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white, height: 1.2),
              ),
              if (body != null) ...[
                const SizedBox(height: 14),
                Text(
                  body!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16.5, height: 1.45, color: Colors.white70),
                ),
              ],
              if (items.isNotEmpty) ...[
                const SizedBox(height: 20),
                for (final it in items)
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.07),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
                    ),
                    child: Row(
                      children: [
                        Icon(it.$1, color: AppColors.accentGold, size: 24),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(it.$2,
                              style: const TextStyle(fontSize: 15, height: 1.3, color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
              ],
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
