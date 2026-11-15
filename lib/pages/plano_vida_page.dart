import 'package:sanctaconscientia/utils/date_text.dart';
import 'package:flutter/material.dart';
import 'package:sanctaconscientia/widgets/add_prayer_sheet.dart';
import 'package:sanctaconscientia/widgets/app_tour.dart';

import 'package:provider/provider.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import '../providers/prayer_provider.dart';

import 'plano_vida/hoje_tab.dart';
import 'plano_vida/historico_tab.dart';
import 'plano_vida/lembretes_tab.dart';

import 'package:sanctaconscientia/widgets/app_drawer.dart';

/// Jardim da Alma - Prayer Plan Page
/// 
/// Structure:
/// - Tab 1: Hoje (Today) - Daily prayers and quick actions
/// - Tab 2: Histórico (History) - Calendar, stats, and confession history
/// - Tab 3: Meu Plano (My Plan) - Settings and configuration
class PlanoVidaPage extends StatelessWidget {
  const PlanoVidaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Hoje, Histórico, Lembretes
      child: Scaffold(
        drawer: const AppDrawer(),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [

            SliverAppBar(
              expandedHeight: 120.0,
              floating: false,
              pinned: true,
              backgroundColor: AppColors.primaryText,
              // ícone do menu em branco: o padrão era escuro sobre a foto
              iconTheme: const IconThemeData(color: Colors.white),
              leading: Builder(
                builder: (context) => IconButton(
                  key: AppTourKeys.menu,
                  icon: const Icon(Icons.menu, color: Colors.white),
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(

                centerTitle: true,
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'lib/imgs/jardim_page.webp',
                      fit: BoxFit.cover,
                      cacheWidth: 900,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.75),
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              bottom: TabBar(
                labelColor: AppColors.accentGold,
                unselectedLabelColor: Colors.white,
                indicatorColor: AppColors.accentGold,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
                indicatorWeight: 3,
                dividerColor: Colors.transparent,
                tabs: [
                  Tab(key: AppTourKeys.tabToday, text: AppLocalizations.of(context)!.tabToday, icon: const Icon(Icons.wb_sunny_outlined)),
                  Tab(key: AppTourKeys.tabCalendar, text: AppLocalizations.of(context)!.tabCalendar, icon: const Icon(Icons.calendar_month)),
                  Tab(key: AppTourKeys.tabReminders, text: AppLocalizations.of(context)!.tabReminders, icon: const Icon(Icons.notifications_active)),
                ],
              ),
            ),
          ],
          body: const TabBarView(
            children: [
              HojeTab(),
              HistoricoTab(),
              LembretesTab(),
            ],
          ),
        ),
      ),
    );
  }

  /// Abre a folha para adicionar uma oração, novena ou terço (veja [AddPrayerSheet]).
  static Future<void> showPrayerSelectionDialog(BuildContext context, DateTime date, {bool reminderMode = false}) {
    return AddPrayerSheet.show(context, date, reminderMode: reminderMode);
  }

  /// Shows scheduling dialog then adds prayer to plan
  static Future<void> addPrayerToPlan(BuildContext context, Map<String, dynamic> prayer, DateTime date, {bool reminderRequired = false}) async {
    final prayerProvider = Provider.of<PrayerProvider>(context, listen: false);
    final prayerId = prayer['id'] as String? ?? 'custom_${DateTime.now().millisecondsSinceEpoch}';
    final isNovena = (prayer['id'] as String?)?.startsWith('novena') ?? false;
    final isPastDate = date.isBefore(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));
    
    // For past dates, just log as completed (no scheduling)
    if (isPastDate) {
      prayerProvider.logPrayer(
        prayer['title'] as String,
        date,
        prayerId: prayerId,
      );
      final l10nInner = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10nInner.prayerLoggedMessage(prayer['title'] as String, fmtDayMonth(context, date)))),
      );
      return;
    }
    
    // Show scheduling dialog for today or future
    final result = await _showSchedulingDialog(
      context, 
      prayer['title'] as String,
      isNovena: isNovena,
      reminderRequired: reminderRequired,
    );
    
    if (result == null) return; // User cancelled
    
    // Nota: Não verificamos mais duplicatas aqui pois addPrayer agora gera
    // IDs únicos com timestamp, permitindo a mesma oração em horários diferentes.
    

    // Usar o período do dia selecionado no diálogo
    final timePeriod = result['timePeriod'] as String? ?? 'anytime';
    
    // Add to available prayers with scheduling info
    final newPrayerId = await prayerProvider.addPrayer(
      prayer['title'] as String,
      prayerId: prayerId,
      prayerType: prayer['prayerType'] as String?,
      time: timePeriod,
    );
    
    // If it's a Novena, start it officially/track progress FIRST
    // This ensures that if we set a reminder next, the provider knows it's an active novena
    if (isNovena) {
      await prayerProvider.startNovena(
        prayerId,
        startDate: date,
        reminderTime: result['time'] as TimeOfDay?,
        title: prayer['title'] as String?, // Pass localized title
      );
    }

    // Schedule notification/Save metadata
    // NOTA: Novenas NÃO devem ser agendadas aqui — startNovena() já cria o reminder.
    // Agendar aqui também causaria notificações duplicadas com IDs diferentes.
    final hasReminder = result['hasReminder'] as bool? ?? false;
    if (hasReminder && result['time'] != null && !isNovena) {
      final time = result['time'] as TimeOfDay;
      await prayerProvider.setPrayerReminder(
        newPrayerId,
        time,
        frequency: result['recurrence'] as String? ?? 'once',
        date: date,
        title: prayer['title'] as String?,
      );
    }
    
    if (context.mounted) {
      final l10nInner = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10nInner.prayerAddedToPlanMessage(prayer['title'] as String))),
      );
    }
  }

  /// Logs a quick prayer without adding to plan or setting reminders
  static void logQuickPrayer(BuildContext context, Map<String, dynamic> prayer) {
    final prayerProvider = Provider.of<PrayerProvider>(context, listen: false);
    final prayerId = prayer['id'] as String? ?? 'custom_${DateTime.now().millisecondsSinceEpoch}';
    
    // Just log the prayer as completed now
    prayerProvider.logPrayer(
      prayer['title'] as String,
      DateTime.now(),
      prayerId: prayerId,
      prayerType: prayer['prayerType'] as String?,
    );
    
    if (context.mounted) {
      final l10nInner = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10nInner.quickPrayerLogged(prayer['title'] as String))),
      );
    }
  }

  /// Shows dialog to configure scheduling (time period and optional reminder)
  static Future<Map<String, dynamic>?> _showSchedulingDialog(
    BuildContext context,
    String prayerTitle,
    {bool isNovena = false, bool reminderRequired = false}
  ) async {
    String timePeriod = 'anytime'; // morning, noon, night, anytime
    bool hasReminder = reminderRequired;
    TimeOfDay? selectedTime;

    // Horário sugerido para o lembrete, conforme o período do dia escolhido
    TimeOfDay suggestedTime(String period) => switch (period) {
          'morning' => const TimeOfDay(hour: 7, minute: 0),
          'noon' => const TimeOfDay(hour: 12, minute: 0),
          'night' => const TimeOfDay(hour: 21, minute: 0),
          _ => const TimeOfDay(hour: 9, minute: 0),
        };
    String recurrence = 'daily'; // daily, weekly, once

    return await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          final l10n = AppLocalizations.of(context)!;
          return AlertDialog(
            title: Text(l10n.scheduleDialogTitle(prayerTitle)),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Seção 1: Período do dia
                  Text(l10n.timePeriodLabel, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ChoiceChip(
                        label: Text(l10n.timeMorning),
                        selected: timePeriod == 'morning',
                        onSelected: (selected) => setState(() => timePeriod = 'morning'),
                        selectedColor: AppColors.accentGold.withValues(alpha: 0.3),
                      ),
                      ChoiceChip(
                        label: Text(l10n.timeNoon),
                        selected: timePeriod == 'noon',
                        onSelected: (selected) => setState(() => timePeriod = 'noon'),
                        selectedColor: AppColors.accentGold.withValues(alpha: 0.3),
                      ),
                      ChoiceChip(
                        label: Text(l10n.timeNight),
                        selected: timePeriod == 'night',
                        onSelected: (selected) => setState(() => timePeriod = 'night'),
                        selectedColor: AppColors.accentGold.withValues(alpha: 0.3),
                      ),
                      ChoiceChip(
                        label: Text(l10n.timeAnytime),
                        selected: timePeriod == 'anytime',
                        onSelected: (selected) => setState(() => timePeriod = 'anytime'),
                        selectedColor: AppColors.accentGold.withValues(alpha: 0.3),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 12),
                  
                  // Seção 2: Lembrete (opcional)
                  Row(
                    children: [
                      Checkbox(
                        value: hasReminder,
                        onChanged: reminderRequired
                            ? null // no modo lembrete o lembrete é obrigatório
                            : (value) => setState(() {
                                  hasReminder = value ?? false;
                                  if (hasReminder) selectedTime ??= suggestedTime(timePeriod);
                                }),
                        activeColor: AppColors.themeColor,
                      ),
                      Expanded(
                        child: Text(l10n.enableReminderLabel, style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  
                  if (hasReminder) ...[
                    const SizedBox(height: 8),
                    ListTile(
                      title: Text((selectedTime ?? suggestedTime(timePeriod)).format(context)),
                      leading: const Icon(Icons.access_time),
                      tileColor: Colors.grey.shade100,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null) {
                          setState(() => selectedTime = time);
                        }
                      },
                    ),
                    if (!isNovena) ...[
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        initialValue: recurrence,
                        decoration: InputDecoration(
                          labelText: l10n.frequencyLabel,
                          border: const OutlineInputBorder(),
                        ),
                        items: [
                          DropdownMenuItem(value: 'daily', child: Text(l10n.frequencyDaily)),
                          DropdownMenuItem(value: 'weekly', child: Text(l10n.frequencyWeekly)),
                          DropdownMenuItem(value: 'once', child: Text(l10n.frequencyOnce)),
                        ],
                        onChanged: (value) => setState(() => recurrence = value!),
                      ),
                    ],
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.cancel),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, {
                  'timePeriod': timePeriod,
                  'hasReminder': hasReminder,
                  'time': hasReminder ? (selectedTime ?? suggestedTime(timePeriod)) : null,
                  'recurrence': recurrence,
                }),
                child: Text(l10n.confirm),
              ),
            ],
          );
        },
      ),
    );
  }



}
