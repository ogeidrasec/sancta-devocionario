import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/providers/confession_provider.dart';
import 'package:sanctaconscientia/pages/examination_home_page.dart';
import 'package:sanctaconscientia/pages/login_page.dart';
import 'package:sanctaconscientia/widgets/privacy_shield.dart';
import 'package:sanctaconscientia/widgets/app_tour.dart';


class ExaminationTab extends StatefulWidget {
  const ExaminationTab({super.key});

  @override
  State<ExaminationTab> createState() => _ExaminationTabState();
}

class _ExaminationTabState extends State<ExaminationTab>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  /// Tempo em segundo plano a partir do qual o exame volta a pedir a senha.
  static const _lockAfter = Duration(seconds: 60);
  DateTime? _backgroundedAt;

  bool _isAuthenticated = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkAuth();
  }

  @override
  void dispose() {
    PrivacyGuard.sensitiveUnlocked.value = false;
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _backgroundedAt = DateTime.now();
    } else if (state == AppLifecycleState.resumed) {
      final since = _backgroundedAt;
      _backgroundedAt = null;
      if (since != null && DateTime.now().difference(since) >= _lockAfter) {
        _lock();
      }
    }
  }

  Future<void> _checkAuth() async {
    // Check if password exists. If not, maybe we should allow access or force creation?
    // LoginPage handles creation if no password exists.
    // But if we want to persist authentication during the session, we keep _isAuthenticated.
    // If we want to require password every time the app restarts, we start with false.
    // The user said: "ao clicar na segunda opção... seja requerido uma senha".
    // This implies if I switch away and back, maybe it stays authenticated?
    // Usually yes, for the session.
    
    // However, if the user hasn't set a password yet (first run), LoginPage handles it.
    // So we just start with false and let LoginPage do its job.
    
    // Optimization: If there is NO password set yet, LoginPage shows "Create Password".
    // If there IS a password, LoginPage shows "Enter Password".
    
    setState(() {
      _isLoading = false;
    });
  }

  void _onLoginSuccess() {
    PrivacyGuard.sensitiveUnlocked.value = true;
    setState(() {
      _isAuthenticated = true;
    });
  }

  /// Trava o Exame e fecha qualquer página sensível aberta por cima dele
  /// (categorias, guia, jornada), voltando para a tela principal.
  void _lock() {
    PrivacyGuard.sensitiveUnlocked.value = false;
    if (!mounted) return;
    Navigator.of(context, rootNavigator: true).popUntil((r) => r.isFirst);
    setState(() => _isAuthenticated = false);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ValueListenableBuilder<bool>(
      valueListenable: TourPreview.examOpen,
      builder: (context, preview, _) {
        // Durante o guia: Exame aberto, mas só com dados de exemplo (um
        // provider isolado, que nunca toca nos dados nem na senha reais).
        if (preview) {
          return ChangeNotifierProvider<ConfessionProvider>(
            create: (_) => ConfessionProvider(),
            child: const ExaminationHomePage(demo: true),
          );
        }
        return _isAuthenticated
            ? const ExaminationHomePage()
            : LoginPage(onLoginSuccess: _onLoginSuccess);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
