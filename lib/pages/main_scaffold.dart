import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/pages/devotional_home_page.dart';
import 'package:sanctaconscientia/pages/examination_tab.dart';

import 'package:sanctaconscientia/pages/novena_home_page.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/pages/rosary_mysteries_page.dart';

import 'package:sanctaconscientia/pages/plano_vida_page.dart';

import 'package:sanctaconscientia/services/notification_service.dart';
import 'package:sanctaconscientia/pages/rosary_prayer_page.dart';
import 'package:sanctaconscientia/pages/novena_detail_page.dart';
import 'package:sanctaconscientia/data/prayer_data.dart';
import 'package:sanctaconscientia/pages/prayer_detail_page.dart';
import 'package:sanctaconscientia/widgets/app_tour.dart';
import 'package:sanctaconscientia/pages/support_project_page.dart';
import 'package:sanctaconscientia/config/donation_config.dart';

class MainScaffold extends StatefulWidget {
  final int initialIndex;
  /// Abre o guia do app logo ao entrar (primeiro uso).
  final bool startTour;
  const MainScaffold({super.key, this.initialIndex = 0, this.startTour = false});

  static MainScaffoldState? of(BuildContext context) {
    return context.findAncestorStateOfType<MainScaffoldState>();
  }

  @override
  State<MainScaffold> createState() => MainScaffoldState();
}

class MainScaffoldState extends State<MainScaffold> with WidgetsBindingObserver {
  late int _currentIndex = widget.initialIndex;
  final Set<int> _visited = {};
  bool _tour = false;

  Future<void> _showProjectDialog() async {
    final l10n = AppLocalizations.of(context)!;
    final go = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        key: const ValueKey('project_dialog'),
        icon: const Icon(Icons.favorite, color: AppColors.accentGold, size: 36),
        title: Text(l10n.afterTourTitle, textAlign: TextAlign.center),
        content: SingleChildScrollView(
          child: Text(
            DonationConfig.showPaymentLinks ? l10n.afterTourBody : l10n.afterTourBodyStore,
            style: const TextStyle(height: 1.45),
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsOverflowAlignment: OverflowBarAlignment.center,
        actionsOverflowButtonSpacing: 4,
        actions: [
          FilledButton(
            key: const ValueKey('project_dialog_go'),
            style: FilledButton.styleFrom(backgroundColor: AppColors.themeColor),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.afterTourButton),
          ),
          TextButton(
            key: const ValueKey('project_dialog_later'),
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.afterTourLater),
          ),
        ],
      ),
    );
    if (go == true && mounted) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SupportProjectPage()));
    }
  }

  /// Abre o guia passo a passo (também pelo menu lateral).
  void startTour() {
    Navigator.of(context).popUntil((r) => r.isFirst || r.settings.name == null && r is! PopupRoute);
    setState(() => _tour = true);
    _warmUpTabs();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLaunchPayload();
      if (widget.startTour && mounted) {
        setState(() => _tour = true);
        _warmUpTabs();
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<PrayerProvider>().onAppResumed();
    }
  }

  void _checkLaunchPayload() {
    debugPrint('DEBUG: Checking launch payload in MainScaffold');
    final payload = NotificationService().consumeLaunchPayload();
    if (payload != null) {
      debugPrint('DEBUG: Found payload in MainScaffold, handling click');
      handleNotificationClick(payload);
    }
  }

  void handleNotificationClick(String payload) {
    debugPrint('DEBUG: Handling notification click with payload: $payload');
    
    if (payload == 'full_examination' || payload.contains('examination')) {
      // Switch to Examination tab (index 4)
      switchToTab(4);
      // Optional: Push specific page if needed, but tab switch is good for now
    } else if (payload.startsWith('novena_')) {
      // Switch to Novenas tab (index 2)
      switchToTab(2);
      
      // Extract novena ID
      final novenaId = payload;
      // Push detail page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NovenaDetailPage(novenaId: novenaId),
        ),
      );
    } else if (payload.contains('rosary')) {
      // Switch to Rosary tab (index 3)
      switchToTab(3);
      
      // Extract mystery type if present (e.g., rosary_joyful)
      if (payload.startsWith('rosary_')) {
        final mysteryString = payload.replaceAll('rosary_', '');
        MysteryType? mysteryType;
        
        switch (mysteryString) {
          case 'joyful': mysteryType = MysteryType.joyful; break;
          case 'sorrowful': mysteryType = MysteryType.sorrowful; break;
          case 'glorious': mysteryType = MysteryType.glorious; break;
          case 'luminous': mysteryType = MysteryType.luminous; break;
        }
        
        if (mysteryType != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RosaryPrayerPage(mysteryType: mysteryType!),
            ),
          );
        }
      }
    } else {
      // Check if it's a general prayer
      final prayer = PrayerData.getPrayerById(context, payload);
      if (prayer != null) {
        // Switch to Devotional tab (index 1)
        switchToTab(1);
        
        if (prayer.containsKey('route')) {
           Navigator.push(context, MaterialPageRoute(builder: prayer['route']));
        } else {
          final title = prayer['title'] as String? ?? '';
          final content = prayer['content'] as String? ?? '';
          
          if (title.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PrayerDetailPage(
                  title: title,
                  content: content,
                  contentLatin: prayer['contentLatin'] as String?,
                  prayerId: prayer['id'] as String?,
                ),
              ),
            );
          }
        }
      } else {
        // Default fallback: Devotional Home (Index 1)
        switchToTab(1);
      }
    }
  }

  /// Durante o guia, monta as outras abas aos poucos (uma por vez, enquanto a
  /// pessoa lê os primeiros passos). Assim, ao chegar no passo de Orações, a
  /// aba já está pronta e a troca não trava.
  Future<void> _warmUpTabs() async {
    for (final i in [1, 2, 3, 4]) {
      await Future.delayed(const Duration(milliseconds: 700));
      if (!mounted || !_tour) return;
      if (_visited.contains(i)) continue;
      setState(() => _visited.add(i));
    }
  }

  void switchToTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onItemTapped(int index) {
    switchToTab(index);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    // Cada aba só é montada na primeira visita: abrir o app não constrói
    // (nem decodifica as fotos de) as cinco telas de uma vez.
    _visited.add(_currentIndex);
    Widget tab(int i, Widget Function() build) =>
        _visited.contains(i) ? build() : const SizedBox.shrink();

    final scaffold = Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          tab(0, () => const PlanoVidaPage()), // Jardim da Alma
          tab(1, () => const DevotionalHomePage()), // Orações
          tab(2, () => const NovenaHomePage()), // Novenas
          tab(3, () => const RosaryMysteriesPage()), // Rosário
          tab(4, () => const ExaminationTab()), // Exame
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.primaryText,
        selectedItemColor: AppColors.accentGold,
        unselectedItemColor: Colors.white,
        iconSize: 30,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        items: [
          BottomNavigationBarItem(
            icon: KeyedSubtree(key: AppTourKeys.navGarden, child: const Icon(Icons.park)),
            label: l10n.moreTitle,
          ),
          BottomNavigationBarItem(
            icon: KeyedSubtree(key: AppTourKeys.navPrayers, child: const Icon(Icons.church)),
            label: l10n.devotionalTitle,
          ),
          BottomNavigationBarItem(
            icon: KeyedSubtree(key: AppTourKeys.navNovenas, child: const Icon(Icons.local_florist)),
            label: l10n.prayersTitle,
          ),
          BottomNavigationBarItem(
            icon: KeyedSubtree(key: AppTourKeys.navRosary, child: const Icon(Icons.auto_awesome)),
            label: l10n.rosaryTitle,
          ),
          BottomNavigationBarItem(
            icon: KeyedSubtree(key: AppTourKeys.navExam, child: const Icon(Icons.assignment)),
            label: l10n.examinationMenuTitle,
          ),
        ],
      ),
    );

    return Stack(
      children: [
        scaffold,
        if (_tour)
          Positioned.fill(
            child: AppTourOverlay(
              steps: buildAppTourSteps(l10n),
              onTabChange: switchToTab,
              onFinish: () {
                setState(() => _tour = false);
                switchToTab(0);
                // ao fim do guia (concluído ou pulado), conta sobre o projeto
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) _showProjectDialog();
                });
              },
            ),
          ),
      ],
    );
  }
}
