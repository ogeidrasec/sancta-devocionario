import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/providers/confession_provider.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';

class ConfessionSchedulingDialog extends StatefulWidget {
  const ConfessionSchedulingDialog({super.key});

  @override
  State<ConfessionSchedulingDialog> createState() => _ConfessionSchedulingDialogState();
}

class _ConfessionSchedulingDialogState extends State<ConfessionSchedulingDialog> {
  late DateTime _selectedDate;
  late bool _reminderEnabled;
  late int _reminderDaysBefore;
  late TimeOfDay _reminderTime;
  late int? _confessionInterval; // New state variable

  @override
  void initState() {
    super.initState();
    final confessionProvider = Provider.of<ConfessionProvider>(context, listen: false);
    _selectedDate = confessionProvider.nextConfessionDate ?? DateTime.now().add(const Duration(days: 7));
    _reminderEnabled = confessionProvider.confessionReminderTime != null;
    _reminderDaysBefore = confessionProvider.confessionReminderDays ?? 1;
    _reminderTime = confessionProvider.confessionReminderTime ?? const TimeOfDay(hour: 9, minute: 0);
    _confessionInterval = confessionProvider.confessionInterval; // Initialize from ConfessionProvider
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
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
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectReminderTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _reminderTime,
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
    if (picked != null && picked != _reminderTime) {
      setState(() {
        _reminderTime = picked;
      });
    }
  }

  String _getDaysBeforeLabel(int days, AppLocalizations l10n) {
    if (days == 1) return l10n.confessionReminder1Day;
    if (days == 2) return l10n.confessionReminder2Days;
    if (days == 3) return l10n.confessionReminder3Days;
    if (days == 7) return l10n.confessionReminder1Week;
    return '$days ${l10n.daysUnit}';
  }

  // Removed unused _getIntervalLabel

  void _save() {
    final confessionProvider = Provider.of<ConfessionProvider>(context, listen: false);
    confessionProvider.setNextConfessionDate(_selectedDate);
    confessionProvider.setConfessionInterval(_confessionInterval);
    
    if (_reminderEnabled) {
      confessionProvider.setConfessionReminder(_reminderTime, daysInAdvance: _reminderDaysBefore);
    } else {
      confessionProvider.cancelConfessionReminder();
    }
    
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.nextConfessionLabel),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Selection
            InkWell(
              onTap: () => _selectDate(context),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: l10n.dateLabel,
                  border: const OutlineInputBorder(),
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                child: Text(
                  '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Confession Frequency (Recurrence)
            DropdownButtonFormField<int?>(
              isExpanded: true,
              initialValue: [null, 7, 14, 30].contains(_confessionInterval) ? _confessionInterval : -1,
              decoration: InputDecoration(
                labelText: l10n.confessionFrequencyLabel,
                border: const OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(value: null, child: Text(l10n.frequencyNone)),
                DropdownMenuItem(value: 7, child: Text(l10n.confessionReminder1Week)),
                DropdownMenuItem(value: 14, child: Text('2 ${l10n.weeksUnit}')),
                DropdownMenuItem(value: 30, child: Text('1 ${l10n.monthUnit}')),
                DropdownMenuItem(value: -1, child: Text(l10n.frequencyCustom)),
              ],
              onChanged: (value) async {
                if (value == -1) {
                   final customDays = await showDialog<int>(
                      context: context,
                      builder: (ctx) {
                         final controller = TextEditingController(text: _confessionInterval?.toString() ?? '');
                         return AlertDialog(
                           title: Text(l10n.confessionIntervalCustomTitle),
                           content: TextField(
                             controller: controller,
                             keyboardType: TextInputType.number,
                             decoration: InputDecoration(
                               labelText: l10n.confessionIntervalCustomLabel,
                               suffixText: l10n.daysUnit,
                             ),
                           ),
                           actions: [
                             TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l10n.cancelButton)),
                             TextButton(onPressed: () {
                               final days = int.tryParse(controller.text);
                               if (days != null && days > 0) Navigator.pop(ctx, days);
                             }, child: Text(l10n.confirm)),
                           ],
                         );
                      },
                   );
                   if (customDays != null) setState(() => _confessionInterval = customDays);
                } else {
                  setState(() => _confessionInterval = value);
                }
              },
            ),
            const SizedBox(height: 24),

            // Reminder Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(l10n.confessionReminderEnabled)),
                Switch(
                  value: _reminderEnabled,
                  onChanged: (val) => setState(() => _reminderEnabled = val),
                  // activeColor removed
                ),
              ],
            ),

            if (_reminderEnabled) ...[
              const SizedBox(height: 16),
              // Reminder Offset (Days Before)
              DropdownButtonFormField<int>(
                initialValue: [1, 2, 3, 7].contains(_reminderDaysBefore) ? _reminderDaysBefore : -1,
                decoration: InputDecoration(
                  labelText: l10n.confessionReminderDaysBefore,
                  border: const OutlineInputBorder(),
                ),
                items: [
                  ...[1, 2, 3, 7].map((days) => DropdownMenuItem(value: days, child: Text(_getDaysBeforeLabel(days, l10n)))),
                  DropdownMenuItem(value: -1, child: Text(l10n.frequencyCustom)),
                ],
                onChanged: (value) async {
                  if (value == -1) {
                    // Reuse existing custom logic
                    final customDays = await showDialog<int>(
                      context: context,
                      builder: (ctx) {
                         final controller = TextEditingController(text: _reminderDaysBefore.toString());
                         return AlertDialog(
                           title: Text(l10n.confessionReminderDaysCustomTitle),
                           content: TextField(
                             controller: controller,
                             keyboardType: TextInputType.number,
                             decoration: InputDecoration(labelText: l10n.confessionReminderDaysCustomLabel, suffixText: l10n.daysUnit),
                           ),
                           actions: [
                             TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l10n.cancelButton)),
                             TextButton(onPressed: () {
                               final days = int.tryParse(controller.text);
                               if (days != null && days > 0) Navigator.pop(ctx, days);
                             }, child: Text(l10n.confirm)),
                           ],
                         );
                      },
                    );
                    if (customDays != null) setState(() => _reminderDaysBefore = customDays);
                  } else if (value != null) {
                    setState(() => _reminderDaysBefore = value);
                  }
                },
              ),
              const SizedBox(height: 16),
              
              // Time Picker
              InkWell(
                onTap: () => _selectReminderTime(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: l10n.confessionReminderTime,
                    border: const OutlineInputBorder(),
                    suffixIcon: const Icon(Icons.access_time),
                  ),
                  child: Text(
                    _reminderTime.format(context),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancelButton),
        ),
        ElevatedButton(
          onPressed: _save,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.themeColor,
            foregroundColor: Colors.white,
          ),
          child: Text(l10n.saveButton),
        ),
      ],
    );
  }
}
