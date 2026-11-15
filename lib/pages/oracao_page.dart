import 'package:flutter/material.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';

/// Oração antes do exame de consciência.
class OracaoPage extends StatelessWidget {
  const OracaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return InnerPageScaffold(
      title: l10n.preparatoryPrayerTitle,
      subtitle: l10n.preparatoryPrayerSubtitle,
      card: true,
      bottom: PillButton(
        label: l10n.backButton,
        color: AppColors.accentGold,
        onPressed: () => Navigator.pop(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.preparatoryPrayerContent,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 19,
              height: 1.7,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              l10n.preparatoryPrayerSource,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: AppColors.secondaryText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
