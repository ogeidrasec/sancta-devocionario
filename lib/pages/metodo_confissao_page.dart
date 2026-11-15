import 'package:flutter/material.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';

/// Passo a passo de como se confessar.
class MetodoConfissaoPage extends StatelessWidget {
  const MetodoConfissaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return InnerPageScaffold(
      title: l10n.confessionMethodTitle,
      card: true,
      bottom: PillButton(
        label: l10n.backButton,
        color: AppColors.accentGold,
        onPressed: () => Navigator.pop(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Step(number: 1, heading: l10n.confessionMethodStep1, body: l10n.reportBlessMe),
          _Step(number: 2, heading: l10n.confessionMethodStep3, body: l10n.confessionMethodStep3Content),
          _Step(number: 3, heading: l10n.confessionMethodStep4, body: l10n.reportFinalPrayer),
          _Step(number: 4, heading: l10n.confessionMethodStep5, body: l10n.reportActOfContrition),
          // "... ou ..." entre as duas formas do ato de contrição
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Text(
                l10n.confessionMethodOr,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.themeColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 44, bottom: 24),
            child: Text(
              l10n.confessionMethodAltPrayer,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 17,
                height: 1.6,
                color: AppColors.primaryText,
              ),
            ),
          ),
          _Step(number: 5, heading: l10n.confessionMethodStep6, body: null),
        ],
      ),
    );
  }
}

/// Um passo numerado: círculo com o número, título em destaque e o texto.
class _Step extends StatelessWidget {
  final int number;
  final String heading;
  final String? body;

  const _Step({required this.number, required this.heading, required this.body});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.themeColor,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$number',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    heading,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      height: 1.35,
                      color: AppColors.themeColor,
                    ),
                  ),
                ),
                if (body != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    body!,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 17,
                      height: 1.6,
                      color: AppColors.primaryText,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
