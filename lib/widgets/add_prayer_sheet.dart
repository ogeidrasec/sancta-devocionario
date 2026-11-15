import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/data/novena_data.dart';
import 'package:sanctaconscientia/data/prayer_data.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/models/novena_content.dart';
import 'package:sanctaconscientia/pages/plano_vida_page.dart';
import 'package:sanctaconscientia/providers/settings_provider.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/utils/content_search.dart';
import 'package:sanctaconscientia/utils/date_text.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';
import 'package:sanctaconscientia/widgets/search_field.dart';

/// Folha única para adicionar uma oração, novena ou terço: usada pelo "+" de
/// Hoje, pelo Calendário (para o dia escolhido) e pelos Lembretes.
///
/// Uma busca no topo (acha oração e novena ao mesmo tempo) e três abas:
/// Orações, Novenas e Terço. O que acontece depois de escolher depende do dia:
/// - dia passado: registra como rezada naquele dia;
/// - hoje: pergunta se já rezou agora ou se quer adicionar ao plano;
/// - dia futuro: adiciona ao plano a partir daquele dia.
/// No modo lembrete, vai direto para o horário e a frequência do lembrete.
class AddPrayerSheet {
  AddPrayerSheet._();

  static Future<void> show(BuildContext context, DateTime date, {bool reminderMode = false}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.primaryBg,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (sheetContext, controller) => _Sheet(
          host: context,
          date: date,
          reminderMode: reminderMode,
          controller: controller,
        ),
      ),
    );
  }
}

class _Sheet extends StatefulWidget {
  final BuildContext host;
  final DateTime date;
  final bool reminderMode;
  final ScrollController controller;

  const _Sheet({
    required this.host,
    required this.date,
    required this.reminderMode,
    required this.controller,
  });

  @override
  State<_Sheet> createState() => _SheetState();
}

class _SheetState extends State<_Sheet> {
  final TextEditingController _search = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  static DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);

  bool get _isPast => _day(widget.date).isBefore(_day(DateTime.now()));
  bool get _isToday => _day(widget.date) == _day(DateTime.now());

  /// O que fazer com o item escolhido, conforme o dia (ver a descrição da classe).
  Future<void> _choose(Map<String, dynamic> prayer) async {
    final host = widget.host;
    final isNovena = (prayer['id'] as String?)?.startsWith('novena') ?? false;
    Navigator.pop(context); // fecha a folha

    if (widget.reminderMode) {
      await PlanoVidaPage.addPrayerToPlan(host, prayer, widget.date, reminderRequired: true);
      return;
    }
    if (_isToday && !isNovena) {
      final plan = await _askNowOrPlan(host, prayer['title'] as String);
      if (plan == null || !host.mounted) return;
      if (plan) {
        await PlanoVidaPage.addPrayerToPlan(host, prayer, widget.date);
      } else {
        PlanoVidaPage.logQuickPrayer(host, prayer);
      }
      return;
    }
    // dia passado (registra) ou futuro / novena (agenda)
    await PlanoVidaPage.addPrayerToPlan(host, prayer, widget.date);
  }

  /// Pergunta: "Rezei agora" (registra) ou "Adicionar ao meu plano". Retorna
  /// true para plano, false para registro e nulo se cancelou.
  Future<bool?> _askNowOrPlan(BuildContext host, String title) {
    final l10n = AppLocalizations.of(host)!;
    return showModalBottomSheet<bool>(
      context: host,
      backgroundColor: AppColors.primaryBg,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryText),
              ),
              const SizedBox(height: 16),
              _ChoiceTile(
                icon: Icons.check_circle_outline,
                color: AppColors.successColor,
                title: l10n.addNowTitle,
                description: l10n.addNowDesc,
                onTap: () => Navigator.pop(ctx, false),
              ),
              const SizedBox(height: 10),
              _ChoiceTile(
                icon: Icons.event_available,
                color: AppColors.themeColor,
                title: l10n.addPlanTitle,
                description: l10n.addPlanDesc,
                onTap: () => Navigator.pop(ctx, true),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final subtitle = widget.reminderMode
        ? l10n.addSheetReminderSubtitle
        : (_isPast
            ? l10n.addSheetSubtitlePast(fmtDayMonth(context, widget.date))
            : (_isToday ? l10n.addSheetSubtitleToday : l10n.addSheetSubtitleFuture(fmtDayMonth(context, widget.date))));

    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          // (a alça de arrastar vem do tema das folhas)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
            child: Column(
              children: [
                Text(
                  widget.reminderMode ? l10n.addSheetReminderTitle : l10n.addPrayerTitle,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryText),
                ),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(fontSize: 13, color: AppColors.secondaryText)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
            child: AppSearchField(
              controller: _search,
              hint: l10n.addSheetSearchHint,
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          if (_query.trim().isEmpty)
            TabBar(
              labelColor: AppColors.themeColor,
              unselectedLabelColor: Colors.grey,
              indicatorColor: AppColors.themeColor,
              tabs: [
                Tab(text: l10n.devotionalTitle),
                Tab(text: l10n.catNovenasTitle),
                Tab(text: l10n.rosaryTitle),
              ],
            ),
          Expanded(
            child: _query.trim().isNotEmpty
                ? _buildResults(context, l10n)
                : TabBarView(
                    children: [
                      _buildPrayers(context, l10n),
                      _buildNovenas(context, l10n),
                      _buildRosary(context, l10n),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------ abas

  Widget _buildPrayers(BuildContext context, AppLocalizations l10n) {
    final all = PrayerData.getAllPrayers(context);
    const order = [
      'main', 'daily', 'sacraments', 'devotions', 'psalms', 'consecrations', 'saints', 'jaculatorias', 'litanies', 'special',
    ];
    return ListView(
      controller: widget.controller,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        for (final category in order)
          Builder(builder: (context) {
            var prayers = all.where((p) => p['category'] == category).toList();
            // o terço tem aba própria
            if (category == 'special') {
              prayers = prayers.where((p) => !(p['id'] as String).startsWith('rosary')).toList();
            }
            if (prayers.isEmpty) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: appCardDecoration(),
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    initiallyExpanded: category == 'main',
                    shape: const Border(),
                    collapsedShape: const Border(),
                    title: Text(
                      prayerCategoryLabel(l10n, category),
                      style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryText),
                    ),
                    subtitle: Text(l10n.prayersCountLabel(prayers.length),
                        style: const TextStyle(fontSize: 12, color: AppColors.secondaryText)),
                    children: [for (final p in prayers) _prayerTile(p)],
                  ),
                ),
              ),
            );
          }),
      ],
    );
  }

  Widget _prayerTile(Map<String, dynamic> prayer, {String? subtitle}) => _PickTile(
        icon: prayer['icon'] as IconData? ?? Icons.favorite_border,
        color: AppColors.themeColor,
        title: prayer['title'] as String,
        subtitle: subtitle,
        onTap: () => _choose(prayer),
      );

  Map<String, dynamic> _novenaAsPrayer(NovenaContent n) => {
        'id': n.id,
        'title': n.title,
        'description': n.description,
        'icon': n.icon,
      };

  Widget _buildNovenas(BuildContext context, AppLocalizations l10n) {
    final novenas = NovenaData.getAllNovenas(context);
    return ListView(
      controller: widget.controller,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        for (final n in novenas)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _PickTile(
              icon: n.icon,
              color: AppColors.accentGold,
              title: n.title,
              subtitle: n.description,
              card: true,
              onTap: () => _choose(_novenaAsPrayer(n)),
            ),
          ),
      ],
    );
  }

  Widget _buildRosary(BuildContext context, AppLocalizations l10n) {
    final traditional = Provider.of<SettingsProvider>(context).isTraditionalRosary;
    final mysteries = <(String, String, String, Color)>[
      ('rosary_joyful', l10n.mysteryJoyfulTitle, traditional ? l10n.mysteryJoyfulDays : l10n.mysteryJoyfulDaysLuminous, const Color(0xFF388E3C)),
      ('rosary_sorrowful', l10n.mysterySorrowfulTitle, l10n.mysterySorrowfulDays, const Color(0xFFD32F2F)),
      ('rosary_glorious', l10n.mysteryGloriousTitle, traditional ? l10n.mysteryGloriousDays : l10n.mysteryGloriousDaysLuminous, const Color(0xFFFFA000)),
      if (!traditional) ('rosary_luminous', l10n.mysteryLuminousTitle, l10n.mysteryLuminousDays, const Color(0xFFFBC02D)),
    ];
    return ListView(
      controller: widget.controller,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: _PickTile(
            icon: Icons.auto_awesome,
            color: AppColors.accentGold,
            title: l10n.rosaryTitle,
            subtitle: l10n.rosaryAutoMysterySubtitle,
            card: true,
            onTap: () => _choose({'id': 'rosary', 'title': l10n.rosaryTitle}),
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8, top: 4),
          child: Text(
            l10n.rosarySelectSpecificMystery.toUpperCase(),
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.8, color: AppColors.secondaryText),
          ),
        ),
        for (final m in mysteries)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _PickTile(
              icon: Icons.radio_button_checked,
              color: m.$4,
              title: m.$2,
              subtitle: m.$3,
              card: true,
              onTap: () => _choose({'id': m.$1, 'title': m.$2}),
            ),
          ),
      ],
    );
  }

  /// Resultado da busca: orações e novenas misturadas, da mais à menos parecida.
  Widget _buildResults(BuildContext context, AppLocalizations l10n) {
    final prayerHits = PrayerSearch.search(context, _query);
    final novenaHits = NovenaSearch.search(context, _query);
    final tiles = <Widget>[
      for (final h in prayerHits.hits)
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: _PickTile(
            icon: h.prayer['icon'] as IconData? ?? Icons.favorite_border,
            color: AppColors.themeColor,
            title: h.prayer['title'] as String,
            subtitle: h.categoryLabel,
            card: true,
            onTap: () => _choose(h.prayer),
          ),
        ),
      for (final n in novenaHits.hits)
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: _PickTile(
            icon: n.icon,
            color: AppColors.accentGold,
            title: n.title,
            subtitle: l10n.todayKindNovena,
            card: true,
            onTap: () => _choose(_novenaAsPrayer(n)),
          ),
        ),
    ];
    if (tiles.isEmpty) return ListView(controller: widget.controller, children: [SearchEmpty(l10n.searchNoPrayers)]);
    return ListView(
      controller: widget.controller,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: tiles,
    );
  }
}

/// Linha de uma oração/novena/mistério para escolher.
class _PickTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  /// Com cartão próprio (abas Novenas, Terço e resultados); sem, fica dentro
  /// de um cartão maior (categorias da aba Orações).
  final bool card;

  const _PickTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.card = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          children: [
            CircleIcon(icon: icon, color: color, size: 40),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.primaryText)),
                  if (subtitle != null && subtitle!.isNotEmpty)
                    Text(
                      subtitle!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, height: 1.3, color: AppColors.secondaryText),
                    ),
                ],
              ),
            ),
            Icon(Icons.add_circle_outline, color: color),
          ],
        ),
      ),
    );
    if (!card) return Material(color: Colors.transparent, child: content);
    return Container(
      decoration: appCardDecoration(tint: color),
      child: Material(color: Colors.transparent, child: content),
    );
  }
}

/// Opção grande da pergunta "Rezei agora" / "Adicionar ao plano".
class _ChoiceTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _ChoiceTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: appCardDecoration(tint: color),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleIcon(icon: icon, color: color, size: 46),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryText)),
                      const SizedBox(height: 2),
                      Text(description, style: const TextStyle(fontSize: 13, height: 1.3, color: AppColors.secondaryText)),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: color),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
