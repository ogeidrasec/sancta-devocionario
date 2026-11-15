import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';

/// Mostra se as notificações e os alarmes exatos estão liberados e leva o
/// usuário aos ajustes do sistema quando algo está bloqueado.
///
/// Com [onlyWhenProblem] (usado nos Lembretes) o cartão só aparece quando algo
/// está bloqueado; nas Configurações aparece sempre, inclusive quando está tudo certo.
class NotificationHealthCard extends StatefulWidget {
  final bool onlyWhenProblem;
  const NotificationHealthCard({super.key, this.onlyWhenProblem = false});

  @override
  State<NotificationHealthCard> createState() => _NotificationHealthCardState();
}

class _NotificationHealthCardState extends State<NotificationHealthCard>
    with WidgetsBindingObserver {
  bool? _notificationsOk;
  bool? _exactAlarmOk; // null = não se aplica / desconhecido

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _refresh();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Ao voltar dos ajustes do sistema, reavalia.
    if (state == AppLifecycleState.resumed) _refresh();
  }

  Future<void> _refresh() async {
    bool? notif;
    bool? exact;
    try {
      notif = await Permission.notification.isGranted;
      if (Platform.isAndroid) {
        exact = await Permission.scheduleExactAlarm.isGranted;
      }
    } catch (e) {
      debugPrint('NotificationHealthCard: não foi possível ler permissões: $e');
    }
    if (!mounted) return;
    setState(() {
      _notificationsOk = notif;
      _exactAlarmOk = exact;
    });
  }

  Future<void> _fixNotifications() async {
    try {
      final status = await Permission.notification.request();
      if (!status.isGranted) await openAppSettings();
    } catch (e) {
      debugPrint('NotificationHealthCard: $e');
    }
    _refresh();
  }

  Future<void> _fixExactAlarm() async {
    try {
      final status = await Permission.scheduleExactAlarm.request();
      if (!status.isGranted) await openAppSettings();
    } catch (e) {
      debugPrint('NotificationHealthCard: $e');
    }
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Sem informação (ex.: plataforma sem suporte): não mostra o cartão.
    if (_notificationsOk == null) return const SizedBox.shrink();

    final allOk = _notificationsOk == true && _exactAlarmOk != false;
    if (allOk && widget.onlyWhenProblem) return const SizedBox.shrink();
    final color = allOk ? AppColors.successColor : Colors.orange;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: appCardDecoration(tint: color, radius: 20).copyWith(
        border: Border.all(color: color.withValues(alpha: allOk ? 0.25 : 0.6), width: allOk ? 1 : 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.notifHealthTitle,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
            ),
            const SizedBox(height: 8),
            if (allOk)
              Row(
                children: [
                  const Icon(Icons.check_circle, color: AppColors.successColor),
                  const SizedBox(width: 8),
                  Expanded(child: Text(l10n.notifHealthAllGood)),
                ],
              ),
            if (_notificationsOk == false)
              _issue(
                l10n.notifHealthNotificationsOff,
                l10n.notifHealthFixAction,
                _fixNotifications,
              ),
            if (_exactAlarmOk == false)
              _issue(
                l10n.notifHealthExactAlarmOff,
                l10n.notifHealthFixAction,
                _fixExactAlarm,
              ),
            if (!allOk) ...[
              const SizedBox(height: 8),
              Text(
                l10n.notifHealthBatteryHint,
                style: const TextStyle(color: AppColors.secondaryText),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _issue(String text, String action, VoidCallback onFix) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.orange),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
          TextButton(onPressed: onFix, child: Text(action)),
        ],
      ),
    );
  }
}
