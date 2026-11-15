import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/providers/liturgical_provider.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';

/// Avisos do calendário litúrgico (domingos e dias santos, jejum, abstinência)
/// e o horário em que tocam.
class LiturgicalSettingsCard extends StatelessWidget {
  const LiturgicalSettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    Widget item(IconData icon, String title, String subtitle, bool value, ValueChanged<bool> onChanged) => SwitchListTile(
          secondary: CircleIcon(icon: icon, color: AppColors.themeColor, size: 40),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.primaryText)),
          subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.secondaryText)),
          value: value,
          onChanged: onChanged,
          contentPadding: const EdgeInsets.symmetric(horizontal: 6),
        );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: appCardDecoration(radius: 20),
      child: Consumer<LiturgicalProvider>(
        builder: (context, liturgical, child) => Column(
          children: [
            item(Icons.church, l10n.notifyPreceptTitle, l10n.notifyPreceptSubtitle, liturgical.notifyPrecept,
                (v) => liturgical.setNotifyPrecept(v)),
            const Divider(height: 1),
            item(Icons.restaurant_menu, l10n.notifyFastingTitle, l10n.notifyFastingSubtitle, liturgical.notifyFasting,
                (v) => liturgical.setNotifyFasting(v)),
            const Divider(height: 1),
            item(Icons.restaurant, l10n.notifyAbstinenceTitle, l10n.notifyAbstinenceSubtitle, liturgical.notifyAbstinence,
                (v) => liturgical.setNotifyAbstinence(v)),
            const Divider(height: 1),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 6),
              leading: const CircleIcon(icon: Icons.access_time, color: AppColors.themeColor, size: 40),
              title: Text(l10n.reminderTimeLabel, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.primaryText)),
              subtitle: Text(
                liturgical.notificationTime.format(context),
                style: const TextStyle(fontSize: 13, color: AppColors.secondaryText),
              ),
              trailing: const Icon(Icons.chevron_right, color: AppColors.themeColor),
              onTap: () async {
                final time = await showTimePicker(context: context, initialTime: liturgical.notificationTime);
                if (time != null) liturgical.setNotificationTime(time);
              },
            ),
          ],
        ),
      ),
    );
  }
}
