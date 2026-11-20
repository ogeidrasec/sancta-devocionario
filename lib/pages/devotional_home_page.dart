import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sanctaconscientia/utils/app_images.dart';
import 'package:sanctaconscientia/utils/content_search.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';
import 'package:sanctaconscientia/widgets/search_field.dart';
import 'package:sanctaconscientia/widgets/app_tour.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/pages/prayer_detail_page.dart';
import 'package:sanctaconscientia/pages/exame_diario_page.dart';
import 'package:sanctaconscientia/pages/luta_tentacoes_page.dart';
import 'package:sanctaconscientia/pages/mass_guide_page.dart';
import 'package:sanctaconscientia/pages/adoration_guide_page.dart';
import 'package:sanctaconscientia/pages/intentions_page.dart';
import 'package:sanctaconscientia/data/prayer_data.dart';
import 'package:sanctaconscientia/utils/liturgical_calendar.dart';

/// Tela de Orações: destaque para a oração do momento, atalhos e categorias.
class DevotionalHomePage extends StatefulWidget {
  const DevotionalHomePage({super.key});

  @override
  State<DevotionalHomePage> createState() => _DevotionalHomePageState();
}

class _DevotionalHomePageState extends State<DevotionalHomePage> {
  // Uma categoria aberta por vez: abrir uma fecha a anterior.
  final Map<String, ExpansibleController> _controllers = {};
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  Timer? _debounce;

  /// Busca só depois de uma pausa curta na digitação (em celulares simples,
  /// buscar a cada letra deixava o teclado lento). Apagar tudo volta na hora.
  void _onQueryChanged(String v) {
    _debounce?.cancel();
    if (v.trim().isEmpty) {
      setState(() => _query = v);
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 200), () {
      if (mounted) setState(() => _query = v);
    });
  }

  // listas por categoria, refeitas só quando o catálogo muda (idioma)
  List<Map<String, dynamic>>? _catalogFor;
  final Map<String, List<Map<String, dynamic>>> _byCategory = {};

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  static const _gold = Color(0xFFB7791F);
  static const _blue = Color(0xFF1E5AA8);
  static const _indigo = Color(0xFF2F3A8F);

  /// Abre uma oração (ou a tela própria dela). Passa o id para que concluir a
  /// oração marque também o plano do dia no Jardim.
  void _openPrayer(BuildContext context, Map<String, dynamic> prayer) {
    if (prayer.containsKey('route')) {
      Navigator.push(context, MaterialPageRoute(builder: prayer['route']));
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PrayerDetailPage(
            title: prayer['title'] as String,
            content: prayer['content'] as String,
            contentLatin: prayer['contentLatin'] as String?,
            prayerId: prayer['id'] as String?,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final allPrayers = PrayerData.getAllPrayers(context);

    if (!identical(_catalogFor, allPrayers)) {
      _catalogFor = allPrayers;
      _byCategory.clear();
    }
    List<Map<String, dynamic>> byCategory(String c) =>
        _byCategory.putIfAbsent(c, () => allPrayers.where((p) => p['category'] == c).toList());

    final categories = <_Category>[
      _Category(l10n.catPrayersMain, Icons.star, AppColors.themeColor, byCategory('main')),
      _Category(l10n.catPrayersDaily, Icons.calendar_today, _gold, byCategory('daily')),
      _Category(l10n.catPrayersSacraments, Icons.church, const Color(0xFF6A1B9A), byCategory('sacraments')),
      _Category(l10n.catPrayersDevotions, Icons.volunteer_activism, const Color(0xFFB23A48), byCategory('devotions')),
      _Category(l10n.catPrayersPsalms, Icons.music_note, const Color(0xFF00796B), byCategory('psalms')),
      _Category(l10n.catPrayersConsecrations, Icons.volunteer_activism, const Color(0xFF8E3B6B), byCategory('consecrations')),
      _Category(l10n.catPrayersSaints, Icons.people, const Color(0xFF2E7D32), byCategory('saints')),
      _Category(l10n.catJaculatoriasTitle, Icons.favorite, const Color(0xFFC2185B), byCategory('jaculatorias')),
      _Category(l10n.catLitaniesTitle, Icons.menu_book, _indigo, byCategory('litanies')),
    ];

    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      body: CustomScrollView(
        controller: AppTourScroll.prayers,
        slivers: [
          SliverAppBar(
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primaryText,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                l10n.devotionalTitle,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('lib/imgs/oracoes_page.webp', fit: BoxFit.cover, cacheWidth: AppImages.headerWidth),
                  Container(color: Colors.black.withValues(alpha: 0.3)),
                ],
              ),
            ),
            leading: null,
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                TourAnchor(
                  ref: AppTourKeys.prayerSearch,
                  child: AppSearchField(
                  controller: _searchController,
                  hint: l10n.searchPrayersHint,
                  onChanged: _onQueryChanged,
                ),
                ),
                const SizedBox(height: 16),
                if (_query.trim().isNotEmpty)
                  ..._buildResults(context, l10n)
                else ...[
                _buildSaintOfTheDay(context),
                _buildNowCard(context, l10n, allPrayers),
                const SizedBox(height: 14),
                _buildTools(context, l10n),
                const SizedBox(height: 28),
                TourAnchor(
                  ref: AppTourKeys.prayerGuides,
                  child: KeyedSubtree(
                  child: Column(children: [
                    _sectionTitle(l10n.prayersSectionGuides),
                    _buildGuides(context, l10n),
                  ]),
                ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 10),
                  child: Text(
                    l10n.prayersSectionCategories.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                      color: AppColors.secondaryText,
                    ),
                  ),
                ),
                for (final c in categories)
                  Padding(
                    key: ValueKey(c.title),
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildCategory(context, l10n, c),
                  ),
                ],
              ]),
            ),
          ),
        ],
      ),
    );
  }

  /// Resultados da busca: orações parecidas com o que foi digitado.
  List<Widget> _buildResults(BuildContext context, AppLocalizations l10n) {
    final result = PrayerSearch.search(context, _query);
    if (result.hits.isEmpty) return [SearchEmpty(l10n.searchNoPrayers)];
    return [
      if (result.approximate) const SearchApproximateNote(),
      for (final hit in result.hits)
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            decoration: appCardDecoration(),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () => _openPrayer(context, hit.prayer),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      CircleIcon(icon: hit.prayer['icon'] as IconData? ?? Icons.star, color: AppColors.themeColor, size: 44),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hit.prayer['title'] as String,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryText),
                            ),
                            if (hit.categoryLabel.isNotEmpty)
                              Text(
                                hit.categoryLabel,
                                style: const TextStyle(fontSize: 12, color: AppColors.themeColor, fontWeight: FontWeight.w600),
                              ),
                            if (hit.snippet != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  hit.snippet!,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 13, height: 1.35, color: AppColors.secondaryText),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: AppColors.themeColor),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
    ];
  }

  /// Destaque: a oração que combina com a hora do dia.
  Widget _buildNowCard(BuildContext context, AppLocalizations l10n, List<Map<String, dynamic>> all) {
    final hour = DateTime.now().hour;
    final String id;
    final String label;
    final Color color;
    final IconData icon;
    if (hour >= 5 && hour < 12) {
      id = 'morningOffering';
      label = l10n.prayerForMorning;
      color = _gold;
      icon = Icons.wb_sunny;
    } else if (hour >= 12 && hour < 18) {
      id = 'angelus';
      label = l10n.prayerForNoon;
      color = _blue;
      icon = Icons.notifications_active;
    } else {
      id = 'nightPrayer';
      label = l10n.prayerForNight;
      color = _indigo;
      icon = Icons.nights_stay;
    }

    final prayer = all.where((p) => p['id'] == id).firstOrNull;
    if (prayer == null) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, Color.lerp(color, Colors.black, 0.28)!],
        ),
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.35), blurRadius: 16, offset: const Offset(0, 8)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () => _openPrayer(context, prayer),
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          label.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(icon, color: Colors.white.withValues(alpha: 0.9), size: 30),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  prayer['title'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _openPrayer(context, prayer),
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: Text(
                      l10n.rosaryPrayNow,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: color,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) => Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 10),
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: AppColors.secondaryText,
          ),
        ),
      );

  /// Guia da Missa, Adoração e Intenções (antes no menu lateral).
  Widget _buildGuides(BuildContext context, AppLocalizations l10n) {
    Widget guide(Key key, IconData icon, Color color, String title, String desc, WidgetBuilder page) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          decoration: appCardDecoration(tint: color),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              key: key,
              borderRadius: BorderRadius.circular(18),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: page)),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    CircleIcon(icon: icon, color: color, size: 44),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryText)),
                          const SizedBox(height: 2),
                          Text(desc, style: const TextStyle(fontSize: 13, color: AppColors.secondaryText)),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, color: color),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        guide(const ValueKey('guide_mass'), Icons.church_outlined, _gold, l10n.drawerMassGuide,
            l10n.guideMassDesc, (_) => const MassGuidePage()),
        guide(const ValueKey('guide_adoration'), Icons.brightness_7_outlined, AppColors.themeColor,
            l10n.drawerAdoration, l10n.guideAdorationDesc, (_) => const AdorationGuidePage()),
        guide(const ValueKey('guide_intentions'), Icons.edit_note, const Color(0xFF6A1B9A),
            l10n.drawerIntentions, l10n.guideIntentionsDesc, (_) => const IntentionsPage()),
      ],
    );
  }

  /// Exame diário e Luta contra as tentações: dois atalhos lado a lado.
  Widget _buildTools(BuildContext context, AppLocalizations l10n) {
    // IntrinsicHeight: os dois atalhos ficam com a mesma altura dentro da lista rolável
    return IntrinsicHeight(
      child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: _ToolTile(
            icon: Icons.today,
            color: _gold,
            label: l10n.catExameDiarioTitle,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ExameDiarioPage()),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ToolTile(
            icon: Icons.shield,
            color: const Color(0xFFC62828),
            label: l10n.temptationFightTitle,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LutaTentacoesPage()),
            ),
          ),
        ),
      ],
      ),
    );
  }

  Widget _buildSaintOfTheDay(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final feastName = LiturgicalCalendar.getFeastName(DateTime.now(), l10n);
    if (feastName == null) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.accentGold.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.accentGold.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.star, color: AppColors.accentGold, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.saintOfTheDay,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.secondaryText,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  feastName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Categoria que se expande para mostrar as orações.
  Widget _buildCategory(BuildContext context, AppLocalizations l10n, _Category c) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: c.color.withValues(alpha: 0.18)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 3)),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          controller: _controllers.putIfAbsent(c.title, ExpansibleController.new),
          onExpansionChanged: (open) {
            if (!open) return;
            for (final e in _controllers.entries) {
              if (e.key != c.title && e.value.isExpanded) e.value.collapse();
            }
          },
          shape: const Border(),
          collapsedShape: const Border(),
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          iconColor: c.color,
          collapsedIconColor: c.color,
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: c.color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(c.icon, color: c.color, size: 24),
          ),
          title: Text(
            c.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: AppColors.primaryText,
            ),
          ),
          subtitle: Text(
            l10n.prayersCountLabel(c.prayers.length),
            style: TextStyle(fontSize: 13, color: AppColors.secondaryText.withValues(alpha: 0.85)),
          ),
          childrenPadding: const EdgeInsets.only(bottom: 8),
          children: [
            Divider(height: 1, color: c.color.withValues(alpha: 0.12)),
            for (final prayer in c.prayers) _buildPrayerItem(context, prayer, c.color),
          ],
        ),
      ),
    );
  }

  Widget _buildPrayerItem(BuildContext context, Map<String, dynamic> prayer, Color color) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _openPrayer(context, prayer),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              Icon(prayer['icon'] as IconData, color: color, size: 22),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  prayer['title'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.primaryText,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, size: 20, color: AppColors.secondaryText.withValues(alpha: 0.6)),
            ],
          ),
        ),
      ),
    );
  }
}

class _Category {
  final String title;
  final IconData icon;
  final Color color;
  final List<Map<String, dynamic>> prayers;
  const _Category(this.title, this.icon, this.color, this.prayers);
}

/// Atalho quadrado com ícone e rótulo (Exame diário, Luta contra as tentações).
class _ToolTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;

  const _ToolTile({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: 0.25)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 3)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(height: 10),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.primaryText,
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
