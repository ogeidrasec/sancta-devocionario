import 'package:sanctaconscientia/utils/date_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/utils/liturgical_calendar.dart';
import '../../../providers/prayer_provider.dart';
import '../../../providers/confession_provider.dart';
import '../../../data/novena_data.dart';
import '../plano_vida_page.dart';
import 'package:sanctaconscientia/widgets/confession_confirmation_dialog.dart';
import 'package:sanctaconscientia/data/novena_feasts.dart';
import 'package:sanctaconscientia/pages/novena_detail_page.dart';
import 'package:sanctaconscientia/widgets/day_record.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';

// Cores dos marcadores (as mesmas ideias do Jardim da Alma)
const Color _rosaryColor = Color(0xFFD94452);
const Color _massColor = Color(0xFFB7791F);
const Color _novenaColor = Color(0xFFFFC107);
const Color _confessionColor = Color(0xFF8E44AD);

/// O que aconteceu (ou está planejado) em um dia do mês.
class _DayMarks {
  bool feast = false;
  bool precept = false;
  bool rosary = false;
  bool mass = false;
  bool novena = false;
  bool confession = false;
  bool nextConfession = false;
  bool prayer = false;
}

/// Calendário: o mês com marcadores por dia e, embaixo, o registro do dia
/// escolhido (o que foi rezado, missa, confissão, novenas) com atalhos para
/// adicionar.
class HistoricoTab extends StatefulWidget {
  const HistoricoTab({super.key});

  @override
  State<HistoricoTab> createState() => _HistoricoTabState();
}

class _HistoricoTabState extends State<HistoricoTab> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  static DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);
  static bool _isSameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;

  void _changeMonth(int delta) =>
      setState(() => _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + delta));

  void _goToday() => setState(() {
        _focusedDay = DateTime.now();
        _selectedDay = DateTime.now();
      });

  int _daysInMonth(DateTime date) => DateTime(date.year, date.month + 1, 0).day;
  int _firstDayOffset(DateTime date) => DateTime(date.year, date.month, 1).weekday % 7;

  /// Marcadores de todos os dias do mês, calculados em uma passada pelos dados.
  Map<int, _DayMarks> _monthMarks(PrayerProvider prayers, ConfessionProvider confessions, AppLocalizations l10n) {
    final month = _focusedDay;
    final feasts = LiturgicalCalendar.getFixedFeasts(month.year, l10n);

    // dias (yyyyMMdd) com alguma oração e com terço
    final prayerDays = <String>{};
    final rosaryDays = <String>{};
    for (final log in prayers.prayerLogs) {
      final ts = DateTime.tryParse(log['timestamp'] ?? '');
      if (ts == null) continue;
      final key = DateFormat('yyyyMMdd').format(ts);
      prayerDays.add(key);
      if ((log['prayerId'] ?? '').startsWith('rosary')) rosaryDays.add(key);
    }
    prayers.dailyPrayers.forEach((key, value) {
      if (value == 1 && key.length > 8) {
        prayerDays.add(key.substring(0, 8));
        if (key.contains('rosary')) rosaryDays.add(key.substring(0, 8));
      }
    });

    final result = <int, _DayMarks>{};
    for (var day = 1; day <= _daysInMonth(month); day++) {
      final date = DateTime(month.year, month.month, day);
      final key = DateFormat('yyyyMMdd').format(date);
      final m = _DayMarks()
        ..feast = feasts.containsKey(date)
        ..precept = LiturgicalCalendar.isDayOfObligation(date)
        ..rosary = rosaryDays.contains(key)
        ..prayer = prayerDays.contains(key)
        ..mass = prayers.hasMassOn(date)
        ..novena = prayers.getNovenasForDate(date).isNotEmpty
        ..confession = confessions.confessionHistory.any((e) => _isSameDay(e['date'] as DateTime, date))
        ..nextConfession =
            confessions.nextConfessionDate != null && _isSameDay(confessions.nextConfessionDate!, date);
      result[day] = m;
    }
    return result;
  }

  /// Itens feitos no dia selecionado: missa, confissão e orações (registros).
  List<DayEntry> _entriesFor(
    BuildContext context,
    PrayerProvider prayers,
    ConfessionProvider confessions,
    DateTime day,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final entries = <DayEntry>[];

    if (prayers.hasMassOn(day)) {
      entries.add(DayEntry(
        kind: DayEntryKind.mass,
        title: l10n.heatmapMassLabel,
        onUndo: () => prayers.toggleMass(day),
      ));
    }
    if (confessions.confessionHistory.any((e) => _isSameDay(e['date'] as DateTime, day))) {
      entries.add(DayEntry(kind: DayEntryKind.confession, title: l10n.historyConfessionDone));
    }

    final logs = prayers.prayerLogs.where((log) {
      final ts = DateTime.tryParse(log['timestamp'] ?? '');
      return ts != null && _isSameDay(ts, day);
    }).toList();
    final fromLogs = <DayEntry>[for (final log in logs) DayEntry.fromLog(context, prayers, log)];

    // Orações marcadas no plano que não geraram registro (sincronia de segurança)
    final dateKey = DateFormat('yyyyMMdd').format(day);
    prayers.dailyPrayers.forEach((key, value) {
      if (!key.startsWith(dateKey) || value != 1) return;
      final prayerId = key.split('_').sublist(1).join('_');
      if (logs.any((log) => log['prayerId'] == prayerId)) return;
      fromLogs.add(DayEntry.fromLog(
        context,
        prayers,
        {
          'title': prayers.availablePrayers.firstWhere(
            (p) => p['id'] == prayerId,
            orElse: () => {'title': l10n.reminderTypePrayer},
          )['title']!,
          'timestamp': day.toIso8601String(),
          'prayerId': prayerId,
          'dateKey': dateKey,
        },
        synthetic: true,
      ));
    });

    // com horário primeiro (mais recente no alto); sem horário depois
    final timed = fromLogs.where((e) => e.time != null).toList()..sort((a, b) => b.time!.compareTo(a.time!));
    final untimed = fromLogs.where((e) => e.time == null).toList();
    return [...entries, ...timed, ...untimed];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final prayers = Provider.of<PrayerProvider>(context);
    final confessions = Provider.of<ConfessionProvider>(context);
    final locale = Localizations.localeOf(context).toString();
    final today = _dateOnly(DateTime.now());
    final selected = _dateOnly(_selectedDay);

    final season = LiturgicalCalendar.getSeason(selected);
    final seasonColor = LiturgicalCalendar.getSeasonColor(season);
    final seasonName = LiturgicalCalendar.getSeasonName(l10n, season);
    final marks = _monthMarks(prayers, confessions, l10n);
    final isCurrentView = _isSameDay(selected, today) && _focusedDay.year == today.year && _focusedDay.month == today.month;

    final entries = _entriesFor(context, prayers, confessions, selected);
    final feastName = LiturgicalCalendar.getFeastName(selected, l10n);
    final isPrecept = LiturgicalCalendar.isDayOfObligation(selected);
    final isNextConfessionDay =
        confessions.nextConfessionDate != null && _isSameDay(confessions.nextConfessionDate!, selected);
    final dayNovenas = prayers.getNovenasForDate(selected);
    final canMark = !selected.isAfter(today); // missa e confissão: hoje ou dias passados

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        children: [
          // ---------- mês ----------
          Row(
            children: [
              IconButton(
                tooltip: DateFormat.yMMMM(locale).format(DateTime(_focusedDay.year, _focusedDay.month - 1)),
                icon: const Icon(Icons.chevron_left, color: AppColors.themeColor),
                onPressed: () => _changeMonth(-1),
              ),
              Expanded(
                child: Text(
                  toBeginningOfSentenceCase(DateFormat.yMMMM(locale).format(_focusedDay)) ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryText),
                ),
              ),
              IconButton(
                tooltip: DateFormat.yMMMM(locale).format(DateTime(_focusedDay.year, _focusedDay.month + 1)),
                icon: const Icon(Icons.chevron_right, color: AppColors.themeColor),
                onPressed: () => _changeMonth(1),
              ),
            ],
          ),
          // tempo litúrgico do dia escolhido + atalho para voltar a hoje
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: seasonColor.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: seasonColor.withValues(alpha: 0.45)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(width: 9, height: 9, decoration: BoxDecoration(color: seasonColor, shape: BoxShape.circle)),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          seasonName,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primaryText),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (!isCurrentView) ...[
                const SizedBox(width: 10),
                TextButton.icon(
                  onPressed: _goToday,
                  icon: const Icon(Icons.today, size: 18),
                  label: Text(l10n.calendarTodayButton),
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),

          // ---------- grade do mês (arrastar para o lado troca de mês) ----------
          GestureDetector(
            onHorizontalDragEnd: (d) {
              final v = d.primaryVelocity ?? 0;
              if (v < -250) _changeMonth(1);
              if (v > 250) _changeMonth(-1);
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
              decoration: appCardDecoration(radius: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      for (final n in weekdayInitials(context))
                        Expanded(
                          child: Center(
                            child: Text(
                              n,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.secondaryText),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      childAspectRatio: 0.92,
                    ),
                    itemCount: _daysInMonth(_focusedDay) + _firstDayOffset(_focusedDay),
                    itemBuilder: (context, index) {
                      final offset = _firstDayOffset(_focusedDay);
                      if (index < offset) return const SizedBox.shrink();
                      final day = index - offset + 1;
                      final date = DateTime(_focusedDay.year, _focusedDay.month, day);
                      return _DayCell(
                        day: day,
                        marks: marks[day]!,
                        isSelected: _isSameDay(date, selected),
                        isToday: _isSameDay(date, today),
                        onTap: () => setState(() => _selectedDay = date),
                      );
                    },
                  ),
                  const SizedBox(height: 6),
                  // legenda
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    runSpacing: 4,
                    children: [
                      _legend(const Icon(Icons.star, size: 11, color: Colors.orange), l10n.calendarLegendFeast),
                      _legend(_dot(_rosaryColor), l10n.heatmapRosaryLabel),
                      _legend(_dot(_massColor), l10n.heatmapMassLabel),
                      _legend(_dot(_novenaColor), l10n.heatmapNovenaLabel),
                      _legend(_dot(_confessionColor), l10n.heatmapConfessionLabel),
                      _legend(_dot(Colors.grey, size: 5), l10n.calendarLegendPrayer),
                    ],
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // ---------- dia escolhido ----------
          Text(
            toBeginningOfSentenceCase(DateFormat.MMMMEEEEd(locale).format(selected)) ?? '',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryText),
          ),
          if (feastName != null || isPrecept)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Wrap(
                spacing: 8,
                runSpacing: 4,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  if (feastName != null)
                    Text(feastName,
                        style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: AppColors.secondaryText)),
                  if (isPrecept)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Text(
                        l10n.historyDayOfObligation,
                        style: TextStyle(fontSize: 12, color: Colors.red.shade700, fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
            ),
          const SizedBox(height: 12),

          // atalhos
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _DayAction(
                icon: Icons.add,
                label: l10n.calendarActionPrayer,
                color: AppColors.themeColor,
                onTap: () => PlanoVidaPage.showPrayerSelectionDialog(context, selected),
              ),
              if (canMark)
                _DayAction(
                  icon: prayers.hasMassOn(selected) ? Icons.check : Icons.church,
                  label: l10n.calendarActionMass,
                  color: _massColor,
                  active: prayers.hasMassOn(selected),
                  onTap: () => prayers.toggleMass(selected),
                ),
              if (canMark)
                _DayAction(
                  icon: Icons.volunteer_activism,
                  label: l10n.calendarActionConfession,
                  color: _confessionColor,
                  onTap: () => _showConfirmConfessionDialog(context, confessions, selected),
                ),
            ],
          ),
          const SizedBox(height: 16),

          // informações do dia: confissão planejada e novenas em andamento
          if (isNextConfessionDay)
            _InfoCard(
              icon: Icons.event,
              color: _confessionColor,
              title: l10n.historyNextConfession,
              subtitle: l10n.historyNextConfessionSubtitle,
            ),
          for (final n in dayNovenas)
            _InfoCard(
              icon: Icons.local_florist,
              color: AppColors.accentGold,
              title: l10n.historyNovenaLabel(NovenaData.getNovenaById(context, n['id'] as String).title),
              subtitle: l10n.novenaDayProgress(n['day'] as int, 9),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => NovenaDetailPage(novenaId: n['id'] as String)),
              ),
            ),

          // registro do dia
          Row(
            children: [
              Expanded(child: SectionLabel(l10n.calendarRecordTitle)),
              if (entries.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.successColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${entries.length}',
                      style: const TextStyle(color: AppColors.successColor, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
          if (entries.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              child: Text(
                selected.isAfter(today) ? l10n.calendarFutureHint : l10n.calendarNothingRecorded,
                style: const TextStyle(fontSize: 14, height: 1.4, color: AppColors.secondaryText),
              ),
            )
          else
            for (final e in entries) DayEntryTile(entry: e),

          // ---------- resumo do mês ----------
          const SizedBox(height: 16),
          SectionLabel(l10n.calendarSummaryTitle),
          _buildMonthSummary(l10n, marks),

          // ---------- próximos dias ----------
          const SizedBox(height: 16),
          SectionLabel(l10n.calendarUpcomingTitle),
          _buildUpcoming(context, prayers, confessions, today),
        ],
      ),
    );
  }

  /// Números do mês exibido: dias com oração, dias de terço, missas e confissões.
  Widget _buildMonthSummary(AppLocalizations l10n, Map<int, _DayMarks> marks) {
    final prayerDays = marks.values.where((m) => m.prayer).length;
    final rosaryDays = marks.values.where((m) => m.rosary).length;
    final masses = marks.values.where((m) => m.mass).length;
    final confessions = marks.values.where((m) => m.confession).length;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _SummaryPill(icon: Icons.favorite_border, color: AppColors.themeColor, text: l10n.calendarSummaryPrayerDays(prayerDays)),
        _SummaryPill(icon: Icons.auto_awesome, color: _rosaryColor, text: l10n.calendarSummaryRosary(rosaryDays)),
        _SummaryPill(icon: Icons.church, color: _massColor, text: l10n.calendarSummaryMass(masses)),
        _SummaryPill(icon: Icons.volunteer_activism, color: _confessionColor, text: l10n.calendarSummaryConfession(confessions)),
      ],
    );
  }

  /// Festas, confissão planejada e novenas (agendadas ou sugeridas) das próximas semanas.
  List<_Upcoming> _upcoming(
    BuildContext context,
    PrayerProvider prayers,
    ConfessionProvider confessions,
    DateTime today, {
    int horizon = 21,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final end = today.add(Duration(days: horizon));
    final out = <_Upcoming>[];

    bool inRange(DateTime d) => d.isAfter(today) && !d.isAfter(end);

    // festas fixas e móveis
    for (final year in {today.year, end.year}) {
      final feasts = {
        ...LiturgicalCalendar.getFixedFeasts(year, l10n),
        ...LiturgicalCalendar.getMovableFeasts(year, l10n),
      };
      feasts.forEach((date, name) {
        final d = _dateOnly(date);
        if (inRange(d)) {
          out.add(_Upcoming(date: d, icon: Icons.star, color: Colors.orange, title: name));
        }
      });
    }

    // confissão planejada
    final next = confessions.nextConfessionDate;
    if (next != null && inRange(_dateOnly(next))) {
      out.add(_Upcoming(
        date: _dateOnly(next),
        icon: Icons.event,
        color: _confessionColor,
        title: l10n.historyNextConfession,
      ));
    }

    // novenas agendadas e sugeridas
    final novenas = NovenaData.getAllNovenas(context);
    for (final n in novenas) {
      final start = prayers.getNovenaStartDate(n.id);
      if (start != null && !prayers.isNovenaActive(n.id) && inRange(_dateOnly(start))) {
        out.add(_Upcoming(
          date: _dateOnly(start),
          icon: n.icon,
          color: AppColors.accentGold,
          title: n.title,
          subtitle: l10n.novenaScheduled(fmtDayMonth(context, start)),
          novenaId: n.id,
        ));
      }
    }
    for (final s in NovenaFeasts.suggestionsFor(today, lookBackDays: 0, lookAheadDays: horizon)) {
      final start = _dateOnly(s.start);
      if (!inRange(start)) continue;
      if (prayers.isNovenaActive(s.novenaId) || prayers.getNovenaStartDate(s.novenaId) != null) continue;
      final matches = novenas.where((n) => n.id == s.novenaId);
      if (matches.isEmpty) continue;
      final days = start.difference(today).inDays;
      out.add(_Upcoming(
        date: start,
        icon: matches.first.icon,
        color: AppColors.accentGold,
        title: matches.first.title,
        subtitle: l10n.novenaSuggestSoon(days, fmtDayMonth(context, s.feast)),
        novenaId: s.novenaId,
      ));
    }

    out.sort((a, b) => a.date.compareTo(b.date));
    return out.take(6).toList();
  }

  Widget _buildUpcoming(BuildContext context, PrayerProvider prayers, ConfessionProvider confessions, DateTime today) {
    final l10n = AppLocalizations.of(context)!;
    final items = _upcoming(context, prayers, confessions, today);
    if (items.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        child: Text(l10n.calendarUpcomingEmpty, style: const TextStyle(fontSize: 14, color: AppColors.secondaryText)),
      );
    }
    final locale = Localizations.localeOf(context).toString();
    return Column(
      children: [
        for (final e in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
              decoration: appCardDecoration(tint: e.color),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  // toca: vai para o dia no calendário (novena: abre a novena)
                  onTap: () {
                    if (e.novenaId != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => NovenaDetailPage(novenaId: e.novenaId!)),
                      );
                    } else {
                      setState(() {
                        _selectedDay = e.date;
                        _focusedDay = e.date;
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Container(
                          width: 52,
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            color: e.color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            children: [
                              Text('${e.date.day}',
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryText)),
                              Text(
                                DateFormat.MMM(locale).format(e.date).toUpperCase(),
                                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.secondaryText),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(e.title,
                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.primaryText)),
                              const SizedBox(height: 2),
                              Text(
                                e.subtitle ?? l10n.calendarInDays(e.date.difference(today).inDays),
                                style: const TextStyle(fontSize: 12, height: 1.3, color: AppColors.secondaryText),
                              ),
                            ],
                          ),
                        ),
                        Icon(e.icon, color: e.color),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _dot(Color color, {double size = 7}) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );

  Widget _legend(Widget glyph, String label) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          glyph,
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 11, color: AppColors.secondaryText)),
        ],
      );

  void _showConfirmConfessionDialog(BuildContext context, ConfessionProvider confessionProvider, DateTime date) async {
    final result = await showDialog<ConfessionConfirmationResult>(
      context: context,
      builder: (ctx) => ConfessionConfirmationDialog(initialDate: date),
    );

    if (result != null && context.mounted) {
      confessionProvider.confirmarConfissao(
        date: result.date,
        penanceNote: result.penanceNote,
      );

      if (result.reminderTime != null) {
        final l10n = AppLocalizations.of(context)!;
        final note = result.penanceNote ?? l10n.reminderTypePenance;
        confessionProvider.setPenanceReminder(note, result.reminderTime!);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.confessionConfirmed)),
      );
    }
  }
}

/// Um dia da grade: número e marcadores. O dia escolhido ganha preenchimento
/// e anel; hoje ganha um anel dourado.
class _DayCell extends StatelessWidget {
  final int day;
  final _DayMarks marks;
  final bool isSelected;
  final bool isToday;
  final VoidCallback onTap;

  const _DayCell({
    required this.day,
    required this.marks,
    required this.isSelected,
    required this.isToday,
    required this.onTap,
  });

  Widget _dot(Color color, {double size = 6}) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1),
        child: Container(width: size, height: size, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      );

  @override
  Widget build(BuildContext context) {
    final onlyPrayer = marks.prayer && !marks.rosary && !marks.mass && !marks.novena && !marks.confession;
    final border = isSelected
        ? Border.all(color: AppColors.themeColor, width: 2)
        : (isToday ? Border.all(color: AppColors.accentGold, width: 1.5) : null);

    return Semantics(
      button: true,
      selected: isSelected,
      label: '$day',
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.themeColor.withValues(alpha: 0.12) : (isToday ? AppColors.accentGold.withValues(alpha: 0.12) : Colors.transparent),
            borderRadius: BorderRadius.circular(12),
            border: border,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$day',
                  style: TextStyle(
                    fontSize: 15,
                    color: marks.precept ? Colors.red.shade700 : AppColors.primaryText,
                    fontWeight: (isToday || isSelected || marks.precept) ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 3),
                SizedBox(
                  height: 10,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (marks.feast) const Icon(Icons.star, size: 9, color: Colors.orange),
                      if (marks.rosary) _dot(_rosaryColor),
                      if (marks.mass) _dot(_massColor),
                      if (marks.novena) _dot(_novenaColor),
                      if (marks.confession) _dot(_confessionColor),
                      if (marks.nextConfession && !marks.confession)
                        const Icon(Icons.event, size: 10, color: _confessionColor),
                      if (onlyPrayer) _dot(Colors.grey, size: 5),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Botão de atalho do dia (adicionar oração, marcar missa, marcar confissão).
class _DayAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool active;
  final VoidCallback onTap;

  const _DayAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: active ? color.withValues(alpha: 0.18) : Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withValues(alpha: active ? 0.7 : 0.35), width: active ? 2 : 1.2),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 8),
              Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primaryText)),
            ],
          ),
        ),
      ),
    );
  }
}

/// Informação do dia que ainda não é um registro (confissão planejada, novena).
class _InfoCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const _InfoCard({required this.icon, required this.color, required this.title, required this.subtitle, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
        padding: const EdgeInsets.all(14),
        decoration: appCardDecoration(tint: color),
        child: Row(
          children: [
            CircleIcon(icon: icon, color: color, size: 42),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.primaryText)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(fontSize: 13, color: AppColors.secondaryText)),
                ],
              ),
            ),
            if (onTap != null) Icon(Icons.chevron_right, color: color),
          ],
        ),
      ),
      ),
    );
  }
}

/// Evento dos próximos dias (festa, confissão planejada, novena).
class _Upcoming {
  final DateTime date;
  final IconData icon;
  final Color color;
  final String title;
  final String? subtitle;
  final String? novenaId;

  const _Upcoming({
    required this.date,
    required this.icon,
    required this.color,
    required this.title,
    this.subtitle,
    this.novenaId,
  });
}

/// Número do resumo do mês, em formato de pílula.
class _SummaryPill extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;

  const _SummaryPill({required this.icon, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primaryText)),
        ],
      ),
    );
  }
}
