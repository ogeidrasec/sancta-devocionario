import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';

/// Leitura de uma oração, com o botão para registrá-la como rezada.
class PrayerDetailPage extends StatelessWidget {
  final String title;
  final String content;
  final String? prayerId;
  final String? contentLatin;

  const PrayerDetailPage({
    super.key,
    required this.title,
    required this.content,
    this.prayerId,
    this.contentLatin,
  });

  void _finish(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final prayerProvider = Provider.of<PrayerProvider>(context, listen: false);

    if (prayerId != null) {
      // Marca no plano do dia (respeita o horário) ou registra direto
      prayerProvider.completePrayerByTitle(title, prayerId!);
    } else {
      prayerProvider.logPrayer(title, DateTime.now());
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.prayerRegisteredMessage(title))),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return InnerPageScaffold(
      title: title,
      card: true,
      bottom: PillButton(
        label: l10n.finishPrayerButton,
        icon: Icons.check_circle_outline,
        onPressed: () => _finish(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 19,
              height: 1.7,
              color: AppColors.primaryText,
            ),
          ),
          if (contentLatin != null) ...[
            const SizedBox(height: 24),
            Divider(color: AppColors.accentGold.withValues(alpha: 0.4)),
            const SizedBox(height: 16),
            Text(
              contentLatin!,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18,
                height: 1.7,
                fontStyle: FontStyle.italic,
                color: AppColors.primaryText.withValues(alpha: 0.85),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
