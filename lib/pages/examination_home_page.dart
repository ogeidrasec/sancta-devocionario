import 'package:flutter/material.dart';
import 'package:sanctaconscientia/utils/app_images.dart';
import 'package:sanctaconscientia/widgets/app_tour.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/models/categoria.dart';
import 'package:sanctaconscientia/pages/categoria_pecados_page.dart';
import 'package:sanctaconscientia/pages/conteudo_info_page.dart';
import 'package:sanctaconscientia/pages/exame_diario_page.dart';
import 'package:sanctaconscientia/pages/jornada_confissao_page.dart';
import 'package:sanctaconscientia/pages/metodo_confissao_page.dart';
import 'package:sanctaconscientia/pages/oracao_page.dart';
import 'package:sanctaconscientia/widgets/confession_scheduling_dialog.dart';
import 'package:sanctaconscientia/pages/relatorio_page.dart';
import 'package:sanctaconscientia/providers/confession_provider.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/widgets/category_card.dart';
import 'package:sanctaconscientia/widgets/home_header.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';
import 'package:sanctaconscientia/widgets/jornada_banner.dart';
import 'package:sanctaconscientia/utils/content_search.dart';
import 'package:sanctaconscientia/widgets/pecado_item.dart';
import 'package:sanctaconscientia/widgets/search_field.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';

class ExaminationHomePage extends StatefulWidget {
  /// [demo]: usado pelo guia do app; mostra dados de exemplo, não os reais.
  final bool demo;
  const ExaminationHomePage({super.key, this.demo = false});

  @override
  State<ExaminationHomePage> createState() => _ExaminationHomePageState();
}

class _ExaminationHomePageState extends State<ExaminationHomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.demo) {
        final ids = Categoria.getExaminationCategories(context)
            .where((c) => c.itens.isNotEmpty)
            .map((c) => c.id)
            .toList();
        Provider.of<ConfessionProvider>(context, listen: false).loadDemo(ids);
      } else {
        _loadDates();
      }
    });
  }

  void _loadDates() async {
    final confessionProvider = Provider.of<ConfessionProvider>(context, listen: false);
    await confessionProvider.loadData();
  }

  void _abrirCategoria(BuildContext context, Categoria categoria) {
    Widget page;
    if (categoria.itens.isEmpty) {
      switch (categoria.id) {
        case 'oracao':
          page = const OracaoPage();
        case 'metodo':
          page = const MetodoConfissaoPage();
        case 'jornada':
          page = const JornadaConfissaoPage();
        case 'exame_diario':
          page = const ExameDiarioPage();
        default:
          page = ConteudoInfoPage(titulo: categoria.titulo, conteudo: '');
      }
    } else {
      page = CategoriaPecadosPage(categoria: categoria);
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  void _gerarRelatorio(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const RelatorioPage()));
  }

  void _showConfessionSchedulingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const ConfessionSchedulingDialog(),
    ).then((_) => _loadDates());
  }

  Future<void> _editarUltimaConfissao(BuildContext context) async {
    final confessionProvider = Provider.of<ConfessionProvider>(context, listen: false);
    final dataAtual = confessionProvider.dataUltimaConfissao ?? DateTime.now();

    // O seletor de datas usa o tema do app
    final novaData = await showDatePicker(
      context: context,
      initialDate: dataAtual,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (novaData != null) {
      confessionProvider.confirmarConfissao(date: novaData);
    }
  }

  Future<void> _limparMarcacoes(BuildContext context, int total) async {
    final l10n = AppLocalizations.of(context)!;
    final provider = Provider.of<ConfessionProvider>(context, listen: false);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.examClearTitle),
        content: Text(l10n.examClearBody(total)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l10n.cancelButton)),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.examClearConfirm, style: const TextStyle(color: AppColors.errorColor)),
          ),
        ],
      ),
    );
    if (ok != true) return;
    await provider.limparDados();
    if (context.mounted) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text(l10n.examCleared)));
    }
  }

  /// Resultados da busca em todo o exame: cada item pode ser marcado ali mesmo.
  Widget _buildSearchResults(BuildContext context, AppLocalizations l10n, List<Categoria> categories) {
    final result = SinSearch.searchCategories(categories.where((c) => c.itens.isNotEmpty).toList(), _query);
    if (result.hits.isEmpty) {
      return SliverToBoxAdapter(child: SearchEmpty(l10n.searchNoSins));
    }
    return Consumer<ConfessionProvider>(
      builder: (context, confessionProvider, child) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) {
            if (i == 0) {
              return result.approximate
                  ? const Padding(
                      padding: EdgeInsets.fromLTRB(20, 12, 16, 0),
                      child: SearchApproximateNote(),
                    )
                  : const SizedBox(height: 8);
            }
            final hit = result.hits[i - 1];
            final place =
                '${hit.categoria.titulo} · ${Categoria.getTituloSubcategoria(context, hit.categoria.id, hit.subcategoriaId)}';
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 16, 0),
                  child: Text(
                    place,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.themeColor),
                  ),
                ),
                PecadoItem(
                  descricao: hit.text,
                  contador: confessionProvider.getContador(hit.key),
                  onIncrement: () => confessionProvider.incrementarPecado(hit.key),
                  onDecrement: () => confessionProvider.decrementarPecado(hit.key),
                ),
              ],
            );
          },
          childCount: result.hits.length + 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final categories = Categoria.getExaminationCategories(context).where((c) => c.id != 'jornada').toList();

    // Etapas em ordem de uso: preparar, examinar e confessar
    List<Categoria> pick(List<String> ids) => categories.where((c) => ids.contains(c.id)).toList();
    final prepare = pick(['oracao']);
    final confess = pick(['metodo']);
    final examine = categories.where((c) => !['oracao', 'metodo'].contains(c.id)).toList();

    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              controller: AppTourScroll.exam,
              slivers: [
                SliverAppBar(
                  expandedHeight: 120.0,
                  floating: false,
                  pinned: true,
                  backgroundColor: AppColors.primaryText,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    title: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        l10n.examinationTitle,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    centerTitle: true,
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset('lib/imgs/exame_page.webp', fit: BoxFit.cover, cacheWidth: AppImages.headerWidth),
                        Container(color: Colors.black.withValues(alpha: 0.3)),
                      ],
                    ),
                  ),
                  leading: null,
                ),
                SliverToBoxAdapter(
                  child: Consumer<ConfessionProvider>(
                    builder: (context, confessionProvider, child) {
                      return TourAnchor(ref: AppTourKeys.examHeader,
                        child: HomeHeader(
                        lastConfessionDate: confessionProvider.dataUltimaConfissao,
                        proximaConfissao: confessionProvider.nextConfessionDate,
                        onEditUltimaConfissao: () => _editarUltimaConfissao(context),
                        onEditProximaConfissao: () => _showConfessionSchedulingDialog(context),
                        ),
                      );
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: AppSearchField(
                      controller: _searchController,
                      hint: l10n.searchExamHint,
                      onChanged: (v) => setState(() => _query = v),
                    ),
                  ),
                ),
                if (_query.trim().isNotEmpty)
                  _buildSearchResults(context, l10n, categories)
                else ...[
                SliverToBoxAdapter(child: TourAnchor(ref: AppTourKeys.examJornada, child: const JornadaBanner())),
                SliverToBoxAdapter(
                  child: Consumer<ConfessionProvider>(
                    builder: (context, confessionProvider, child) {
                      Widget section(String label, List<Categoria> items) {
                        if (items.isEmpty) return const SizedBox.shrink();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 16, 16, 4),
                              child: SectionLabel(label),
                            ),
                            for (final categoria in items)
                              Builder(builder: (context) {
                                final marcados = categoria.itens.isEmpty
                                    ? 0
                                    : confessionProvider.pecadosNaCategoria(categoria.id);
                                return CategoryCard(
                                  categoria: categoria,
                                  badge: marcados > 0 ? l10n.examSelectedCount(marcados) : null,
                                  onTap: () => _abrirCategoria(context, categoria),
                                );
                              }),
                          ],
                        );
                      }

                      return Column(
                        children: [
                          section(l10n.examSectionPrepare, prepare),
                          TourAnchor(ref: AppTourKeys.examSections, child: section(l10n.examSectionExamine, examine)),
                          section(l10n.examSectionConfess, confess),
                          const SizedBox(height: 12),
                        ],
                      );
                    },
                  ),
                ),
                ],
              ],
            ),
          ),
          Consumer<ConfessionProvider>(
            builder: (context, confessionProvider, child) {
              final total = confessionProvider.totalPecados;
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryBg,
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 10, offset: const Offset(0, -3)),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                total > 0 ? l10n.examGuideTotal(total) : l10n.examGuideHint,
                                textAlign: total > 0 ? TextAlign.start : TextAlign.center,
                                style: const TextStyle(fontSize: 13, color: AppColors.secondaryText),
                              ),
                            ),
                            if (total > 0)
                              TextButton(
                                onPressed: () => _limparMarcacoes(context, total),
                                child: Text(
                                  l10n.examClearMarks,
                                  style: const TextStyle(color: AppColors.errorColor),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        TourAnchor(ref: AppTourKeys.examGuide,
                          child: PillButton(
                          label: l10n.generateGuideButton,
                          icon: Icons.arrow_forward,
                          onPressed: total > 0 ? () => _gerarRelatorio(context) : null,
                        )),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
