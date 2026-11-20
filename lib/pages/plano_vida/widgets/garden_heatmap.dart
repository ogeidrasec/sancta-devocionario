import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:sanctaconscientia/utils/date_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/data/novena_data.dart';
import 'package:sanctaconscientia/data/prayer_data.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/providers/confession_provider.dart';
import 'package:sanctaconscientia/utils/liturgical_calendar.dart';

// Paleta do jardim
const Color _gardenGold = Color(0xFFE0A526);
// Gramado: seco e amarelado sem oração, cada vez mais verde a cada oração e
// totalmente verde (bem hidratado) com um sacramento: missa ou confissão.
const Color _grassDry = Color(0xFFE6D98E);
const Color _grassDryBorder = Color(0xFFD3C477);
const Color _grassDryTuft = Color(0xFFBFAE5C);
const Color _grassLush = Color(0xFF3FA535);
const Color _grassLushTuft = Color(0xFF2B7D26);
const Color _roseRed = Color(0xFFD94452);
const Color _lily = Color(0xFF8E44AD);
const Color _gardenText = Color(0xFF2F5D34);

/// Resumo de um dia do jardim.
class _DayInfo {
  int count = 0;
  bool rosary = false;
  bool confession = false;
  bool novena = false;
  bool mass = false;
}

/// Jardim de exemplo mostrado durante o guia do app: um ano de perseverança,
/// cada vez mais verde e florido. Não toca nos dados reais.
class GardenDemo {
  static final active = ValueNotifier<bool>(false);
}

Map<DateTime, _DayInfo> _demoDayInfo(DateTime startDate, DateTime today) {
  final rnd = math.Random(7);
  final info = <DateTime, _DayInfo>{};
  final total = today.difference(startDate).inDays + 1;
  for (var i = 0; i < total; i++) {
    final d = DateTime(startDate.year, startDate.month, startDate.day + i);
    final p = i / total; // perseverança: quanto mais perto de hoje, mais vivo
    final day = _DayInfo();
    if (rnd.nextDouble() < 0.55 + 0.43 * p || i == total - 1) {
      day.count = 1 + rnd.nextInt(2 + (4 * p).round());
      day.rosary = rnd.nextDouble() < 0.3 + 0.55 * p;
    }
    if (d.weekday == DateTime.sunday && rnd.nextDouble() < 0.75 + 0.25 * p) day.mass = true;
    if (d.weekday == DateTime.saturday && d.day <= 7) day.confession = true;
    final inMonth = (d.month % 2 == 0) && d.day >= 10 && d.day < 19;
    if (inMonth) day.novena = true;
    info[d] = day;
  }
  return info;
}

/// Viço do gramado de 0 (seco) a 1 (totalmente verde).
double _lushness(_DayInfo? info) {
  if (info == null) return 0;
  if (info.mass || info.confession) return 1.0; // sacramento: gramado hidratado
  final prayers = info.count + (info.novena ? 1 : 0) + (info.rosary && info.count == 0 ? 1 : 0);
  if (prayers <= 0) return 0;
  return math.min(0.3 + 0.15 * (prayers - 1), 0.75);
}

/// Jardim da Alma: cada dia das últimas 52 semanas é um gramado. Cada oração
/// feita planta uma florzinha nele; o terço dá uma rosa, a missa uma flor
/// dourada, a confissão um lírio e a novena uma vela.
///
/// A grade é desenhada por um único [CustomPainter] (em vez de ~380 widgets),
/// e os dados de cada dia são calculados em uma passada só. Isso mantém a
/// rolagem da página fluida. Toque em um dia para ver os detalhes.
class GardenHeatmap extends StatefulWidget {
  const GardenHeatmap({super.key});

  @override
  State<GardenHeatmap> createState() => _GardenHeatmapState();
}

class _GardenHeatmapState extends State<GardenHeatmap> {
  static const int _totalWeeks = 54; // 52 semanas + atual + 1 futura
  static const double _cell = 20.0;
  static const double _margin = 2.0;
  static const double _pitch = _cell + _margin * 2;
  static const double _monthLabelHeight = 14.0;
  static const double _monthLabelSpacing = 4.0;
  static const double _gridTop = _monthLabelHeight + _monthLabelSpacing;

  final ScrollController _scrollController = ScrollController();
  DateTime? _selected;

  @override
  void initState() {
    super.initState();
    // Rola até o fim (hoje) depois do primeiro quadro.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  static DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  // Cálculo dos 378 dias guardado: tocar num dia só muda a seleção. É refeito
  // quando os dados mudam (os providers avisam por didChangeDependencies) ou
  // quando vira o dia.
  Map<DateTime, _DayInfo>? _dayInfoCache;
  DateTime? _dayInfoStart;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _dayInfoCache = null;
  }

  Map<DateTime, _DayInfo> _cachedDayInfo(
    PrayerProvider prayers,
    ConfessionProvider confessions,
    DateTime startDate,
  ) {
    if (_dayInfoCache == null || _dayInfoStart != startDate) {
      _dayInfoCache = _buildDayInfo(prayers, confessions, startDate);
      _dayInfoStart = startDate;
    }
    return _dayInfoCache!;
  }

  Map<DateTime, _DayInfo> _buildDayInfo(
    PrayerProvider prayers,
    ConfessionProvider confessions,
    DateTime startDate,
  ) {
    final info = <DateTime, _DayInfo>{};
    _DayInfo at(DateTime d) => info.putIfAbsent(_dateOnly(d), _DayInfo.new);

    prayers.getHeatmapData().forEach((date, count) => at(date).count = count);

    // Terço marcado no plano do dia (chave: yyyyMMdd_idDaOração)
    prayers.dailyPrayers.forEach((key, value) {
      if (value == 1 && key.length > 8 && key.contains('rosary')) {
        final y = int.tryParse(key.substring(0, 4));
        final m = int.tryParse(key.substring(4, 6));
        final d = int.tryParse(key.substring(6, 8));
        if (y != null && m != null && d != null) at(DateTime(y, m, d)).rosary = true;
      }
    });

    // Terço registrado no histórico de orações
    for (final log in prayers.prayerLogs) {
      final prayerId = log['prayerId'] ?? '';
      if (!prayerId.startsWith('rosary')) continue;
      final ts = DateTime.tryParse(log['timestamp'] ?? '');
      if (ts != null) at(ts).rosary = true;
    }

    for (final d in prayers.massDates) {
      at(d).mass = true;
    }

    for (final entry in confessions.confessionHistory) {
      at(entry['date'] as DateTime).confession = true;
    }

    final endDate = startDate.add(const Duration(days: _totalWeeks * 7));
    for (var d = startDate; d.isBefore(endDate); d = d.add(const Duration(days: 1))) {
      if (prayers.getNovenasForDate(d).isNotEmpty) at(d).novena = true;
    }
    return info;
  }

  String _summary(AppLocalizations l10n, DateTime date, _DayInfo? info) {
    final parts = <String>[
      fmtDayMonth(context, date),
      '${info?.count ?? 0} ${l10n.heatmapPrayersLabel}',
      if (info?.rosary ?? false) l10n.heatmapRosaryLabel,
      if (info?.confession ?? false) l10n.heatmapConfessionLabel,
      if (info?.novena ?? false) l10n.heatmapNovenaLabel,
      if (info?.mass ?? false) l10n.heatmapMassLabel,
    ];
    return parts.join(' · ');
  }

  /// Nomes das orações feitas no dia (plano marcado + histórico), sem repetir.
  List<String> _doneTitles(PrayerProvider prayers, DateTime date) {
    final out = <String>[];
    final seen = <String>{};
    void add(String? title) {
      if (title == null || title.trim().isEmpty) return;
      if (seen.add(title.trim().toLowerCase())) out.add(title.trim());
    }

    final key = DateFormat('yyyyMMdd').format(date);
    final novenas = NovenaData.getAllNovenas(context);
    prayers.dailyPrayers.forEach((k, v) {
      if (v != 1 || !k.startsWith('${key}_')) return;
      final id = k.substring(key.length + 1);
      final novenaId = id.contains('_day_') ? id.substring(0, id.indexOf('_day_')) : null;
      if (novenaId != null) {
        for (final n in novenas) {
          if (n.id == novenaId) add(n.title);
        }
        return;
      }
      final planned = prayers.availablePrayers.where((p) => p['id'] == id);
      if (planned.isNotEmpty) {
        add(PrayerData.localizedPlanTitle(context, planned.first));
      } else {
        add(PrayerData.getPrayerById(context, id)?['title'] as String?);
      }
    });

    for (final log in prayers.prayerLogs) {
      final ts = DateTime.tryParse(log['timestamp'] ?? '');
      if (ts == null || _dateOnly(ts) != date) continue;
      add(PrayerData.localizedLogTitle(context, log));
    }
    return out;
  }

  @override
  Widget build(BuildContext context) {
    // Escuta os dados aqui (no contexto do próprio Jardim) para que uma
    // mudança chegue a didChangeDependencies e refaça o cálculo dos dias.
    Provider.of<PrayerProvider>(context);
    Provider.of<ConfessionProvider>(context);
    return ValueListenableBuilder<bool>(
      valueListenable: GardenDemo.active,
      builder: (context, demo, _) => _buildGarden(context, demo),
    );
  }

  Widget _buildGarden(BuildContext context, bool demo) {
    final l10n = AppLocalizations.of(context)!;
    final prayerProvider = Provider.of<PrayerProvider>(context);
    final confessionProvider = Provider.of<ConfessionProvider>(context);

    final now = DateTime.now();
    // Alinha ao domingo da semana atual (linhas D, S, T, Q, Q, S, S).
    final thisSunday = _dateOnly(now).subtract(Duration(days: now.weekday % 7));
    final startDate = thisSunday.subtract(const Duration(days: 52 * 7));

    final today = _dateOnly(now);
    final dayInfo = demo
        ? _demoDayInfo(startDate, today)
        : _cachedDayInfo(prayerProvider, confessionProvider, startDate);
    final selected = demo ? null : _selected;
    final daysWithPrayer = dayInfo.values.where((i) => i.count > 0).length;
    // Tempo litúrgico: a cor do tempo aparece na borda e na etiqueta do Jardim
    final season = LiturgicalCalendar.getSeason(now);
    final seasonColor = LiturgicalCalendar.getSeasonColor(season);
    final seasonName = LiturgicalCalendar.getSeasonName(l10n, season);

    // herda a fonte do app (o TextPainter do desenho não herda sozinho)
    final monthStyle = DefaultTextStyle.of(context).style.copyWith(fontSize: 11, color: const Color(0xFF7A6A4F));

    return RepaintBoundary(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF4F9EC), Color(0xFFE6F1D9)],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: seasonColor.withValues(alpha: 0.55), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.gardenTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: _gardenText,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Selo do tempo litúrgico encostado à direita (largura própria,
                // limitada para nomes longos não empurrarem o título).
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 170),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: seasonColor.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: seasonColor.withValues(alpha: 0.5)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(color: seasonColor, shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            seasonName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _gardenText),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              l10n.gardenSubtitle,
              style: const TextStyle(fontSize: 13, color: AppColors.secondaryText),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 14.0,
              runSpacing: 6.0,
              children: [
                _legend(_Glyph.rose, l10n.heatmapRosaryLabel),
                _legend(_Glyph.lily, l10n.heatmapConfessionLabel),
                _legend(_Glyph.candle, l10n.heatmapNovenaLabel),
                _legend(_Glyph.gold, l10n.heatmapMassLabel),
              ],
            ),
            const SizedBox(height: 14),
            Semantics(
              label: l10n.gardenSemantics(daysWithPrayer),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rótulos dos dias (fixos, à esquerda)
                  ExcludeSemantics(
                    child: Column(
                      children: [
                        const SizedBox(height: _gridTop),
                        for (final d in weekdayInitials(context))
                          Container(
                            height: _cell,
                            margin: const EdgeInsets.symmetric(vertical: _margin),
                            alignment: Alignment.center,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                d,
                                style: const TextStyle(fontSize: 11, color: Color(0xFF7A6A4F)),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Grade rolável
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTapUp: demo ? null : (details) {
                          final col = (details.localPosition.dx / _pitch).floor();
                          final row = ((details.localPosition.dy - _gridTop) / _pitch).floor();
                          if (col < 0 || col >= _totalWeeks || row < 0 || row > 6) return;
                          final date = startDate.add(Duration(days: col * 7 + row));
                          setState(() => _selected = _selected == date ? null : date);
                        },
                        child: CustomPaint(
                          size: Size(_totalWeeks * _pitch, _gridTop + 7 * _pitch),
                          painter: _GardenPainter(
                            startDate: startDate,
                            today: today,
                            selected: selected,
                            dayInfo: dayInfo,
                            monthStyle: monthStyle,
                            monthLabel: (d) => DateFormat('MMM', Localizations.localeOf(context).toString()).format(d),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            if (selected != null) ...[
              Semantics(
                liveRegion: true,
                child: Text(
                  _summary(l10n, selected, dayInfo[selected]),
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primaryText),
                ),
              ),
              Builder(builder: (_) {
                final titles = _doneTitles(prayerProvider, selected);
                if (titles.isEmpty) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    titles.join(' · '),
                    style: const TextStyle(fontSize: 13, height: 1.35, color: AppColors.secondaryText),
                  ),
                );
              }),
              if (!selected.isAfter(today))
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () => prayerProvider.toggleMass(selected),
                    icon: Icon(
                      (dayInfo[selected]?.mass ?? false) ? Icons.remove_circle_outline : Icons.local_florist,
                      size: 18,
                      color: _gardenGold,
                    ),
                    label: Text(
                      (dayInfo[selected]?.mass ?? false) ? l10n.massUnmarkDay : l10n.massMarkDay,
                      style: const TextStyle(color: AppColors.primaryText),
                    ),
                  ),
                ),
            ] else if (demo)
              Container(
                key: const ValueKey('garden_demo_banner'),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: _grassLush.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  l10n.gardenDemoHint,
                  style: const TextStyle(fontSize: 12.5, height: 1.35, color: _gardenText, fontWeight: FontWeight.w600),
                ),
              )
            else
              Text(
                l10n.gardenGrowthHint,
                style: const TextStyle(fontSize: 12, height: 1.35, color: AppColors.secondaryText),
              ),
          ],
        ),
      ),
    );
  }

  Widget _legend(_Glyph glyph, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomPaint(size: const Size(22, 22), painter: _GlyphPainter(glyph)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.primaryText)),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Desenho das florzinhas e símbolos (compartilhado pela grade e pela legenda)
// ---------------------------------------------------------------------------

enum _Glyph { rose, lily, candle, gold }

const List<Color> _blossomColors = [
  Color(0xFFF7A8BA), // rosa
  Color(0xFFFFFFFF), // branca
  Color(0xFFC9B6F2), // lilás
  Color(0xFFFFE082), // amarela
];

// Posições (fração do gramado) onde as florzinhas são plantadas.
const List<Offset> _slots = [
  Offset(0.30, 0.32),
  Offset(0.70, 0.32),
  Offset(0.50, 0.58),
  Offset(0.27, 0.78),
  Offset(0.73, 0.78),
  Offset(0.50, 0.17),
];

void _drawBlossom(Canvas canvas, Offset c, Color color, Paint fill) {
  fill.color = color;
  canvas.drawCircle(c, 2.0, fill);
  fill.color = const Color(0xFFFFC94D);
  canvas.drawCircle(c, 0.7, fill);
}

void _drawRose(Canvas canvas, Offset c, Paint fill, {double s = 1.0}) {
  fill.color = _roseRed;
  canvas.drawCircle(c, 3.0 * s, fill);
  final ring = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 0.8 * s
    ..color = const Color(0xFF9E2431);
  canvas.drawCircle(c, 1.7 * s, ring);
}

void _drawGold(Canvas canvas, Offset c, Paint fill, {double s = 1.0}) {
  fill.color = _gardenGold;
  for (var i = 0; i < 5; i++) {
    final a = i * 2 * math.pi / 5 - math.pi / 2;
    canvas.drawCircle(c + Offset(math.cos(a), math.sin(a)) * 2.4 * s, 1.9 * s, fill);
  }
  fill.color = Colors.white;
  canvas.drawCircle(c, 1.2 * s, fill);
}

void _drawLily(Canvas canvas, Offset c, Paint fill, {double s = 1.0}) {
  fill.color = _lily;
  canvas.drawCircle(c + Offset(-1.3, 0.6) * s, 1.5 * s, fill);
  canvas.drawCircle(c + Offset(1.3, 0.6) * s, 1.5 * s, fill);
  canvas.drawCircle(c + Offset(0, -1.2) * s, 1.5 * s, fill);
}

void _drawCandle(Canvas canvas, Offset c, Paint fill, {double s = 1.0}) {
  fill.color = const Color(0xFFFFF8E1);
  canvas.drawRRect(
    RRect.fromRectAndRadius(
      Rect.fromCenter(center: c + Offset(0, 1.3 * s), width: 2.4 * s, height: 4.2 * s),
      Radius.circular(0.7 * s),
    ),
    fill,
  );
  fill.color = const Color(0xFFFFB300);
  canvas.drawOval(Rect.fromCenter(center: c + Offset(0, -1.6 * s), width: 2.0 * s, height: 2.8 * s), fill);
}

/// Símbolo da legenda, com o mesmo desenho usado na grade (ampliado).
class _GlyphPainter extends CustomPainter {
  final _Glyph glyph;
  _GlyphPainter(this.glyph);

  @override
  void paint(Canvas canvas, Size size) {
    final fill = Paint();
    final c = size.center(Offset.zero);
    switch (glyph) {
      case _Glyph.rose:
        _drawRose(canvas, c, fill, s: 1.7);
        break;
      case _Glyph.gold:
        _drawGold(canvas, c, fill, s: 1.7);
        break;
      case _Glyph.lily:
        _drawLily(canvas, c, fill, s: 1.9);
        break;
      case _Glyph.candle:
        _drawCandle(canvas, c, fill, s: 1.9);
        break;
    }
  }

  @override
  bool shouldRepaint(_GlyphPainter old) => old.glyph != glyph;
}

class _GardenPainter extends CustomPainter {
  final DateTime startDate;
  final DateTime today;
  final DateTime? selected;
  final Map<DateTime, _DayInfo> dayInfo;
  final TextStyle monthStyle;
  final String Function(DateTime) monthLabel;

  _GardenPainter({
    required this.startDate,
    required this.today,
    required this.selected,
    required this.dayInfo,
    required this.monthStyle,
    required this.monthLabel,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const cell = _GardenHeatmapState._cell;
    const margin = _GardenHeatmapState._margin;
    const pitch = _GardenHeatmapState._pitch;
    const gridTop = _GardenHeatmapState._gridTop;
    const weeks = _GardenHeatmapState._totalWeeks;

    final fill = Paint()..style = PaintingStyle.fill;
    final stroke = Paint()..style = PaintingStyle.stroke;
    final tuft = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    for (var w = 0; w < weeks; w++) {
      final weekStart = startDate.add(Duration(days: w * 7));

      // Rótulo do mês: só na primeira semana de cada mês
      if (weekStart.day <= 7) {
        final tp = TextPainter(
          text: TextSpan(text: monthLabel(weekStart), style: monthStyle),
          textDirection: ui.TextDirection.ltr,
          maxLines: 1,
        )..layout();
        tp.paint(canvas, Offset(w * pitch, 0));
      }

      for (var d = 0; d < 7; d++) {
        final date = startDate.add(Duration(days: w * 7 + d));
        final info = dayInfo[date];
        final isFuture = date.isAfter(today);
        final hasLife = !isFuture &&
            info != null &&
            (info.count > 0 || info.rosary || info.mass || info.confession || info.novena);

        final rect = RRect.fromRectAndRadius(
          Rect.fromLTWH(w * pitch + margin, gridTop + d * pitch + margin, cell, cell),
          const Radius.circular(6),
        );

        // Gramado: do seco amarelado ao verde viçoso; futuro apagado
        final lush = isFuture ? 0.0 : _lushness(info);
        final grass = Color.lerp(_grassDry, _grassLush, lush)!;
        fill.color = isFuture ? grass.withValues(alpha: 0.4) : grass;
        canvas.drawRRect(rect, fill);

        final isToday = date == today;
        final isSelected = date == selected;
        if (isToday || isSelected) {
          stroke
            ..color = isSelected ? _gardenText : _gardenGold
            ..strokeWidth = 2;
          canvas.drawRRect(rect, stroke);
        } else if (!isFuture) {
          stroke
            ..color = Color.lerp(_grassDryBorder, _grassLushTuft.withValues(alpha: 0.6), lush)!
            ..strokeWidth = 0.6;
          canvas.drawRRect(rect, stroke);
        }

        if (!hasLife) continue;
        final r = rect.outerRect;

        // Tufos de grama na base (dão textura sem poluir)
        tuft.color = Color.lerp(_grassDryTuft, _grassLushTuft, lush)!;
        canvas.drawLine(Offset(r.left + 4, r.bottom - 1.5), Offset(r.left + 5, r.bottom - 4), tuft);
        canvas.drawLine(Offset(r.right - 5, r.bottom - 1.5), Offset(r.right - 4, r.bottom - 4), tuft);

        // Uma florzinha por oração (até 6 posições). A missa fica no centro;
        // terço, confissão e novena vêm antes das orações comuns.
        Offset at(int i) => Offset(r.left + _slots[i].dx * cell, r.top + _slots[i].dy * cell);
        if (info.mass) _drawGold(canvas, at(2), fill, s: 1.15);
        const order = [0, 1, 3, 4, 5, 2]; // o centro fica por último
        var next = 0;
        int? take() {
          while (next < order.length) {
            final s = order[next++];
            if (s == 2 && info.mass) continue;
            return s;
          }
          return null;
        }

        void place(void Function(Offset) draw) {
          final s = take();
          if (s != null) draw(at(s));
        }

        if (info.rosary) place((o) => _drawRose(canvas, o, fill));
        if (info.confession) place((o) => _drawLily(canvas, o, fill));
        if (info.novena) place((o) => _drawCandle(canvas, o, fill, s: 0.9));
        final generic = info.rosary ? math.max(info.count - 1, 0) : info.count;
        for (var k = 0; k < generic; k++) {
          final s = take();
          if (s == null) break;
          _drawBlossom(canvas, at(s), _blossomColors[k % _blossomColors.length], fill);
        }
      }
    }
  }

  @override
  bool shouldRepaint(_GardenPainter old) =>
      old.dayInfo != dayInfo ||
      old.selected != selected ||
      old.today != today ||
      old.startDate != startDate;
}
