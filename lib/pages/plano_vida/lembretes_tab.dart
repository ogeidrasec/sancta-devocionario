import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/models/reminder_model.dart';
import 'package:sanctaconscientia/providers/app_state.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';
import 'package:sanctaconscientia/pages/plano_vida/widgets/reminder_card.dart';
import 'package:sanctaconscientia/pages/plano_vida/widgets/reminder_edit_dialog.dart';
import 'package:sanctaconscientia/pages/plano_vida_page.dart';
import 'package:sanctaconscientia/pages/plano_vida/widgets/reminder_statistics_widget.dart';
import 'package:sanctaconscientia/widgets/liturgical_settings_card.dart';
import 'package:sanctaconscientia/widgets/notification_health_card.dart';

/// Tab for managing all reminders/notifications
class LembretesTab extends StatefulWidget {
  const LembretesTab({super.key});

  @override
  State<LembretesTab> createState() => _LembretesTabState();
}

class _LembretesTabState extends State<LembretesTab> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadReminders();
  }

  Future<void> _loadReminders() async {
    setState(() => _isLoading = true);
    final appState = Provider.of<AppState>(context, listen: false);
    await appState.loadReminders();
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  /// "Novo lembrete": escolhe entre lembrar de uma oração (lista com busca) ou
  /// escrever um lembrete personalizado.
  Future<void> _chooseReminderType() async {
    final l10n = AppLocalizations.of(context)!;
    final choice = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.primaryBg,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.reminderChooserTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryText),
              ),
              const SizedBox(height: 16),
              _reminderChoice(ctx, 'prayer', Icons.favorite_border, AppColors.themeColor,
                  l10n.reminderChooserPrayerTitle, l10n.reminderChooserPrayerDesc),
              const SizedBox(height: 10),
              _reminderChoice(ctx, 'custom', Icons.edit_note, AppColors.accentGold,
                  l10n.reminderChooserCustomTitle, l10n.reminderChooserCustomDesc),
            ],
          ),
        ),
      ),
    );
    if (!mounted || choice == null) return;
    if (choice == 'prayer') {
      await PlanoVidaPage.showPrayerSelectionDialog(context, DateTime.now(), reminderMode: true);
    } else {
      await _addNewReminder();
    }
  }

  Widget _reminderChoice(BuildContext ctx, String value, IconData icon, Color color, String title, String desc) {
    return Container(
      decoration: appCardDecoration(tint: color),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () => Navigator.pop(ctx, value),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleIcon(icon: icon, color: color, size: 46),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryText)),
                      const SizedBox(height: 2),
                      Text(desc, style: const TextStyle(fontSize: 13, height: 1.3, color: AppColors.secondaryText)),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: color),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addNewReminder() async {
    final result = await showDialog<ReminderModel>(
      context: context,
      builder: (context) => const ReminderEditDialog(),
    );

    if (result != null) {
      if (!mounted) return;
      final appState = Provider.of<AppState>(context, listen: false);
      await appState.createReminder(result);
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.reminderCreatedMessage(result.title))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadReminders,
              child: Consumer<AppState>(
                builder: (context, appState, child) {
                  final grouped = appState.getGroupedReminders();
                  // Os avisos litúrgicos têm cartão próprio embaixo; aqui ficam os lembretes do usuário
                  final groups = <(String, List<ReminderModel>)>[
                    (l10n.remindersGroupPrayers, grouped[ReminderType.prayer] ?? []),
                    (l10n.remindersGroupNovenas, grouped[ReminderType.novena] ?? []),
                    (l10n.remindersGroupExaminations, grouped[ReminderType.examination] ?? []),
                    (l10n.remindersGroupRosaries, grouped[ReminderType.rosary] ?? []),
                    (l10n.remindersGroupConfession, grouped[ReminderType.confession] ?? []),
                    (
                      l10n.remindersGroupOthers,
                      (grouped[ReminderType.custom] ?? []).where((r) => !r.id.startsWith('liturgical_')).toList(),
                    ),
                  ];
                  final hasUserReminders = groups.any((g) => g.$2.isNotEmpty);

                  return ListView(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
                    children: [
                      // aviso só aparece se as notificações estiverem bloqueadas
                      const NotificationHealthCard(onlyWhenProblem: true),
                      const ReminderStatisticsWidget(),
                      const SizedBox(height: 20),
                      SectionLabel(l10n.remindersYourTitle),
                      if (!hasUserReminders)
                        _buildEmptyHint()
                      else
                        for (final g in groups) _buildGroupSection(context, g.$1, g.$2),
                      const SizedBox(height: 12),
                      SectionLabel(l10n.remindersChurchTitle),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4, 0, 4, 10),
                        child: Text(
                          l10n.remindersChurchSubtitle,
                          style: const TextStyle(fontSize: 13, height: 1.35, color: AppColors.secondaryText),
                        ),
                      ),
                      const LiturgicalSettingsCard(),
                    ],
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _chooseReminderType,
        backgroundColor: AppColors.accentGold,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(l10n.remindersAddButton, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildEmptyHint() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: appCardDecoration(tint: AppColors.accentGold, radius: 20),
      child: Row(
        children: [
          const CircleIcon(icon: Icons.notifications_none, color: AppColors.accentGold),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.remindersEmptyTitle,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryText),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.remindersEmptySubtitle,
                  style: const TextStyle(fontSize: 13, height: 1.35, color: AppColors.secondaryText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Grupo de lembretes (Orações, Novenas…) com subtítulo e contagem.
  Widget _buildGroupSection(BuildContext context, String title, List<ReminderModel> reminders) {
    if (reminders.isEmpty) return const SizedBox.shrink();
    final label = toBeginningOfSentenceCase(title.toLowerCase());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 6, 4, 8),
          child: Row(
            children: [
              Text(
                '$label · ${reminders.length}',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primaryText),
              ),
              const Expanded(child: Divider(indent: 12)),
            ],
          ),
        ),
        ...reminders.map((reminder) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ReminderCard(reminder: reminder),
            )),
        const SizedBox(height: 6),
      ],
    );
  }
}
