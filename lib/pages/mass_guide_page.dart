import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/providers/settings_provider.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';

/// Guia da Missa: as partes da celebração e as respostas do povo, na forma
/// ordinária (português) ou na tradicional (latim). A escolha fica salva.
class MassGuidePage extends StatelessWidget {
  const MassGuidePage({super.key});

  static const _ordinaryColor = Color(0xFFB7791F);
  static const _traditionalColor = Color(0xFF7B1E2E);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final settings = Provider.of<SettingsProvider>(context);
    final traditional = settings.massGuideTraditional;
    final color = traditional ? _traditionalColor : _ordinaryColor;

    final tips = traditional
        ? (l10n.massGuideTradTipsTitle, l10n.massGuideTradTipsBody)
        : (l10n.massGuideTipsTitle, l10n.massGuideTipsBody);
    final parts = traditional
        ? [
            (l10n.massGuideTradPart1Title, l10n.massGuideTradPart1Body, Icons.stairs_outlined),
            (l10n.massGuideTradPart2Title, l10n.massGuideTradPart2Body, Icons.music_note),
            (l10n.massGuideTradPart3Title, l10n.massGuideTradPart3Body, Icons.menu_book),
            (l10n.massGuideTradPart4Title, l10n.massGuideTradPart4Body, Icons.volunteer_activism),
            (l10n.massGuideTradPart5Title, l10n.massGuideTradPart5Body, Icons.church),
            (l10n.massGuideTradPart6Title, l10n.massGuideTradPart6Body, Icons.brightness_7),
            (l10n.massGuideTradPart7Title, l10n.massGuideTradPart7Body, Icons.wb_sunny_outlined),
          ]
        : [
            (l10n.massGuidePart1Title, l10n.massGuidePart1Body, Icons.login),
            (l10n.massGuidePart2Title, l10n.massGuidePart2Body, Icons.menu_book),
            (l10n.massGuidePart3Title, l10n.massGuidePart3Body, Icons.church),
            (l10n.massGuidePart4Title, l10n.massGuidePart4Body, Icons.wb_sunny_outlined),
          ];

    return InnerPageScaffold(
      title: l10n.massGuideTitle,
      subtitle: traditional ? l10n.massGuideTradSubtitle : l10n.massGuideSubtitle,
      color: color,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          SectionLabel(l10n.massGuideFormTitle),
          _FormChoice(
            selected: !traditional,
            color: _ordinaryColor,
            icon: Icons.groups_outlined,
            title: l10n.massGuideFormOrdinary,
            description: l10n.massGuideFormOrdinaryDesc,
            onTap: () => settings.setMassGuideTraditional(false),
          ),
          const SizedBox(height: 8),
          _FormChoice(
            selected: traditional,
            color: _traditionalColor,
            icon: Icons.account_balance_outlined,
            title: l10n.massGuideFormTraditional,
            description: l10n.massGuideFormTraditionalDesc,
            onTap: () => settings.setMassGuideTraditional(true),
          ),
          const SizedBox(height: 16),
          _GuideCard(icon: Icons.info_outline, color: color, title: tips.$1, body: tips.$2),
          const SizedBox(height: 12),
          for (final p in parts) ...[
            _GuideCard(icon: p.$3, color: AppColors.themeColor, title: p.$1, body: p.$2),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

/// Opção de forma da Missa (uma de duas, marcada com o círculo à direita).
class _FormChoice extends StatelessWidget {
  final bool selected;
  final Color color;
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _FormChoice({
    required this.selected,
    required this.color,
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      child: Container(
        decoration: appCardDecoration(tint: color).copyWith(
          border: Border.all(color: color.withValues(alpha: selected ? 0.9 : 0.15), width: selected ? 2 : 1),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  CircleIcon(icon: icon, color: color, size: 44),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryText),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          description,
                          style: const TextStyle(fontSize: 13, height: 1.3, color: AppColors.secondaryText),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(selected ? Icons.check_circle : Icons.circle_outlined, color: selected ? color : Colors.grey),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Cartão de seção usado pelos guias. Linhas que começam com "» " são latim e
/// aparecem destacadas (itálico, cor do tema).
class _GuideCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String body;

  const _GuideCard({required this.icon, required this.color, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    final lines = body.split('\n');
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: appCardDecoration(tint: color),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleIcon(icon: icon, color: color, size: 40),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.primaryText),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (final line in lines)
            if (line.isEmpty)
              const SizedBox(height: 8)
            else if (line.startsWith('» '))
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(
                  line.substring(2),
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.45,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    color: Color.lerp(color, Colors.black, 0.2),
                  ),
                ),
              )
            else
              Text(line, style: const TextStyle(fontSize: 15, height: 1.5, color: AppColors.primaryText)),
        ],
      ),
    );
  }
}
