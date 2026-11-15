import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/widgets/step_flow.dart';

/// Exame de consciência diário, em 5 passos.
class ExameDiarioPage extends StatelessWidget {
  final String? prayerId;
  const ExameDiarioPage({super.key, this.prayerId});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final steps = [
      StepData(title: l10n.dailyExamStep1Title, description: l10n.dailyExamStep1Desc, prayer: l10n.dailyExamStep1Prayer),
      StepData(title: l10n.dailyExamStep2Title, description: l10n.dailyExamStep2Desc, prayer: l10n.dailyExamStep2Prayer),
      StepData(title: l10n.dailyExamStep3Title, description: l10n.dailyExamStep3Desc, prayer: l10n.dailyExamStep3Prayer),
      StepData(title: l10n.dailyExamStep4Title, description: l10n.dailyExamStep4Desc, prayer: l10n.dailyExamStep4Prayer),
      StepData(title: l10n.dailyExamStep5Title, description: l10n.dailyExamStep5Desc, prayer: l10n.dailyExamStep5Prayer),
    ];

    return StepFlowPage(
      title: l10n.dailyExamTitle,
      steps: steps,
      prayerLabel: l10n.dailyExamPrayerLabel,
      nextLabel: l10n.nextButton,
      finishLabel: l10n.finishButton,
      onFinish: () {
        // Sempre registra (mesmo sem vir do plano) e nunca desfaz ao repetir.
        context.read<PrayerProvider>().markPrayerDoneToday(
              prayerId ?? 'daily_examination',
              l10n.dailyExamTitle,
            );
        Navigator.pop(context);
      },
    );
  }
}
