import 'package:flutter/material.dart';
import 'package:sanctaconscientia/utils/app_images.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';

/// Indica se há conteúdo sensível (Exame de consciência) destravado na tela.
class PrivacyGuard {
  PrivacyGuard._();
  static final ValueNotifier<bool> sensitiveUnlocked = ValueNotifier(false);
}

/// Cobre o app quando ele sai do primeiro plano (lista de apps recentes,
/// central de notificações) enquanto o Exame está destravado, para que o
/// conteúdo dos pecados não apareça na miniatura do sistema.
class PrivacyShield extends StatefulWidget {
  final Widget child;
  const PrivacyShield({super.key, required this.child});

  @override
  State<PrivacyShield> createState() => _PrivacyShieldState();
}

class _PrivacyShieldState extends State<PrivacyShield> with WidgetsBindingObserver {
  bool _inBackground = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final away = state != AppLifecycleState.resumed;
    if (away != _inBackground) setState(() => _inBackground = away);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      textDirection: TextDirection.ltr,
      children: [
        widget.child,
        ValueListenableBuilder<bool>(
          valueListenable: PrivacyGuard.sensitiveUnlocked,
          builder: (context, unlocked, _) {
            if (!(unlocked && _inBackground)) return const SizedBox.shrink();
            return Positioned.fill(
              child: ColoredBox(
                color: AppColors.primaryBg,
                child: Center(
                  child: Image.asset(
                    AppImages.logo,
                    width: 160,
                    height: 160,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
