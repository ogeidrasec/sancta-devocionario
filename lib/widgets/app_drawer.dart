import 'package:flutter/material.dart';
import 'package:sanctaconscientia/utils/app_images.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/pages/configuracoes_page.dart';
import 'package:sanctaconscientia/pages/spiritual_growth_page.dart';
import 'package:sanctaconscientia/pages/support_project_page.dart';
import 'package:sanctaconscientia/pages/main_scaffold.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Drawer(
      backgroundColor: AppColors.primaryBg,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Cabeçalho com altura livre: o nome do app pode quebrar em duas linhas
          Container(
            padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top + 24, 16, 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.themeColor,
                  Color.lerp(AppColors.themeColor, Colors.black, 0.45)!,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // A imagem tem fundo próprio (azul): vai com as cores originais,
                // ampliada para o ornamento preencher o círculo.
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withValues(alpha: 0.35), width: 1.5),
                  ),
                  child: ClipOval(
                    child: Transform.scale(
                      scale: 1.8,
                      child: Image.asset(AppImages.icon, fit: BoxFit.cover),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.appTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          ListTile(
            key: const ValueKey('drawer_growth'),
            leading: const CircleIcon(icon: Icons.emoji_events_outlined, color: Color(0xFFB7791F), size: 40),
            title: Text(l10n.drawerGrowth, style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(l10n.drawerGrowthDesc),
            onTap: () {
              Navigator.pop(context); // Close drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SpiritualGrowthPage()),
              );
            },
          ),
          ListTile(
            leading: const CircleIcon(icon: Icons.info_outline, color: AppColors.themeColor, size: 40),
            title: Text(l10n.drawerAbout, style: const TextStyle(fontWeight: FontWeight.w600)),
            onTap: () {
              Navigator.pop(context); // Close drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SupportProjectPage()),
              );
            },
          ),
          ListTile(
            key: const ValueKey('drawer_tour'),
            leading: const CircleIcon(icon: Icons.explore_outlined, color: AppColors.themeColor, size: 40),
            title: Text(l10n.drawerTour, style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(l10n.drawerTourDesc),
            onTap: () {
              final main = MainScaffold.of(context);
              Navigator.pop(context); // fecha o menu
              main?.startTour();
            },
          ),
          ListTile(
            leading: const CircleIcon(icon: Icons.settings_outlined, color: AppColors.themeColor, size: 40),
            title: Text(l10n.drawerSettings, style: const TextStyle(fontWeight: FontWeight.w600)),
            onTap: () {
              Navigator.pop(context); // Close drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ConfiguracoesPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
