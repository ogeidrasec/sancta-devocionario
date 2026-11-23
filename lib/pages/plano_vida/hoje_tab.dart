import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/data/prayer_data.dart';
import 'package:sanctaconscientia/utils/liturgical_calendar.dart';
import '../../../providers/prayer_provider.dart';
import '../../../providers/confession_provider.dart';
import '../../../providers/settings_provider.dart';
import '../../../providers/liturgical_provider.dart';
import '../../../data/novena_data.dart';
import '../plano_vida_page.dart';
import '../rosary_mysteries_page.dart';
import '../rosary_prayer_page.dart';
import 'widgets/garden_heatmap.dart';
import 'widgets/prayer_tile.dart';
import 'widgets/stat_card.dart';
import 'package:sanctaconscientia/widgets/day_record.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';
import 'package:sanctaconscientia/widgets/novena_suggestion_card.dart';
import 'package:sanctaconscientia/widgets/support_nudge_card.dart';
import 'package:sanctaconscientia/widgets/app_tour.dart';
import 'package:sanctaconscientia/services/haptics_service.dart';
import 'package:sanctaconscientia/widgets/petal_shower.dart';
import 'package:sanctaconscientia/widgets/confession_confirmation_dialog.dart';
import 'package:sanctaconscientia/widgets/spiritual_growth_card.dart';

/// Aba "Hoje": o que ainda falta fazer e, separado, tudo o que já foi feito.
class HojeTab extends StatelessWidget {
  const HojeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final prayerProvider = Provider.of<PrayerProvider>(context);
    final confessionProvider = Provider.of<ConfessionProvider>(context);
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final liturgicalProvider = Provider.of<LiturgicalProvider>(context);
    final today = DateTime.now();
    final todayKey = DateFormat('yyyyMMdd').format(today);

    final plan = prayerProvider.availablePrayers;
    final todaysLogs = prayerProvider.prayerLogs.where((log) {
      final t = DateTime.tryParse(log['timestamp'] ?? '');
      return t != null && DateFormat('yyyyMMdd').format(t) == todayKey;
    }).toList();

    // ---------------- O que falta fazer ----------------
    final isNextConfessionToday = confessionProvider.nextConfessionDate != null &&
        _isSameDay(confessionProvider.nextConfessionDate!, today);
    final confessedToday = confessionProvider.dataUltimaConfissao != null &&
        _isSameDay(confessionProvider.dataUltimaConfissao!, today);

    // Penitências: pendentes (e as cumpridas na última semana, que ficam em "feito")
    final weekAgo = today.subtract(const Duration(days: 7));
    final penances = confessionProvider.confessionHistory.where((c) {
      final note = c['penanceNote'] as String?;
      return note != null && note.isNotEmpty;
    }).toList();
    final pendingPenances = penances.where((c) => !(c['penanceCompleted'] as bool? ?? false)).toList();
    final donePenances = penances.where((c) {
      if (!(c['penanceCompleted'] as bool? ?? false)) return false;
      final date = c['date'];
      return date is DateTime && date.isAfter(weekAgo);
    }).toList();

    final pendingNovenas = prayerProvider
        .getNovenasForDate(today)
        .where((n) =>
            prayerProvider.isNovenaActive(n['id'] as String) &&
            !prayerProvider.isDailyPrayerCompleted(todayKey, '${n['id']}_day_${n['day']}'))
        .toList();

    final pendingPrayers = <PrayerListItem>[
      for (final p in plan)
        if (!prayerProvider.isDailyPrayerCompleted(todayKey, p['id']!))
          PrayerListItem(
            id: p['id']!,
            title: PrayerData.localizedPlanTitle(context, p),
            type: PrayerType.planned,
            isCompleted: false,
            time: p['defaultTime'],
          ),
    ];
    final morning = pendingPrayers.where((p) => p.time == 'morning').toList();
    final noon = pendingPrayers.where((p) => p.time == 'noon').toList();
    final anytime = pendingPrayers.where((p) => p.time == 'anytime' || p.time == null).toList();
    final night = pendingPrayers.where((p) => p.time == 'night').toList();

    final hasPending = (isNextConfessionToday && !confessedToday) ||
        pendingPenances.isNotEmpty ||
        pendingNovenas.isNotEmpty ||
        pendingPrayers.isNotEmpty;

    // ---------------- O que já foi feito ----------------
    final done = <DayEntry>[];

    if (prayerProvider.hasMassOn(today)) {
      done.add(DayEntry(
        kind: DayEntryKind.mass,
        title: l10n.massCardDoneTitle,
        onUndo: () => prayerProvider.toggleMass(today),
      ));
    }
    if (confessedToday) {
      done.add(DayEntry(kind: DayEntryKind.confession, title: l10n.confessionConfirmed));
    }
    for (final c in donePenances) {
      done.add(DayEntry(
        kind: DayEntryKind.penance,
        title: c['penanceNote'] as String,
        onUndo: () => confessionProvider.togglePenanceCompleted(c['id'] as int, false),
      ));
    }

    final logEntries = [
      for (final log in todaysLogs) DayEntry.fromLog(context, prayerProvider, log),
    ];
    logEntries.sort((a, b) => b.time!.compareTo(a.time!)); // mais recente primeiro
    done.addAll(logEntries);

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: TourAnchor(
        ref: AppTourKeys.addButton,
        child: FloatingActionButton(
        onPressed: () => PlanoVidaPage.showPrayerSelectionDialog(context, today),
        backgroundColor: AppColors.accentGold,
        child: const Icon(Icons.add, color: AppColors.primaryText),
      )),
      body: Builder(builder: (context) {
        // Rolagem ligada ao cabeçalho do Jardim (NestedScrollView); o guia
        // usa este mesmo controle para voltar ao topo.
        AppTourScroll.today = PrimaryScrollController.of(context);
        return ListView(
        primary: true,
        // espaço extra embaixo: o botão + não cobre o último cartão
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
        children: [
          // Jardim da Alma (heatmap): é o coração do app, fica no topo
          TourAnchor(ref: AppTourKeys.garden, child: const GardenHeatmap()),
          // O que já foi feito hoje: resumo discreto, abre ao tocar
          if (done.isNotEmpty) ...[
            const SizedBox(height: 10),
            _DoneTodayStrip(entries: done),
          ],
          const SizedBox(height: 12),
          // Resumo de evolução, sequências e próxima meta
          TourAnchor(ref: AppTourKeys.growth, child: const SpiritualGrowthCard()),
          const SizedBox(height: 20),

          // O dia: calendário litúrgico e santo do dia
          _buildLiturgicalInfo(context, liturgicalProvider),
          _buildSaintOfTheDay(context),

          // Devoções do dia: terço e missa
          _buildRosaryShortcut(context, settingsProvider, prayerProvider),
          const SizedBox(height: 10),
          _buildMassCard(context, prayerProvider, settingsProvider),
          const SizedBox(height: 22),

          // ---------- PARA HOJE ----------
          SectionLabel(l10n.todaySectionPending),
          if (isNextConfessionToday && !confessedToday) _buildConfessionCard(context, confessionProvider),
          for (final c in pendingPenances)
            _buildPenanceCard(context, confessionProvider, c['id'] as int, c['penanceNote'] as String),
          const NovenaSuggestions(),
          for (final n in pendingNovenas)
            _buildNovenaCard(
              context,
              prayerProvider,
              todayKey,
              n['id'] as String,
              n['day'] as int,
            ),
          if (morning.isNotEmpty)
            _buildTimeSection(context, l10n.timeMorning, Icons.wb_sunny_outlined, morning, todayKey, prayerProvider, settingsProvider),
          if (noon.isNotEmpty)
            _buildTimeSection(context, l10n.timeNoon, Icons.wb_sunny, noon, todayKey, prayerProvider, settingsProvider),
          if (anytime.isNotEmpty)
            _buildTimeSection(context, l10n.timeAnytime, Icons.access_time, anytime, todayKey, prayerProvider, settingsProvider),
          if (night.isNotEmpty)
            _buildTimeSection(context, l10n.timeNight, Icons.nights_stay_outlined, night, todayKey, prayerProvider, settingsProvider),
          if (!hasPending)
            done.isEmpty ? _buildEmptyState(context) : _InfoLine(text: l10n.todayAllDone),

          const SizedBox(height: 14),

          // Números do dia e da semana
          // Lembrete gentil de apoio ao projeto (só de tempos em tempos)
          const SupportNudgeCard(),
          _buildQuickStats(context, prayerProvider, today),
          const SizedBox(height: 80),
        ],
      );
      }),
    );
  }

  // ---------------------------------------------------------------------
  // Para hoje
  // ---------------------------------------------------------------------

  /// Cartão de ação (confissão, penitência, novena): ícone, textos e círculo.
  Widget _actionCard({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
    Widget? trailing,
    Widget? footer,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: appCardDecoration(tint: color),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleIcon(icon: icon, color: color, size: 44),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryText),
                            ),
                            const SizedBox(height: 2),
                            Text(subtitle, style: const TextStyle(fontSize: 13, height: 1.3, color: AppColors.secondaryText)),
                          ],
                        ),
                      ),
                      ?trailing,
                    ],
                  ),
                  ?footer,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNovenaCard(BuildContext context, PrayerProvider prayerProvider, String todayKey, String novenaId, int day) {
    final l10n = AppLocalizations.of(context)!;
    final title = _getNovenaTitle(context, novenaId);
    return _actionCard(
      icon: Icons.local_florist,
      color: AppColors.accentGold,
      title: title,
      subtitle: l10n.novenaDayProgress(day, 9),
      trailing: const Icon(Icons.circle_outlined, color: Colors.grey),
      onTap: () => prayerProvider.toggleDailyPrayer(
        todayKey,
        '${novenaId}_day_$day',
        title: '$title - ${l10n.novenaDay(day)}',
      ),
    );
  }

  Widget _buildConfessionCard(BuildContext context, ConfessionProvider confessionProvider) {
    final l10n = AppLocalizations.of(context)!;
    return _actionCard(
      icon: Icons.volunteer_activism,
      color: Colors.purple,
      title: l10n.confessionCardTitle,
      subtitle: l10n.confessionTodaySubtitle,
      onTap: () => _showConfirmConfessionDialog(context, confessionProvider),
      footer: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () => _showConfirmConfessionDialog(context, confessionProvider),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.themeColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            child: Text(l10n.confessionMarkComplete),
          ),
        ),
      ),
    );
  }

  Widget _buildPenanceCard(BuildContext context, ConfessionProvider confessionProvider, int confessionId, String penanceNote) {
    final l10n = AppLocalizations.of(context)!;
    return _actionCard(
      icon: Icons.assignment_turned_in,
      color: Colors.orange,
      title: l10n.penanceLabel,
      subtitle: penanceNote,
      trailing: const Icon(Icons.circle_outlined, color: Colors.grey),
      onTap: () async {
        await confessionProvider.togglePenanceCompleted(confessionId, true);
        if (!context.mounted) return;
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(
              content: Text(l10n.penanceMarkedDone),
              action: SnackBarAction(
                label: l10n.undoAction,
                textColor: AppColors.accentGold,
                onPressed: () => confessionProvider.togglePenanceCompleted(confessionId, false),
              ),
              duration: const Duration(seconds: 4),
            ),
          );
      },
    );
  }

  void _showConfirmConfessionDialog(BuildContext context, ConfessionProvider confessionProvider) async {
    final result = await showDialog<ConfessionConfirmationResult>(
      context: context,
      builder: (ctx) => const ConfessionConfirmationDialog(),
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

  Widget _buildTimeSection(BuildContext context, String title, IconData icon, List<PrayerListItem> prayers, String dateKey, PrayerProvider prayerProvider, SettingsProvider settingsProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 6, 4, 8),
          child: Row(
            children: [
              Icon(icon, color: AppColors.accentGold, size: 18),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const Expanded(child: Divider(indent: 12)),
            ],
          ),
        ),
        ...prayers.map((prayer) => PrayerTile(
              prayer: prayer,
              dateKey: dateKey,
              prayerProvider: prayerProvider,
              isTraditionalRosary: settingsProvider.isTraditionalRosary,
            )),
        const SizedBox(height: 6),
      ],
    );
  }

  // ---------------------------------------------------------------------
  // Devoções e informações do dia
  // ---------------------------------------------------------------------

  Widget _buildRosaryShortcut(BuildContext context, SettingsProvider settings, PrayerProvider prayers) {
    final l10n = AppLocalizations.of(context)!;
    final type = RosaryMysteriesPage.todaysMystery(settings.isTraditionalRosary);
    final mysteryName = switch (type) {
      MysteryType.joyful => l10n.mysteryJoyfulTitle,
      MysteryType.sorrowful => l10n.mysterySorrowfulTitle,
      MysteryType.glorious => l10n.mysteryGloriousTitle,
      MysteryType.luminous => l10n.mysteryLuminousTitle,
    };
    final per = PrayerProvider.chapletsPerRosary(traditional: settings.isTraditionalRosary);
    final count = prayers.chapletsToday;
    final progress = count > 0 && count % per == 0 ? l10n.rosaryFullComplete : l10n.rosaryProgress(count % per, per);

    return Container(
      decoration: appCardDecoration(tint: AppColors.accentGold),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => RosaryPrayerPage(mysteryType: type)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                const CircleIcon(icon: Icons.auto_awesome, color: AppColors.accentGold, size: 44),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.todayRosaryCardTitle,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryText),
                      ),
                      const SizedBox(height: 2),
                      Text(mysteryName, style: const TextStyle(fontSize: 13, color: AppColors.secondaryText)),
                      Text(progress, style: const TextStyle(fontSize: 12, color: AppColors.secondaryText)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.accentGold),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMassCard(BuildContext context, PrayerProvider prayers, SettingsProvider settings) {
    final l10n = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final done = prayers.hasMassOn(now);
    const gold = Color(0xFFB7791F);

    final extra = <String>[
      if (prayers.massCountInMonth(now) > 0) l10n.massMonthCount(prayers.massCountInMonth(now)),
      if (prayers.sundayMassStreak >= 2) l10n.massSundayStreak(prayers.sundayMassStreak),
    ];
    final subtitle = done
        ? l10n.massCardDoneSubtitle
        : (now.weekday == DateTime.sunday ? l10n.massCardSubtitleSunday : l10n.massCardSubtitle);

    return Container(
      decoration: appCardDecoration(tint: gold).copyWith(
        color: done ? const Color(0xFFFFF8E6) : Colors.white,
        border: Border.all(color: gold.withValues(alpha: done ? 0.6 : 0.15), width: done ? 1.5 : 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () async {
            final marked = await prayers.toggleMass(now);
            if (!context.mounted) return;
            final messenger = ScaffoldMessenger.of(context);
            messenger.clearSnackBars();
            if (marked) {
              if (settings.hapticsEnabled) HapticsService.play(HapticKind.medium);
              showPetalShower(context);
            }
            messenger.showSnackBar(
              SnackBar(
                content: Text(marked ? l10n.massMarkedSnack : l10n.massUnmarkedSnack),
                action: SnackBarAction(
                  label: l10n.undoAction,
                  textColor: AppColors.accentGold,
                  onPressed: () => prayers.toggleMass(now),
                ),
                duration: const Duration(seconds: 4),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                CircleIcon(icon: done ? Icons.local_florist : Icons.church, color: gold, size: 44),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        done ? l10n.massCardDoneTitle : l10n.massCardTitle,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryText),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        extra.isEmpty ? subtitle : '$subtitle\n${extra.join(' · ')}',
                        style: const TextStyle(fontSize: 13, height: 1.3, color: AppColors.secondaryText),
                      ),
                    ],
                  ),
                ),
                Icon(
                  done ? Icons.check_circle : Icons.circle_outlined,
                  color: done ? AppColors.successColor : Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context, PrayerProvider prayerProvider, DateTime today) {
    final weeklyCount = prayerProvider.getWeeklyPrayerCount();
    final todayCount = prayerProvider.getDailyPrayerCount(today);

    return Row(
      children: [
        Expanded(
          child: StatCard(
            icon: Icons.today,
            value: '$todayCount',
            label: AppLocalizations.of(context)!.statsToday,
            color: AppColors.themeColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatCard(
            icon: Icons.date_range,
            value: '$weeklyCount',
            label: AppLocalizations.of(context)!.statsThisWeek,
            color: AppColors.accentGold,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(Icons.local_florist_outlined, size: 56, color: Colors.grey),
            const SizedBox(height: 14),
            Text(
              l10n.planEmptyTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey, fontSize: 17),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.planEmptySubtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => PlanoVidaPage.showPrayerSelectionDialog(context, DateTime.now()),
              icon: const Icon(Icons.add),
              label: Text(l10n.addPrayerTitle),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.themeColor,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Cartão informativo do dia (calendário litúrgico e santo do dia).
  Widget _infoCard({required IconData icon, required Color color, required String label, required String text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: appCardDecoration(tint: color),
        child: Row(
          children: [
            CircleIcon(icon: icon, color: color, size: 44),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    text,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryText),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaintOfTheDay(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final feastName = LiturgicalCalendar.getFeastName(DateTime.now(), l10n);
    if (feastName == null) return const SizedBox.shrink();
    return _infoCard(
      icon: Icons.star,
      color: AppColors.accentGold,
      label: l10n.saintOfTheDay,
      text: feastName,
    );
  }

  Widget _buildLiturgicalInfo(BuildContext context, LiturgicalProvider provider) {
    final today = DateTime.now();
    final info = provider.getLiturgicalInfo(context, today);
    if (info == null) return const SizedBox.shrink();

    var icon = Icons.info_outline;
    var color = AppColors.themeColor;
    if (provider.isDayOfPrecept(today)) {
      icon = Icons.church;
    } else if (provider.isDayOfFasting(today)) {
      icon = Icons.restaurant_menu;
      color = Colors.purple;
    } else if (provider.isDayOfAbstinence(today)) {
      icon = Icons.restaurant;
      color = Colors.purple;
    }

    return _infoCard(
      icon: icon,
      color: color,
      label: AppLocalizations.of(context)!.liturgicalCalendarTitle,
      text: info,
    );
  }

  String _getNovenaTitle(BuildContext context, String novenaId) {
    try {
      return NovenaData.getNovenaById(context, novenaId).title;
    } catch (_) {
      return novenaId;
    }
  }

  static bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}

/// Frase curta de apoio dentro de uma seção (nada pendente / nada feito).
class _InfoLine extends StatelessWidget {
  final String text;
  const _InfoLine({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, height: 1.4, color: AppColors.secondaryText),
      ),
    );
  }
}

/// "Feito hoje" em uma linha discreta abaixo do Jardim: total e nomes;
/// ao tocar, mostra os itens (com desfazer).
class _DoneTodayStrip extends StatefulWidget {
  final List<DayEntry> entries;
  const _DoneTodayStrip({required this.entries});

  @override
  State<_DoneTodayStrip> createState() => _DoneTodayStripState();
}

class _DoneTodayStripState extends State<_DoneTodayStrip> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final names = widget.entries.map((e) => e.title).join(' · ');
    return Container(
      decoration: BoxDecoration(
        color: AppColors.successColor.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.successColor.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            key: const ValueKey('done_today_strip'),
            borderRadius: BorderRadius.circular(14),
            onTap: () => setState(() => _open = !_open),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, size: 18, color: AppColors.successColor),
                  const SizedBox(width: 8),
                  Text(
                    '${l10n.todaySectionDone} · ${widget.entries.length}',
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.successColor),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _open ? '' : names,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, color: AppColors.secondaryText),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _open ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.expand_more, size: 20, color: AppColors.secondaryText),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            alignment: Alignment.topCenter,
            child: _open
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
                    child: Column(children: [for (final e in widget.entries) DayEntryTile(entry: e)]),
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}
