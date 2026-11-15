import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/widgets/step_flow.dart';

/// Roteiro de 8 passos para resistir às tentações.
class LutaTentacoesPage extends StatelessWidget {
  final String? prayerId;
  const LutaTentacoesPage({super.key, this.prayerId});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final steps = [
      StepData(icon: Icons.visibility, title: l10n.temptationStep1Title, description: l10n.temptationStep1Desc, prayer: l10n.temptationStep1Prayer),
      StepData(icon: Icons.flash_on, title: l10n.temptationStep2Title, description: l10n.temptationStep2Desc, prayer: l10n.temptationStep2Prayer),
      StepData(icon: Icons.shield, title: l10n.temptationStep3Title, description: l10n.temptationStep3Desc, prayer: l10n.temptationStep3Prayer),
      StepData(icon: Icons.favorite, title: l10n.temptationStep4Title, description: l10n.temptationStep4Desc, prayer: l10n.temptationStep4Prayer),
      StepData(icon: Icons.directions_run, title: l10n.temptationStep5Title, description: l10n.temptationStep5Desc, prayer: l10n.temptationStep5Prayer),
      StepData(icon: Icons.swap_horiz, title: l10n.temptationStep6Title, description: l10n.temptationStep6Desc, prayer: l10n.temptationStep6Prayer),
      StepData(icon: Icons.lightbulb, title: l10n.temptationStep7Title, description: l10n.temptationStep7Desc, prayer: l10n.temptationStep7Prayer),
      StepData(icon: Icons.volunteer_activism, title: l10n.temptationStep8Title, description: l10n.temptationStep8Desc, prayer: l10n.temptationStep8Prayer),
    ];

    return StepFlowPage(
      title: l10n.temptationFightTitle,
      color: const Color(0xFFB71C1C),
      steps: steps,
      prayerLabel: l10n.temptationPrayerLabel,
      nextLabel: l10n.nextButton,
      finishLabel: l10n.finishButton,
      onFinish: () {
        // Sempre registra (mesmo sem vir do plano) e nunca desfaz ao repetir.
        context.read<PrayerProvider>().markPrayerDoneToday(
              prayerId ?? 'luta_tentacoes',
              l10n.temptationFightTitle,
            );
        Navigator.pop(context);
      },
    );
  }
}
