import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/providers/confession_provider.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/services/auth_service.dart';
import 'package:sanctaconscientia/services/local_storage.dart';
import 'package:sanctaconscientia/pages/main_scaffold.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';

/// Tela de senha do Exame de Consciência: criar a senha (primeiro acesso),
/// entrar ou, se esqueceu, apagar os dados do exame para criar outra.
class LoginPage extends StatefulWidget {
  final VoidCallback? onLoginSuccess;

  const LoginPage({super.key, this.onLoginSuccess});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _novaSenhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController = TextEditingController();
  final AuthService _authService = AuthService();
  final LocalStorage _localStorage = LocalStorage();

  bool _primeiroAcesso = true;
  bool _recuperacao = false;
  bool _isLoading = true;
  String _erro = '';
  bool _mostrarSenha = false;

  @override
  void initState() {
    super.initState();
    _verificarPrimeiroAcesso();
  }

  @override
  void dispose() {
    _senhaController.dispose();
    _novaSenhaController.dispose();
    _confirmarSenhaController.dispose();
    super.dispose();
  }

  void _verificarPrimeiroAcesso() async {
    final temSenha = await _authService.hasPassword();
    if (!mounted) return;
    setState(() {
      _primeiroAcesso = !temSenha;
      _isLoading = false;
    });
  }

  void _entrou() {
    if (widget.onLoginSuccess != null) {
      widget.onLoginSuccess!();
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScaffold(initialIndex: 4)),
      );
    }
  }

  void _verificarSenha(AppLocalizations l10n) async {
    final senha = _senhaController.text;
    if (senha.isEmpty) {
      setState(() => _erro = l10n.passwordErrorEmpty);
      return;
    }

    final senhaCorreta = await _authService.verificarSenha(senha);
    if (!mounted) return;

    if (senhaCorreta) {
      _entrou();
    } else {
      setState(() {
        _erro = l10n.passwordErrorIncorrect;
        _senhaController.clear();
      });
    }
  }

  void _criarSenha(AppLocalizations l10n) async {
    final novaSenha = _novaSenhaController.text;
    final confirmarSenha = _confirmarSenhaController.text;

    if (novaSenha.isEmpty) {
      setState(() => _erro = l10n.passwordErrorEmpty);
      return;
    }
    if (novaSenha.length < 4) {
      setState(() => _erro = l10n.passwordErrorShort);
      return;
    }
    if (novaSenha != confirmarSenha) {
      setState(() => _erro = l10n.passwordErrorMismatch);
      return;
    }

    await _authService.definirSenha(novaSenha);
    if (!mounted) return;
    _entrou();
  }

  void _recuperarAcesso(AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.recoverAccessTitle),
        content: Text(l10n.recoverAccessWarning),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(l10n.recoverAccessCancel),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              // Apaga de verdade os dados do exame (banco de dados) e a senha:
              // sem isso, criar outra senha daria acesso ao exame anterior.
              await Provider.of<ConfessionProvider>(context, listen: false).apagarDadosDoExame();
              await _localStorage.clearAllData();
              if (!mounted) return;
              setState(() {
                _recuperacao = false;
                _primeiroAcesso = true;
                _erro = '';
              });
            },
            child: Text(l10n.recoverAccessConfirm, style: const TextStyle(color: AppColors.errorColor)),
          ),
        ],
      ),
    );
  }

  Widget _errorBox(String message) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.errorColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.errorColor.withValues(alpha: 0.4)),
        ),
        child: Row(
          children: [
            const Icon(Icons.error_outline, color: AppColors.errorColor, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(message, style: const TextStyle(color: AppColors.errorColor, fontSize: 14)),
            ),
          ],
        ),
      );

  InputDecoration _field(String label, {bool toggle = false}) => InputDecoration(
        labelText: label,
        suffixIcon: toggle
            ? IconButton(
                icon: Icon(_mostrarSenha ? Icons.visibility : Icons.visibility_off),
                onPressed: () => setState(() => _mostrarSenha = !_mostrarSenha),
              )
            : null,
      );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.themeColor),
          ),
        ),
      );
    }

    const color = AppColors.themeColor;
    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [color, Color.lerp(color, Colors.black, 0.35)!],
                    ),
                    boxShadow: [
                      BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 14, offset: const Offset(0, 6)),
                    ],
                  ),
                  child: const Icon(Icons.lock_outline, color: Colors.white, size: 40),
                ),
                const SizedBox(height: 20),
                Text(
                  l10n.examinationTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.primaryText),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.appTitle,
                  style: const TextStyle(fontSize: 15, color: AppColors.secondaryText),
                ),
                const SizedBox(height: 28),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: appCardDecoration(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (!_primeiroAcesso && !_recuperacao) ..._buildLoginForm(l10n),
                      if (_primeiroAcesso && !_recuperacao) ..._buildPrimeiroAcesso(l10n),
                      if (_recuperacao) ..._buildRecuperacao(l10n),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  l10n.dataStorageInfo,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, color: AppColors.secondaryText),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildLoginForm(AppLocalizations l10n) {
    return [
      TextField(
        controller: _senhaController,
        obscureText: !_mostrarSenha,
        autofocus: true,
        textInputAction: TextInputAction.done,
        decoration: _field(l10n.passwordLabel, toggle: true),
        onSubmitted: (_) => _verificarSenha(l10n),
      ),
      if (_erro.isNotEmpty) ...[const SizedBox(height: 14), _errorBox(_erro)],
      const SizedBox(height: 18),
      PillButton(label: l10n.loginButton, onPressed: () => _verificarSenha(l10n)),
      const SizedBox(height: 6),
      TextButton(
        onPressed: () => setState(() => _recuperacao = true),
        child: Text(l10n.forgotPasswordButton, style: const TextStyle(color: AppColors.themeColor)),
      ),
    ];
  }

  List<Widget> _buildPrimeiroAcesso(AppLocalizations l10n) {
    return [
      TextField(
        controller: _novaSenhaController,
        obscureText: !_mostrarSenha,
        textInputAction: TextInputAction.next,
        decoration: _field(l10n.createPasswordLabel, toggle: true),
      ),
      const SizedBox(height: 16),
      TextField(
        controller: _confirmarSenhaController,
        obscureText: !_mostrarSenha,
        textInputAction: TextInputAction.done,
        decoration: _field(l10n.confirmPasswordLabel),
        onSubmitted: (_) => _criarSenha(l10n),
      ),
      if (_erro.isNotEmpty) ...[const SizedBox(height: 14), _errorBox(_erro)],
      const SizedBox(height: 18),
      PillButton(label: l10n.createPasswordButton, onPressed: () => _criarSenha(l10n)),
    ];
  }

  List<Widget> _buildRecuperacao(AppLocalizations l10n) {
    return [
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.warningColor.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.warningColor.withValues(alpha: 0.5)),
        ),
        child: Column(
          children: [
            const Icon(Icons.warning_amber_rounded, color: AppColors.warningColor, size: 36),
            const SizedBox(height: 8),
            Text(
              l10n.recoverAccessWarning,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.primaryText, height: 1.4),
            ),
          ],
        ),
      ),
      const SizedBox(height: 18),
      PillButton(
        label: l10n.recoverAccessButton,
        color: AppColors.errorColor,
        onPressed: () => _recuperarAcesso(l10n),
      ),
      const SizedBox(height: 6),
      TextButton(
        onPressed: () => setState(() => _recuperacao = false),
        child: Text(l10n.loginBackLabel, style: const TextStyle(color: AppColors.themeColor)),
      ),
    ];
  }
}
