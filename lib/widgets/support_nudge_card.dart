import 'package:flutter/material.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/pages/support_project_page.dart';
import 'package:sanctaconscientia/services/database_service.dart';
import 'package:sanctaconscientia/services/support_nudge.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';

/// Lembrete gentil de apoio ao projeto (aba Hoje). Aparece de tempos em tempos
/// (veja [SupportNudge]) e some com qualquer resposta.
class SupportNudgeCard extends StatefulWidget {
  /// Para testes: decide sem consultar o banco.
  final Future<bool> Function()? shouldShowOverride;
  const SupportNudgeCard({super.key, this.shouldShowOverride});

  @override
  State<SupportNudgeCard> createState() => _SupportNudgeCardState();
}

class _SupportNudgeCardState extends State<SupportNudgeCard> {
  static const _color = Color(0xFF6A1B9A);
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    (widget.shouldShowOverride ?? SupportNudge.shouldShow)().then((show) {
      if (mounted && show) setState(() => _visible = true);
    }).catchError((_) {});
  }

  void _hide() => setState(() => _visible = false);

  Future<void> _support() async {
    _hide();
    await Navigator.push(context, MaterialPageRoute(builder: (_) => const SupportProjectPage()));
  }

  Future<void> _pray() async {
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);
    _hide();
    messenger.showSnackBar(SnackBar(content: Text(l10n.supportPrayerThanks)));
    await DatabaseService()
        .saveSetting(SupportProjectPage.prayerPromiseKey, DateTime.now().toIso8601String())
        .catchError((_) {});
    await SupportNudge.snooze(SupportNudge.prayerSnooze).catchError((_) {});
  }

  Future<void> _notNow() async {
    _hide();
    await SupportNudge.notNow().catchError((_) {});
  }

  Future<void> _alreadySupported() async {
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);
    _hide();
    messenger.showSnackBar(SnackBar(content: Text(l10n.nudgeThanksSupported)));
    await SupportNudge.snooze(SupportNudge.supportedSnooze).catchError((_) {});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      alignment: Alignment.topCenter,
      child: !_visible
          ? const SizedBox(width: double.infinity)
          : Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                key: const ValueKey('support_nudge'),
                padding: const EdgeInsets.fromLTRB(14, 10, 6, 6),
                decoration: BoxDecoration(
                  color: _color.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _color.withValues(alpha: 0.18)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.favorite, size: 16, color: _color),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            l10n.nudgeTitle,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _color),
                          ),
                        ),
                        IconButton(
                          key: const ValueKey('nudge_close'),
                          tooltip: l10n.nudgeNotNow,
                          visualDensity: VisualDensity.compact,
                          icon: const Icon(Icons.close, size: 18, color: AppColors.secondaryText),
                          onPressed: _notNow,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        l10n.nudgeBody,
                        style: const TextStyle(fontSize: 13, height: 1.4, color: AppColors.secondaryText),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 4,
                      children: [
                        TextButton.icon(
                          key: const ValueKey('nudge_support'),
                          onPressed: _support,
                          icon: const Icon(Icons.volunteer_activism, size: 18),
                          label: Text(l10n.nudgeSupport),
                          style: TextButton.styleFrom(foregroundColor: _color),
                        ),
                        TextButton(
                          key: const ValueKey('nudge_pray'),
                          onPressed: _pray,
                          style: TextButton.styleFrom(foregroundColor: _color),
                          child: Text(l10n.supportPrayerButton),
                        ),
                        TextButton(
                          key: const ValueKey('nudge_supported'),
                          onPressed: _alreadySupported,
                          style: TextButton.styleFrom(foregroundColor: AppColors.secondaryText),
                          child: Text(l10n.nudgeAlreadySupported),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
