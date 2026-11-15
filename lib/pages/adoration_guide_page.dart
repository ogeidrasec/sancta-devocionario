import 'package:flutter/material.dart';
import 'package:sanctaconscientia/data/prayer_data.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/pages/prayer_detail_page.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';

/// Guia para uma hora de Adoração Eucarística, com atalhos para as orações.
class AdorationGuidePage extends StatelessWidget {
  const AdorationGuidePage({super.key});

  static const _color = Color(0xFF6A1B9A);
  // Orações do catálogo sugeridas durante a adoração
  static const _prayerIds = ['theological_acts', 'anima_christi', 'spiritual_communion', 'tantum_ergo'];

  void _open(BuildContext context, Map<String, dynamic> prayer) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PrayerDetailPage(
          title: prayer['title'] as String,
          content: prayer['content'] as String,
          contentLatin: prayer['contentLatin'] as String?,
          prayerId: prayer['id'] as String?,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final prayers = [
      for (final id in _prayerIds)
        if (PrayerData.getPrayerById(context, id) != null) PrayerData.getPrayerById(context, id)!,
    ];

    final steps = [
      (l10n.adorationStep1Title, l10n.adorationStep1Body, Icons.door_front_door_outlined, false),
      (l10n.adorationStep2Title, l10n.adorationStep2Body, Icons.volume_off_outlined, false),
      (l10n.adorationStep3Title, l10n.adorationStep3Body, Icons.favorite_border, true),
      (l10n.adorationStep4Title, l10n.adorationStep4Body, Icons.chat_bubble_outline, false),
      (l10n.adorationStep5Title, l10n.adorationStep5Body, Icons.wb_sunny_outlined, false),
    ];

    return InnerPageScaffold(
      title: l10n.adorationTitle,
      subtitle: l10n.adorationSubtitle,
      color: _color,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          for (final s in steps) ...[
            Container(
              padding: const EdgeInsets.all(18),
              decoration: appCardDecoration(tint: _color),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleIcon(icon: s.$3, color: _color, size: 40),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          s.$1,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryText,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(s.$2, style: const TextStyle(fontSize: 15, height: 1.5, color: AppColors.primaryText)),
                  if (s.$4)
                    for (final p in prayers)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Material(
                          color: _color.withValues(alpha: 0.07),
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () => _open(context, p),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      p['title'] as String,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryText,
                                      ),
                                    ),
                                  ),
                                  const Icon(Icons.chevron_right, color: _color),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}
