import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/theme/app_colors.dart';
import 'package:sanctaconscientia/providers/confession_provider.dart';
import 'package:sanctaconscientia/models/categoria.dart';
import 'package:sanctaconscientia/widgets/pecado_item.dart';
import 'package:sanctaconscientia/widgets/inner_page.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/utils/fuzzy_search.dart';

class CategoriaPecadosPage extends StatefulWidget {
  final Categoria categoria;

  const CategoriaPecadosPage({super.key, required this.categoria});

  @override
  State<CategoriaPecadosPage> createState() => _CategoriaPecadosPageState();
}

class _CategoriaPecadosPageState extends State<CategoriaPecadosPage> {
  late final bool _isMandamentos;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _isMandamentos = widget.categoria.id == 'mandamentos';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final confessionProvider = Provider.of<ConfessionProvider>(context, listen: false);
      confessionProvider.loadData();
    });
  }

  // Filtro de busca
  // Tolerante: ignora acentos, aceita plural, erros de digitação e sinônimos
  // ("roubar" acha "furto"), e mostra primeiro o que mais se parece.
  List<String> _filterPecados(List<String> pecados) {
    if (_searchQuery.trim().isEmpty) return pecados;
    final index = SearchIndex<String>(pecados, (s) => [SearchField(s, fuzzy: true)]);
    return [for (final h in index.search(_searchQuery).hits) h.item];
  }

  // Barra de busca
  Widget _buildSearchBar(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Não mostrar barra de busca se:
    // 1. For categoria 'antes'
    // 2. Categoria não tiver itens
    if (widget.categoria.id == 'antes' || widget.categoria.itens.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: l10n.searchHint,
          prefixIcon: const Icon(Icons.search, color: AppColors.themeColor),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.clear, color: AppColors.themeColor),
            onPressed: () {
              _searchController.clear();
              setState(() => _searchQuery = '');
            },
          )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.themeColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.themeColor, width: 2),
          ),
        ),
        onChanged: (value) => setState(() => _searchQuery = value),
      ),
    );
  }

  // MÉTODO CORRIGIDO: Usando ExpansionTile (mais confiável)
  Widget _buildMandamentosAcordeao(BuildContext context, ConfessionProvider confessionProvider) {
    final l10n = AppLocalizations.of(context)!;
    final mandamentosIds = widget.categoria.itens.keys.toList();

    return ListView.builder(
      itemCount: mandamentosIds.length,
      cacheExtent: 400,
      itemBuilder: (context, index) {
        final subcategoriaId = mandamentosIds[index];
        final pecadosFiltrados = _filterPecados(widget.categoria.itens[subcategoriaId]!);

        if (pecadosFiltrados.isEmpty && _searchQuery.trim().isNotEmpty) {
          return const SizedBox.shrink();
        }

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ExpansionTile(
            // abre sozinho quando há busca (a chave refaz o item ao começar/terminar a busca)
            key: ValueKey('mand-$subcategoriaId-${_searchQuery.trim().isNotEmpty}'),
            initiallyExpanded: _searchQuery.trim().isNotEmpty,
            leading: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.themeColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            title: Text(
              Categoria.getTituloSubcategoria(context, widget.categoria.id, subcategoriaId),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText,
              ),
            ),
            trailing: const Icon(
              Icons.expand_more,
              color: AppColors.themeColor,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Column(
                  children: [
                    for (final pecado in pecadosFiltrados)
                      _buildPecadoItem(confessionProvider, subcategoriaId, pecado),
                    if (pecadosFiltrados.isEmpty && _searchQuery.trim().isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          l10n.noSinsFound,
                          style: const TextStyle(
                            color: AppColors.secondaryText,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // MÉTODO PARA CONSTRUIR ITENS DE PECADO
  Widget _buildPecadoItem(ConfessionProvider confessionProvider, int subcategoriaId, String pecado) {
    final index = widget.categoria.itens[subcategoriaId]!.indexOf(pecado);
    final chave = '${widget.categoria.id}-$subcategoriaId-$index';

    return PecadoItem(
      descricao: pecado,
      contador: confessionProvider.getContador(chave),
      onIncrement: () => confessionProvider.incrementarPecado(chave),
      onDecrement: () => confessionProvider.decrementarPecado(chave),
    );
  }

  // MÉTODO PRINCIPAL PARA CONSTRUIR A LISTA
  Widget _buildOtimizadaList(BuildContext context, ConfessionProvider confessionProvider) {
    final l10n = AppLocalizations.of(context)!;
    // SE for mandamentos, usa o layout de acordeão
    if (_isMandamentos) {
      return _buildMandamentosAcordeao(context, confessionProvider);
    }

    // PARA outras categorias, mantém o layout original
    final List<Widget> items = [];

    for (final subcategoriaId in widget.categoria.itens.keys) {
      final pecadosFiltrados = _filterPecados(widget.categoria.itens[subcategoriaId]!);

      if (pecadosFiltrados.isEmpty && _searchQuery.trim().isNotEmpty) {
        continue;
      }

      items.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            Categoria.getTituloSubcategoria(context, widget.categoria.id, subcategoriaId),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.themeColor,
            ),
          ),
        ),
      );

      for (final pecado in pecadosFiltrados) {
        final index = widget.categoria.itens[subcategoriaId]!.indexOf(pecado);
        final chave = '${widget.categoria.id}-$subcategoriaId-$index';

        items.add(
          PecadoItem(
            descricao: pecado,
            contador: confessionProvider.getContador(chave),
            onIncrement: () => confessionProvider.incrementarPecado(chave),
            onDecrement: () => confessionProvider.decrementarPecado(chave),
          ),
        );
      }

      items.add(const SizedBox(height: 8));
    }

    if (items.isEmpty && _searchQuery.trim().isNotEmpty) {
      items.add(
        Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              l10n.noSinsFoundSearch,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.secondaryText,
                fontStyle: FontStyle.italic,
                fontSize: 16,
              ),
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: items.length,
      cacheExtent: 400,
      itemBuilder: (context, index) => items[index],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return InnerPageScaffold(
      title: widget.categoria.titulo,
      child: Consumer<ConfessionProvider>(
        builder: (context, confessionProvider, child) {
          return Column(
            children: [
              // Cabeçalho da categoria
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(16),
                decoration: appCardDecoration(radius: 20),
                child: Text(
                  widget.categoria.descricao,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // Barra de busca
              _buildSearchBar(context),
              // Lista de conteúdo (pode ser acordeão ou lista normal)
              Expanded(
                child: _buildOtimizadaList(context, confessionProvider),
              ),
              // Botão de salvar e voltar
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                  child: PillButton(
                    label: l10n.saveAndReturnButton,
                    color: AppColors.accentGold,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}