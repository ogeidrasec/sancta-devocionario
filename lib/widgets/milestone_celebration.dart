import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/pages/spiritual_growth_page.dart';
import 'package:sanctaconscientia/providers/confession_provider.dart';
import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/services/database_service.dart';
import 'package:sanctaconscientia/services/haptics_service.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/utils/spiritual_milestones.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';
import 'package:sanctaconscientia/widgets/petal_shower.dart';

/// Observa as mudanças de orações, Missas, novenas e confissões para celebrar
/// com um pop-up discreto (e pétalas) cada vez que uma nova meta é alcançada.
class MilestoneCelebrationWatcher extends StatefulWidget {
  final Widget child;
  final bool paused;

  const MilestoneCelebrationWatcher({
    super.key,
    required this.child,
    this.paused = false,
  });

  static const settingKey = 'celebrated_milestones';

  static Future<void> showCelebrationDialog(
    BuildContext context,
    List<SpiritualMilestone> unlocked,
  ) async {
    if (unlocked.isEmpty || !context.mounted) return;
    final l10n = AppLocalizations.of(context)!;
    const gold = Color(0xFFB7791F);

    showPetalShower(context);
    HapticsService.play(HapticKind.medium);

    final go = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        key: const ValueKey('milestone_celebration_dialog'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        icon: const CircleIcon(icon: Icons.emoji_events, color: gold, size: 54),
        title: Text(
          unlocked.length == 1
              ? l10n.growthPopupTitleSingle
              : l10n.growthPopupTitleMulti,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryText,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final m in unlocked) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: gold.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: gold.withValues(alpha: 0.35)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        m.title(l10n),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        m.description(l10n),
                        style: const TextStyle(
                          fontSize: 13,
                          height: 1.35,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ],
              const SizedBox(height: 4),
              Text(
                l10n.growthPopupEncouragement,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsOverflowAlignment: OverflowBarAlignment.center,
        actionsOverflowButtonSpacing: 6,
        actions: [
          FilledButton(
            key: const ValueKey('milestone_dialog_view_all'),
            style: FilledButton.styleFrom(backgroundColor: gold),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(l10n.growthPopupViewAll),
          ),
          TextButton(
            key: const ValueKey('milestone_dialog_continue'),
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.growthPopupContinue),
          ),
        ],
      ),
    );

    if (go == true && context.mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const SpiritualGrowthPage()),
      );
    }
  }

  @override
  State<MilestoneCelebrationWatcher> createState() =>
      _MilestoneCelebrationWatcherState();
}

class _MilestoneCelebrationWatcherState
    extends State<MilestoneCelebrationWatcher> {
  PrayerProvider? _prayers;
  ConfessionProvider? _confessions;
  final Set<String> _celebrated = {};
  bool _initialized = false;
  bool _dialogOpen = false;
  bool _checkScheduled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final prayers = Provider.of<PrayerProvider>(context, listen: false);
    final confessions = Provider.of<ConfessionProvider>(context, listen: false);

    if (_prayers != prayers) {
      _prayers?.removeListener(_onDataChanged);
      _prayers = prayers;
      _prayers?.addListener(_onDataChanged);
    }
    if (_confessions != confessions) {
      _confessions?.removeListener(_onDataChanged);
      _confessions = confessions;
      _confessions?.addListener(_onDataChanged);
    }

    if (!_initialized) {
      _initCelebrated();
    }
  }

  @override
  void didUpdateWidget(covariant MilestoneCelebrationWatcher oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.paused && !widget.paused && _initialized) {
      _scheduleCheck();
    }
  }

  @override
  void dispose() {
    _prayers?.removeListener(_onDataChanged);
    _confessions?.removeListener(_onDataChanged);
    super.dispose();
  }

  Future<void> _initCelebrated() async {
    try {
      final raw = await DatabaseService().getSetting(
        MilestoneCelebrationWatcher.settingKey,
      );
      if (!mounted) return;
      if (raw != null && raw.isNotEmpty) {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          _celebrated.addAll(decoded.whereType<String>());
        }
      } else if (_prayers != null && _confessions != null) {
        // Primeira vez após ativar o recurso: registra silenciosamente marcos
        // já alcançados no histórico anterior para não abrir vários pop-ups na abertura.
        final snapshot = SpiritualMilestonesCalculator.computeFromProviders(
          _prayers!,
          _confessions!,
        );
        _celebrated.addAll(snapshot.achievedIds);
        await DatabaseService().saveSetting(
          MilestoneCelebrationWatcher.settingKey,
          jsonEncode(_celebrated.toList()..sort()),
        );
      }
    } catch (e) {
      debugPrint('MilestoneCelebrationWatcher: failed to load milestones ($e)');
    }
    if (mounted) {
      _initialized = true;
    }
  }

  void _onDataChanged() {
    if (!_initialized || widget.paused) return;
    _scheduleCheck();
  }

  void _scheduleCheck() {
    if (_checkScheduled || _dialogOpen || !mounted) return;
    _checkScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkScheduled = false;
      _checkForNewMilestones();
    });
  }

  Future<void> _checkForNewMilestones() async {
    if (!mounted || !_initialized || widget.paused || _dialogOpen) return;
    final prayers = _prayers;
    final confessions = _confessions;
    if (prayers == null || confessions == null) return;

    final snapshot = SpiritualMilestonesCalculator.computeFromProviders(
      prayers,
      confessions,
    );
    final newlyUnlocked = snapshot.milestones
        .where((m) => m.achieved && !_celebrated.contains(m.id))
        .toList();
    if (newlyUnlocked.isEmpty) return;

    _celebrated.addAll(newlyUnlocked.map((m) => m.id));
    await DatabaseService().saveSetting(
      MilestoneCelebrationWatcher.settingKey,
      jsonEncode(_celebrated.toList()..sort()),
    );
    if (!mounted || widget.paused) return;

    _dialogOpen = true;
    try {
      await MilestoneCelebrationWatcher.showCelebrationDialog(
        context,
        newlyUnlocked,
      );
    } finally {
      _dialogOpen = false;
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
