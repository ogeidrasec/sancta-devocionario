import 'package:flutter/material.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/models/reminder_model.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/utils/date_text.dart';
import 'package:sanctaconscientia/utils/reminder_text.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';

/// Janela para criar um lembrete personalizado ou editar qualquer lembrete.
///
/// Lembretes de oração, novena e terço são criados pela folha "Adicionar"
/// (com busca) e aqui só se ajustam horário e repetição. Um lembrete ligado a
/// uma oração ou novena mostra o nome dela (sem poder trocar o texto).
class ReminderEditDialog extends StatefulWidget {
  final ReminderModel? reminder; // nulo = novo (personalizado), preenchido = edição

  const ReminderEditDialog({super.key, this.reminder});

  @override
  State<ReminderEditDialog> createState() => _ReminderEditDialogState();
}

class _ReminderEditDialogState extends State<ReminderEditDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late RecurrenceType _recurrence;
  late List<TimeOfDay> _times;

  /// Dias da semana escolhidos, de segunda (índice 0) a domingo (índice 6),
  /// do mesmo jeito que o modelo guarda (1 = segunda … 7 = domingo).
  late List<bool> _weekDays;
  int? _monthDay;
  int _interval = 1;

  bool get _isEditing => widget.reminder != null;

  /// Ligado a uma oração ou novena: o título vem delas.
  bool get _linked =>
      _isEditing && (widget.reminder!.prayerId != null || widget.reminder!.novenaId != null);

  /// Novena: sempre 9 dias, uma vez ao dia (só o horário se ajusta).
  bool get _isNovena => _isEditing && (widget.reminder!.type == ReminderType.novena || widget.reminder!.novenaId != null);

  /// Verdadeiro quando o usuário já mexeu nos horários (picker ou atalho).
  bool _timesTouched = false;

  /// Atalhos de horário: tocar adiciona o horário (ou troca o padrão 08:00).
  static const _timePresets = [
    TimeOfDay(hour: 7, minute: 0),
    TimeOfDay(hour: 12, minute: 0),
    TimeOfDay(hour: 21, minute: 0),
  ];

  @override
  void initState() {
    super.initState();
    final r = widget.reminder;
    _titleController = TextEditingController(text: r?.title ?? '');
    _recurrence = r?.recurrence ?? RecurrenceType.daily;
    _times = r != null && r.times.isNotEmpty ? List.from(r.times) : [const TimeOfDay(hour: 8, minute: 0)];
    _weekDays = List.generate(7, (i) => r?.weekDays?.contains(i + 1) ?? false);
    _monthDay = r?.monthDay;
    _interval = r?.interval ?? 1;
    if (_recurrence == RecurrenceType.custom) _recurrence = RecurrenceType.daily;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _applyTimePreset(TimeOfDay t) {
    setState(() {
      final isUntouchedDefault = !_isEditing && !_timesTouched && _times.length == 1;
      if (isUntouchedDefault) {
        _times = [t];
      } else if (!_times.contains(t)) {
        _times.add(t);
      }
      _timesTouched = true;
    });
  }

  String _presetLabel(AppLocalizations l10n, TimeOfDay t) {
    final name = t.hour < 11 ? l10n.timeMorning : (t.hour < 18 ? l10n.timeNoon : l10n.timeNight);
    return '$name ${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _pickTime({TimeOfDay? existing, int? index}) async {
    final picked = await showTimePicker(context: context, initialTime: existing ?? TimeOfDay.now());
    if (picked == null) return;
    setState(() {
      _timesTouched = true;
      if (index != null) {
        _times[index] = picked;
      } else if (!_times.contains(picked)) {
        _times.add(picked);
      }
    });
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final l10n = AppLocalizations.of(context)!;
    final r = widget.reminder;

    final recurrence = _isNovena ? RecurrenceType.daily : _recurrence;
    if (!_isNovena && recurrence == RecurrenceType.weekly && !_weekDays.contains(true)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.validationSelectWeekday)));
      return;
    }
    if (!_isNovena && recurrence == RecurrenceType.monthly && _monthDay == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.validationSelectDayOfMonth)));
      return;
    }

    List<int>? weekDays;
    if (!_isNovena && recurrence == RecurrenceType.weekly) {
      weekDays = [for (var i = 0; i < 7; i++) if (_weekDays[i]) i + 1];
    }

    final title = _linked
        ? r!.title
        : (_titleController.text.trim().isEmpty ? l10n.reminderDefaultTitleCustom : _titleController.text.trim());

    Navigator.pop(
      context,
      ReminderModel(
        id: r?.id ?? 'reminder_${DateTime.now().millisecondsSinceEpoch}',
        title: title,
        description: r?.description,
        type: r?.type ?? ReminderType.custom,
        times: _times,
        recurrence: recurrence,
        interval: _isNovena ? 1 : _interval,
        weekDays: weekDays,
        monthDay: recurrence == RecurrenceType.monthly ? _monthDay : null,
        startDate: r?.startDate,
        endDate: r?.endDate,
        maxOccurrences: _isNovena ? 9 : r?.maxOccurrences,
        isActive: r?.isActive ?? true,
        createdAt: r?.createdAt ?? DateTime.now(),
        lastTriggered: r?.lastTriggered,
        completionCount: r?.completionCount ?? 0,
        metadata: r?.metadata,
        prayerId: r?.prayerId,
        novenaId: r?.novenaId,
        notificationIds: r?.notificationIds ?? [],
      ),
    );
  }

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(top: 18, bottom: 8),
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.8, color: AppColors.secondaryText),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final maxHeight = MediaQuery.of(context).size.height * 0.9;
    final style = reminderTypeStyle(widget.reminder?.type ?? ReminderType.custom);

    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight, maxWidth: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ----- cabeçalho -----
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 8, 4),
              child: Row(
                children: [
                  CircleIcon(icon: style.icon, color: style.color, size: 40),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _isEditing ? l10n.reminderEditTitle : l10n.reminderNewTitle,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryText),
                    ),
                  ),
                  IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                ],
              ),
            ),

            // ----- conteúdo -----
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // título: o nome da oração/novena (fixo) ou texto livre
                      if (_linked) ...[
                        _label(l10n.reminderTitleLabel),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: appCardDecoration(tint: style.color),
                          child: Text(
                            localizedReminderTitle(context, widget.reminder!),
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryText),
                          ),
                        ),
                      ] else ...[
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: _titleController,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            labelText: l10n.reminderTitleLabel,
                            hintText: l10n.reminderTitleHint,
                          ),
                          validator: (value) => (value == null || value.trim().isEmpty) ? l10n.reminderTitleError : null,
                        ),
                      ],

                      // horários
                      _label(l10n.timesLabel),
                      for (var i = 0; i < _times.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () => _pickTime(existing: _times[i], index: i),
                                  icon: const Icon(Icons.access_time, size: 18),
                                  label: Text(_times[i].format(context)),
                                  style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(46)),
                                ),
                              ),
                              if (_times.length > 1)
                                IconButton(
                                  tooltip: l10n.removeButton,
                                  icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                                  onPressed: () => setState(() => _times.removeAt(i)),
                                ),
                            ],
                          ),
                        ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          for (final t in _timePresets)
                            ActionChip(label: Text(_presetLabel(l10n, t)), onPressed: () => _applyTimePreset(t)),
                          ActionChip(
                            avatar: const Icon(Icons.add, size: 18),
                            label: Text(l10n.addTimeButton),
                            onPressed: () => _pickTime(),
                          ),
                        ],
                      ),

                      // repetição (a novena é sempre diária, por 9 dias)
                      if (!_isNovena) ...[
                        _label(l10n.reminderRecurrenceLabel),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: [
                            for (final r in const [
                              RecurrenceType.daily,
                              RecurrenceType.weekly,
                              RecurrenceType.monthly,
                              RecurrenceType.once,
                            ])
                              ChoiceChip(
                                label: Text(_recurrenceLabel(l10n, r)),
                                selected: _recurrence == r,
                                onSelected: (_) => setState(() => _recurrence = r),
                                selectedColor: AppColors.themeColor.withValues(alpha: 0.15),
                              ),
                          ],
                        ),
                        if (_recurrence == RecurrenceType.weekly) ...[
                          const SizedBox(height: 12),
                          _buildWeekDays(),
                        ],
                        if (_recurrence == RecurrenceType.monthly) ...[
                          const SizedBox(height: 12),
                          DropdownButtonFormField<int>(
                            initialValue: _monthDay,
                            decoration: InputDecoration(labelText: l10n.monthDayLabel),
                            items: [
                              for (var d = 1; d <= 31; d++)
                                DropdownMenuItem(value: d, child: Text(l10n.reminderMonthDayValue(d))),
                            ],
                            onChanged: (v) => setState(() => _monthDay = v),
                          ),
                        ],
                        // "a cada N dias/semanas/meses" só aparece em lembretes antigos que o usam
                        if (_interval > 1 && _recurrence != RecurrenceType.once)
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Row(
                              children: [
                                Text('${l10n.everyLabel} ', style: const TextStyle(fontSize: 14)),
                                DropdownButton<int>(
                                  value: _interval,
                                  items: [for (var i = 1; i <= 30; i++) DropdownMenuItem(value: i, child: Text('$i'))],
                                  onChanged: (v) => setState(() => _interval = v ?? 1),
                                ),
                                const SizedBox(width: 8),
                                Flexible(child: Text(_intervalLabel(l10n), style: const TextStyle(fontSize: 14))),
                              ],
                            ),
                          ),
                      ],
                    ],
                  ),
                ),
              ),
            ),

            // ----- rodapé -----
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PillButton(
                    label: _isEditing ? l10n.reminderSaveButton : l10n.reminderCreateButton,
                    onPressed: _save,
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(l10n.reminderCancelButton),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Dias da semana começando na segunda, como o modelo guarda (1 = segunda).
  Widget _buildWeekDays() {
    final sundayFirst = weekdayInitials(context);
    final mondayFirst = [...sundayFirst.sublist(1), sundayFirst.first];
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: [
        for (var i = 0; i < 7; i++)
          FilterChip(
            label: Text(mondayFirst[i]),
            selected: _weekDays[i],
            onSelected: (v) => setState(() => _weekDays[i] = v),
            selectedColor: AppColors.themeColor.withValues(alpha: 0.15),
            showCheckmark: false,
          ),
      ],
    );
  }

  String _recurrenceLabel(AppLocalizations l10n, RecurrenceType type) {
    switch (type) {
      case RecurrenceType.once:
        return l10n.reminderRecurrenceOnce;
      case RecurrenceType.daily:
        return l10n.reminderRecurrenceDaily;
      case RecurrenceType.weekly:
        return l10n.reminderRecurrenceWeekly;
      case RecurrenceType.monthly:
        return l10n.reminderRecurrenceMonthly;
      case RecurrenceType.custom:
        return l10n.reminderRecurrenceCustom;
    }
  }

  String _intervalLabel(AppLocalizations l10n) {
    switch (_recurrence) {
      case RecurrenceType.daily:
        return l10n.reminderIntervalDays(_interval);
      case RecurrenceType.weekly:
        return l10n.reminderIntervalWeeks(_interval);
      case RecurrenceType.monthly:
        return l10n.reminderIntervalMonths(_interval);
      default:
        return '';
    }
  }
}
