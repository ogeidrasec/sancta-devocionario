import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/providers/app_state.dart';
import 'package:sanctaconscientia/providers/settings_provider.dart';
import 'package:sanctaconscientia/providers/confession_provider.dart';
import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/providers/liturgical_provider.dart';
import 'package:sanctaconscientia/pages/main_scaffold.dart';
import 'package:sanctaconscientia/widgets/notification_health_card.dart';
import '../services/auth_service.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/services/backup_service.dart';
import 'package:sanctaconscientia/pages/support_project_page.dart';

class ConfiguracoesPage extends StatelessWidget {
  const ConfiguracoesPage({super.key});

  void _alterarSenha(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final senhaAtualController = TextEditingController();
    final novaSenhaController = TextEditingController();
    final confirmarSenhaController = TextEditingController();
    bool mostrarSenhaAtual = false;
    bool mostrarNovaSenha = false;
    bool mostrarConfirmarSenha = false;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(l10n.changePasswordTitle),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: senhaAtualController,
                    obscureText: !mostrarSenhaAtual,
                    decoration: InputDecoration(
                      labelText: l10n.currentPasswordLabel,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      suffixIcon: IconButton(
                        icon: Icon(mostrarSenhaAtual ? Icons.visibility : Icons.visibility_off),
                        onPressed: () => setState(() => mostrarSenhaAtual = !mostrarSenhaAtual),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: novaSenhaController,
                    obscureText: !mostrarNovaSenha,
                    decoration: InputDecoration(
                      labelText: l10n.newPasswordLabel,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      suffixIcon: IconButton(
                        icon: Icon(mostrarNovaSenha ? Icons.visibility : Icons.visibility_off),
                        onPressed: () => setState(() => mostrarNovaSenha = !mostrarNovaSenha),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: confirmarSenhaController,
                    obscureText: !mostrarConfirmarSenha,
                    decoration: InputDecoration(
                      labelText: l10n.confirmNewPasswordLabel,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      suffixIcon: IconButton(
                        icon: Icon(mostrarConfirmarSenha ? Icons.visibility : Icons.visibility_off),
                        onPressed: () => setState(() => mostrarConfirmarSenha = !mostrarConfirmarSenha),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(l10n.cancelButton),
              ),
              TextButton(
                onPressed: () async {
                  // Capturar context antes das operações async
                  final currentContext = context;
                  final scaffoldMessenger = ScaffoldMessenger.of(currentContext);

                  final senhaAtual = senhaAtualController.text;
                  final novaSenha = novaSenhaController.text;
                  final confirmarSenha = confirmarSenhaController.text;

                  if (senhaAtual.isEmpty || novaSenha.isEmpty || confirmarSenha.isEmpty) {
                    scaffoldMessenger.showSnackBar(
                      SnackBar(content: Text(l10n.fillAllFields)),
                    );
                    return;
                  }

                  // Verificar senha atual
                  final authService = AuthService();
                  final senhaCorreta = await authService.verificarSenha(senhaAtual);
                  if (!currentContext.mounted) return;
                  if (!senhaCorreta) {
                    scaffoldMessenger.showSnackBar(
                      SnackBar(content: Text(l10n.currentPasswordIncorrect)),
                    );
                    return;
                  }

                  if (novaSenha.length < 4) {
                    scaffoldMessenger.showSnackBar(
                      SnackBar(content: Text(l10n.passwordErrorShort)),
                    );
                    return;
                  }

                  if (novaSenha != confirmarSenha) {
                    scaffoldMessenger.showSnackBar(
                      SnackBar(content: Text(l10n.passwordErrorMismatch)),
                    );
                    return;
                  }

                  // Alterar senha
                  await authService.definirSenha(novaSenha);

                  if (!currentContext.mounted) return;

                  // Fechar dialog
                  Navigator.of(ctx).pop();

                  scaffoldMessenger.showSnackBar(
                    SnackBar(content: Text(l10n.passwordSuccessMessage)),
                  );
                },
                child: Text(l10n.changePasswordAction),
              ),
            ],
          );
        },
      ),
    );
  }

  void _recuperarAcesso(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.recoverAccessTitle),
        content: Text(l10n.recoverAccessWarning),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(l10n.cancelButton),
          ),
          TextButton(
            onPressed: () {
              // Capturar context antes das operações async
              final currentContext = context;
              Navigator.of(ctx).pop();

              final confessionProvider = Provider.of<ConfessionProvider>(currentContext, listen: false);
              confessionProvider.limparDados();

              // Volta ao app (aba Exame), que pedirá a criação de nova senha
              Navigator.pushAndRemoveUntil(
                currentContext,
                MaterialPageRoute(builder: (context) => const MainScaffold(initialIndex: 4)),
                    (route) => false,
              );
            },
            child: Text(l10n.recoverAccessConfirm, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _limparExame(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.clearExamDialogTitle),
        content: Text(l10n.clearExamDialogContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(l10n.cancelButton),
          ),
          TextButton(
            onPressed: () {
              // CORREÇÃO: Removido o uso do retorno void
              final currentContext = context;
              Navigator.of(ctx).pop();

              final confessionProvider = Provider.of<ConfessionProvider>(currentContext, listen: false);
              confessionProvider.limparDados();

              ScaffoldMessenger.of(currentContext).showSnackBar(
                SnackBar(content: Text(l10n.clearExamSuccess)),
              );
            },
            child: Text(l10n.clearExamAction, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  /// Troca o idioma e atualiza o texto dos lembretes já agendados.
  Future<void> _changeLanguage(BuildContext context, SettingsProvider settings, String code) async {
    final liturgical = context.read<LiturgicalProvider>();
    final appState = context.read<AppState>();
    await settings.setLocale(Locale(code));
    await liturgical.refreshNotificationTexts();
    await appState.rescheduleAllReminders();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return InnerPageScaffold(
      title: l10n.configTitle,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Idioma
          Consumer<SettingsProvider>(
            builder: (context, settingsProvider, child) {
              return _ConfiguracaoItem(
                titulo: l10n.configLanguageTitle,
                icone: Icons.language,
                descricao: l10n.configLanguageDesc,
                botaoTexto: (settingsProvider.currentLocale?.languageCode ?? Localizations.localeOf(context).languageCode) == 'en' 
                    ? l10n.languageEnglish 
                    : l10n.languagePortuguese,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text(l10n.configLanguageTitle),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text(l10n.languagePortuguese),
                            // ignore: deprecated_member_use
                            leading: Radio<String>(
                              value: 'pt',
                              // ignore: deprecated_member_use
                              groupValue: settingsProvider.currentLocale?.languageCode ?? Localizations.localeOf(context).languageCode,
                              // ignore: deprecated_member_use
                              onChanged: (value) {
                                _changeLanguage(context, settingsProvider, 'pt');
                                Navigator.pop(ctx);
                              },
                            ),
                            onTap: () {
                              _changeLanguage(context, settingsProvider, 'pt');
                              Navigator.pop(ctx);
                            },
                          ),
                          ListTile(
                            title: Text(l10n.languageEnglish),
                            // ignore: deprecated_member_use
                            leading: Radio<String>(
                              value: 'en',
                              // ignore: deprecated_member_use
                              groupValue: settingsProvider.currentLocale?.languageCode ?? Localizations.localeOf(context).languageCode,
                              // ignore: deprecated_member_use
                              onChanged: (value) {
                                _changeLanguage(context, settingsProvider, 'en');
                                Navigator.pop(ctx);
                              },
                            ),
                            onTap: () {
                              _changeLanguage(context, settingsProvider, 'en');
                              Navigator.pop(ctx);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
                corBotao: AppColors.themeColor,
              );
            },
          ),
          const SizedBox(height: 16),
          // Alterar Senha
          _ConfiguracaoItem(
            titulo: l10n.changePasswordTitle,
                icone: Icons.lock_outline,
            descricao: l10n.changePasswordDesc,
            botaoTexto: l10n.changePasswordButton,
            onPressed: () => _alterarSenha(context),
            corBotao: AppColors.themeColor,
          ),
          const SizedBox(height: 16),
          // Recuperação de Acesso
          _ConfiguracaoItem(
            titulo: l10n.recoverAccessTitle,
                icone: Icons.key,
            descricao: l10n.recoverAccessDesc,
            botaoTexto: l10n.recoverAccessAction,
            onPressed: () => _recuperarAcesso(context),
            corBotao: AppColors.themeColor,
          ),
          const SizedBox(height: 16),
          // Limpar Exame Atual
          _ConfiguracaoItem(
            titulo: l10n.clearExamTitle,
                icone: Icons.cleaning_services,
            descricao: l10n.clearExamDesc,
            botaoTexto: l10n.clearExamButton,
            onPressed: () => _limparExame(context),
            corBotao: Colors.grey,
          ),
          const SizedBox(height: 16),

          const SizedBox(height: 16),
          // Sobre o Desenvolvedor
          _ConfiguracaoItem(
            titulo: l10n.drawerAbout,
                icone: Icons.info_outline,
            descricao: l10n.aboutPageTitle,
            botaoTexto: l10n.readMore,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SupportProjectPage()),
              );
            },
            corBotao: AppColors.themeColor,
          ),
          const SizedBox(height: 16),
          const NotificationHealthCard(),

          // Tamanho do texto
          Consumer<SettingsProvider>(
            builder: (context, settingsProvider, child) {
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.fontSizeTitle,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.fontSizeSubtitle,
                        style: const TextStyle(color: AppColors.secondaryText),
                      ),
                      Row(
                        children: [
                          const Text('A', style: TextStyle(fontSize: 14)),
                          Expanded(
                            child: Slider(
                              value: settingsProvider.textScale,
                              min: 0.85,
                              max: 1.6,
                              divisions: 5,
                              activeColor: AppColors.themeColor,
                              onChanged: settingsProvider.setTextScale,
                            ),
                          ),
                          const Text('A', style: TextStyle(fontSize: 26)),
                        ],
                      ),
                      Text(
                        l10n.fontSizeSample,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          // Santo Terço - Modo Tradicional
          Consumer<SettingsProvider>(
            builder: (context, settingsProvider, child) {
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                  SwitchListTile(
                    title: Text(
                      l10n.rosaryTraditionalToggle,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText,
                      ),
                    ),
                    value: settingsProvider.isTraditionalRosary,
                    onChanged: (value) {
                      settingsProvider.setTraditionalRosary(value);
                    },
                    activeColor: AppColors.themeColor,
                  ),
                  SwitchListTile(
                    title: Text(
                      l10n.rosaryHapticsToggle,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText,
                      ),
                    ),
                    subtitle: Text(l10n.rosaryHapticsSubtitle),
                    value: settingsProvider.hapticsEnabled,
                    onChanged: settingsProvider.setHapticsEnabled,
                    activeColor: AppColors.themeColor,
                  ),
                  ]),
                ),
              );
            },
          ),
          const SizedBox(height: 16),


          // Backup e Restauração
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    l10n.backupTitle,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.upload_file, color: AppColors.themeColor),
                    title: Text(l10n.backupExportTitle),
                    subtitle: Text(l10n.backupExportSubtitle),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () async {
                      final backupService = BackupService();
                      await backupService.exportData(context);
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.download, color: AppColors.themeColor),
                    title: Text(l10n.backupImportTitle),
                    subtitle: Text(l10n.backupImportSubtitle),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text(l10n.backupImportDialogTitle),
                          content: Text(l10n.backupImportDialogContent),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, false),
                              child: Text(l10n.cancelButton),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, true),
                              child: Text(l10n.backupImportConfirm, style: const TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true && context.mounted) {
                        final backupService = BackupService();
                        await backupService.importData(context);
                        
                        // Reload all providers to reflect imported data
                        if (context.mounted) {
                          final prayerProvider = Provider.of<PrayerProvider>(context, listen: false);
                          final confessionProvider = Provider.of<ConfessionProvider>(context, listen: false);
                          final settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
                          final appState = Provider.of<AppState>(context, listen: false);
                          
                          await Future.wait([
                            prayerProvider.loadData(),
                            confessionProvider.loadData(),
                            settingsProvider.loadSettings(),
                            appState.loadReminders(),
                          ]);
                          // Lembretes restaurados voltam a tocar neste aparelho
                          await appState.rescheduleAllReminders();
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          
          // Extra padding for bottom navigation
          const SizedBox(height: 100),

        ],
      ),
    );
  }
}

class _ConfiguracaoItem extends StatelessWidget {
  final String titulo;
  final String descricao;
  final String botaoTexto;
  final VoidCallback onPressed;
  final Color corBotao;
  final IconData icone;

  const _ConfiguracaoItem({
    required this.titulo,
    required this.descricao,
    required this.botaoTexto,
    required this.onPressed,
    required this.corBotao,
    this.icone = Icons.settings,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: appCardDecoration(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleIcon(icon: icone, color: AppColors.themeColor),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
                ),
                if (descricao.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    descricao,
                    style: const TextStyle(fontSize: 13, height: 1.35, color: AppColors.secondaryText),
                  ),
                ],
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: corBotao,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: Text(botaoTexto),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
