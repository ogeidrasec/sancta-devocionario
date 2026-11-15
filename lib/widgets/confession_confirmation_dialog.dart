import 'package:sanctaconscientia/utils/date_text.dart';
import 'package:flutter/material.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';

class ConfessionConfirmationResult {
  final DateTime date;
  final String? penanceNote;
  final bool reminderEnabled;
  final TimeOfDay? reminderTime;

  ConfessionConfirmationResult({
    required this.date,
    this.penanceNote,
    required this.reminderEnabled,
    this.reminderTime,
  });
}

class ConfessionConfirmationDialog extends StatefulWidget {
  final DateTime? initialDate;

  const ConfessionConfirmationDialog({
    super.key,
    this.initialDate,
  });

  @override
  State<ConfessionConfirmationDialog> createState() => _ConfessionConfirmationDialogState();
}

class _ConfessionConfirmationDialogState extends State<ConfessionConfirmationDialog> {
  late DateTime _confessionDate;
  final _penanceController = TextEditingController();
  bool _reminderEnabled = false;
  TimeOfDay? _reminderTime;

  @override
  void initState() {
    super.initState();
    _confessionDate = widget.initialDate ?? DateTime.now();
  }

  @override
  void dispose() {
    _penanceController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _confessionDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
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
    if (picked != null) {
      setState(() {
        _confessionDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _reminderTime ?? TimeOfDay.now(),
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
    if (picked != null) {
      setState(() {
        _reminderTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isPastDate = !_isToday(_confessionDate);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(l10n.confessDialogTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.confessDialogContent,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 14, color: AppColors.primaryText),
            ),
            const SizedBox(height: 16),
            
            // Penitência
            TextField(
              controller: _penanceController,
              decoration: InputDecoration(
                labelText: l10n.penanceOptional,
                hintText: l10n.penanceHint,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                prefixIcon: const Icon(Icons.assignment_outlined, color: AppColors.themeColor),
              ),
              maxLines: 2,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16),
            
            // Data da Confissão
            InkWell(
              onTap: _selectDate,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: AppColors.themeColor, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.confessionDateLabel,
                            style: const TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                          Text(
                            fmtDate(context, _confessionDate),
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down, color: Colors.grey),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Lembrete de Penitência
            SwitchListTile(
              title: Text(
                l10n.confessionReminderEnabled,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              subtitle: isPastDate 
                  ? Text(
                      AppLocalizations.of(context)!.confessionRetroactiveHint,
                      style: const TextStyle(fontSize: 11, color: Colors.orange),
                    ) 
                  : null,
              value: _reminderEnabled,
              activeThumbColor: AppColors.themeColor,
              onChanged: (value) {
                setState(() {
                  _reminderEnabled = value;
                  if (value && _reminderTime == null) {
                    final now = DateTime.now();
                    final nextHour = now.add(const Duration(hours: 1));
                    _reminderTime = TimeOfDay.fromDateTime(nextHour);
                  }
                });
              },
              contentPadding: EdgeInsets.zero,
            ),

            if (_reminderEnabled) ...[
              const SizedBox(height: 8),
              InkWell(
                onTap: _selectTime,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.access_time, color: AppColors.themeColor, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.reminderTimeLabel,
                              style: const TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                            Text(
                              _reminderTime?.format(context) ?? '--:--',
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.edit, size: 16, color: Colors.grey),
                    ],
                  ),
                ),
              ),
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
          onPressed: () {
            final penanceText = _penanceController.text.trim();
            Navigator.pop(
              context,
              ConfessionConfirmationResult(
                date: _confessionDate,
                penanceNote: penanceText.isNotEmpty ? penanceText : null,
                reminderEnabled: _reminderEnabled,
                reminderTime: _reminderEnabled ? _reminderTime : null,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.themeColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(l10n.confirm),
        ),
      ],
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }
}
