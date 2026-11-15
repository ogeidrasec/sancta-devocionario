import 'package:flutter/material.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/providers/app_state.dart';
import 'package:sanctaconscientia/models/reminder_model.dart';

/// Folha para ajustar uma oração do plano: o momento do dia em que se costuma
/// rezar e o lembrete (horário e repetição). Devolve um mapa com
/// defaultTime, hasReminder, reminderTime e frequency.
class PrayerEditDialog extends StatefulWidget {
  final String prayerId;
  final String prayerTitle;
  final String? currentDefaultTime;
  final String? currentReminderTime;
  final String? currentFrequency;

  const PrayerEditDialog({
    super.key,
    required this.prayerId,
    required this.prayerTitle,
    this.currentDefaultTime,
    this.currentReminderTime,
    this.currentFrequency,
  });

  @override
  State<PrayerEditDialog> createState() => _PrayerEditDialogState();
}

class _PrayerEditDialogState extends State<PrayerEditDialog> {
  late String _selectedDefaultTime;
  bool _hasReminder = false;
  TimeOfDay? _reminderTime;
  late String _selectedFrequency;

  static const _momentIcons = {
    'morning': Icons.wb_twilight,
    'noon': Icons.wb_sunny_outlined,
    'night': Icons.nights_stay_outlined,
    'anytime': Icons.all_inclusive,
  };

  Map<String, String> _getDefaultTimeOptions(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return {
      'morning': l10n.timeMorning,
      'noon': l10n.timeNoon,
      'night': l10n.timeNight,
      'anytime': l10n.timeAnytime,
    };
  }

  Map<String, String> _getFrequencyOptions(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return {
      'once': l10n.frequencyOnce,
      'daily': l10n.frequencyDaily,
      'weekly': l10n.frequencyWeekly,
      'biweekly': l10n.frequencyBiweekly,
      'monthly': l10n.frequencyMonthly,
    };
  }

  @override
  void initState() {
    super.initState();
    _selectedDefaultTime = widget.currentDefaultTime ?? 'anytime';
    if (!_momentIcons.containsKey(_selectedDefaultTime)) _selectedDefaultTime = 'anytime';
    _selectedFrequency = widget.currentFrequency ?? 'daily';

    final appState = Provider.of<AppState>(context, listen: false);
    ReminderModel? reminder = appState.getReminderById('prayer_${widget.prayerId}');
    reminder ??= appState.getReminderById('novena_${widget.prayerId}');

    if (reminder != null && reminder.times.isNotEmpty) {
      _hasReminder = true;
      _reminderTime = reminder.times.first;
      switch (reminder.recurrence) {
        case RecurrenceType.once:
          _selectedFrequency = 'once';
        case RecurrenceType.daily:
          _selectedFrequency = 'daily';
        case RecurrenceType.weekly:
          _selectedFrequency = reminder.interval == 2 ? 'biweekly' : 'weekly';
        case RecurrenceType.monthly:
          _selectedFrequency = 'monthly';
        default:
          _selectedFrequency = 'daily';
      }
    }
  }

  Future<void> _selectReminderTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _reminderTime ?? TimeOfDay.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(primary: AppColors.themeColor, onPrimary: Colors.white),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _reminderTime = picked);
  }

  Widget _section(String label) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(label,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.secondaryText)),
      );

  Widget _chip(String label, bool selected, VoidCallback onTap, {IconData? icon, Key? key}) {
    return ChoiceChip(
      key: key,
      avatar: icon == null ? null : Icon(icon, size: 18, color: selected ? Colors.white : AppColors.themeColor),
      label: Text(label),
      selected: selected,
      showCheckmark: false,
      onSelected: (_) => onTap(),
      selectedColor: AppColors.themeColor,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(color: selected ? Colors.white : AppColors.primaryText, fontWeight: FontWeight.w500),
      side: BorderSide(color: AppColors.themeColor.withValues(alpha: selected ? 1 : 0.25)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 12, 20, 20 + MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const SizedBox(height: 16),
              Text(l10n.prayerEditSheetTitle,
                  textAlign: TextAlign.center, style: const TextStyle(fontSize: 13, color: AppColors.secondaryText)),
              const SizedBox(height: 2),
              Text(widget.prayerTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: AppColors.primaryText)),
              const SizedBox(height: 22),

              // Momento do dia
              _section(l10n.prayerEditMomentLabel),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _getDefaultTimeOptions(context)
                    .entries
                    .map((e) => _chip(
                          e.value,
                          _selectedDefaultTime == e.key,
                          () => setState(() => _selectedDefaultTime = e.key),
                          icon: _momentIcons[e.key],
                          key: ValueKey('moment_${e.key}'),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 22),

              // Lembrete
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.accentGold.withValues(alpha: _hasReminder ? 0.6 : 0.2)),
                ),
                padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Icon(_hasReminder ? Icons.notifications_active : Icons.notifications_off_outlined,
                            color: _hasReminder ? AppColors.accentGold : Colors.grey),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(l10n.prayerEditReminderLabel,
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryText)),
                              Text(_hasReminder ? l10n.prayerEditReminderOn : l10n.prayerEditReminderOff,
                                  style: const TextStyle(fontSize: 12, color: AppColors.secondaryText)),
                            ],
                          ),
                        ),
                        Switch(
                          key: const ValueKey('reminder_switch'),
                          value: _hasReminder,
                          onChanged: (value) => setState(() {
                            _hasReminder = value;
                            if (value && _reminderTime == null) _reminderTime = TimeOfDay.now();
                          }),
                          activeThumbColor: AppColors.themeColor,
                        ),
                      ],
                    ),
                    if (_hasReminder) ...[
                      const Divider(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: InkWell(
                          key: const ValueKey('reminder_time'),
                          borderRadius: BorderRadius.circular(12),
                          onTap: _selectReminderTime,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(l10n.prayerEditTimeLabel,
                                      style: const TextStyle(fontSize: 14, color: AppColors.secondaryText)),
                                ),
                                Text(
                                  _reminderTime?.format(context) ?? l10n.selectTime,
                                  style: const TextStyle(
                                      fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.themeColor),
                                ),
                                const SizedBox(width: 6),
                                const Icon(Icons.edit, size: 16, color: AppColors.themeColor),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _section(l10n.prayerEditRepeatLabel),
                      Padding(
                        padding: const EdgeInsets.only(right: 8, bottom: 8),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _getFrequencyOptions(context)
                              .entries
                              .map((e) => _chip(
                                    e.value,
                                    _selectedFrequency == e.key,
                                    () => setState(() => _selectedFrequency = e.key),
                                    key: ValueKey('freq_${e.key}'),
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: Text(l10n.cancel),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context, {
                        'defaultTime': _selectedDefaultTime,
                        'hasReminder': _hasReminder,
                        'reminderTime': _hasReminder ? _reminderTime : null,
                        'frequency': _hasReminder ? _selectedFrequency : null,
                      }),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.themeColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: Text(l10n.save),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
