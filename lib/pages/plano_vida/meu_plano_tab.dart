import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/providers/confession_provider.dart';
import 'package:sanctaconscientia/providers/settings_provider.dart';
import '../plano_vida_page.dart';
import 'package:sanctaconscientia/data/prayer_data.dart';
import 'package:sanctaconscientia/data/novena_data.dart';

class MeuPlanoTab extends StatelessWidget {
  const MeuPlanoTab({super.key});

  @override
  Widget build(BuildContext context) {
    final prayerProvider = Provider.of<PrayerProvider>(context);
    final confessionProvider = Provider.of<ConfessionProvider>(context);
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Prayer Level Section
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.trending_up, color: AppColors.themeColor),
                      const SizedBox(width: 8),
                      Text(AppLocalizations.of(context)!.prayerLevelLabel, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(AppLocalizations.of(context)!.currentLevelLabel(settingsProvider.prayerLevel), style: const TextStyle(fontSize: 14, color: Colors.grey)),
                  const SizedBox(height: 8),
                  Slider(
                    value: settingsProvider.prayerLevel.toDouble(),
                    min: 1,
                    max: 4,
                    divisions: 3,
                    label: 'Nível ${settingsProvider.prayerLevel}',
                    activeColor: AppColors.themeColor,
                    onChanged: (value) {
                      settingsProvider.setPrayerLevel(value.toInt());
                    },
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _getLevelDescription(context, settingsProvider.prayerLevel),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Active Prayers Section
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.checklist, color: AppColors.accentGold),
                      const SizedBox(width: 8),
                      Text(AppLocalizations.of(context)!.activePrayersLabel, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (prayerProvider.availablePrayers.isEmpty)
                    Text(AppLocalizations.of(context)!.noPrayersConfigured, style: const TextStyle(color: Colors.grey))
                  else
                    ...prayerProvider.availablePrayers.map((prayer) {
                      final prayerData = PrayerData.getPrayerById(context, prayer['id']!);
                      final displayTitle = prayerData?['title'] ?? prayer['title']!;
                      return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.check_circle, color: AppColors.themeColor, size: 20),
                      title: Text(displayTitle),
                      subtitle: Text(_getTimeLabel(context, prayer['defaultTime'])),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                        onPressed: () => prayerProvider.removePrayer(prayer['id']!),
                      ),
                    );
                    }),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: () => PlanoVidaPage.showPrayerSelectionDialog(context, DateTime.now()),
                    icon: const Icon(Icons.add),
                    label: Text(AppLocalizations.of(context)!.addPrayerToPlanLabel),
                    style: OutlinedButton.styleFrom(foregroundColor: AppColors.themeColor),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Confession Settings
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.favorite, color: Colors.purple),
                      SizedBox(width: 8),
                      Text(AppLocalizations.of(context)!.confessionTitle, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.event, color: Colors.purple),
                      title: Text(AppLocalizations.of(context)!.confessionNextLabel),
                      subtitle: Text(
                        confessionProvider.nextConfessionDate != null
                            ? DateFormat('dd/MM/yyyy').format(confessionProvider.nextConfessionDate!)
                            : AppLocalizations.of(context)!.confessionNotScheduled,
                      ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit, color: AppColors.accentGold),
                      onPressed: () => _scheduleConfession(context, confessionProvider),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.check_circle, color: Colors.green),
                    title: Text(AppLocalizations.of(context)!.confessionRegisterLabel),
                    subtitle: Text(AppLocalizations.of(context)!.confessionRegisterSubtitle),
                    onTap: () {
                      confessionProvider.confirmarConfissao();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(AppLocalizations.of(context)!.confessionRegisteredMessage)),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Active Novenas
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.brightness_1, color: Colors.amber),
                      SizedBox(width: 8),
                      Text(AppLocalizations.of(context)!.activeNovenasTitle, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (prayerProvider.activeNovenas.isEmpty)
                    Text(AppLocalizations.of(context)!.activeNovenasEmpty, style: const TextStyle(color: Colors.grey))
                  else
                    ...prayerProvider.activeNovenas.entries.map((entry) {
                      final day = prayerProvider.getNovenaDay(entry.key);
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.brightness_1, color: Colors.amber, size: 20),
                        title: Text(_getNovenaTitle(context, entry.key)),
                        subtitle: Text(AppLocalizations.of(context)!.novenaDayProgress(day, 9)),
                        trailing: IconButton(
                          icon: const Icon(Icons.cancel_outlined, color: Colors.red),
                          onPressed: () => prayerProvider.cancelNovena(entry.key),
                        ),
                      );
                    }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getLevelDescription(BuildContext context, int level) {
    switch (level) {
      case 1: return AppLocalizations.of(context)!.prayerLevel1Description;
      case 2: return AppLocalizations.of(context)!.prayerLevel2Description;
      case 3: return AppLocalizations.of(context)!.prayerLevel3Description;
      case 4: return AppLocalizations.of(context)!.prayerLevel4Description;
      default: return '';
    }
  }

  String _getTimeLabel(BuildContext context, String? time) {
    switch (time) {
      case 'morning': return AppLocalizations.of(context)!.prayerTimeDescriptionMorning;
      case 'noon': return AppLocalizations.of(context)!.prayerTimeDescriptionNoon;
      case 'night': return AppLocalizations.of(context)!.prayerTimeDescriptionNight;
      case 'anytime': return AppLocalizations.of(context)!.prayerTimeDescriptionAnytime;
      default: return AppLocalizations.of(context)!.prayerTimeDescriptionDefault;
    }
  }

  String _getNovenaTitle(BuildContext context, String novenaId) {
    try {
      return NovenaData.getNovenaById(context, novenaId).title;
    } catch (_) {
      return novenaId;
    }
  }

  Future<void> _scheduleConfession(BuildContext context, ConfessionProvider confessionProvider) async {
    final now = DateTime.now();
    final initialDate = confessionProvider.nextConfessionDate ?? now;
    final validInitialDate = initialDate.isBefore(now) ? now : initialDate;

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: validInitialDate,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.themeColor,
              onPrimary: Colors.white,
              onSurface: AppColors.primaryText,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      confessionProvider.setNextConfessionDate(pickedDate);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.confessionScheduledMessage(DateFormat('dd/MM/yyyy').format(pickedDate)))),
        );
      }
    }
  }
}
