import 'package:flutter/widgets.dart';
import 'package:sanctaconscientia/data/novena_data.dart';
import 'package:sanctaconscientia/data/prayer_data.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/models/categoria.dart';
import 'package:sanctaconscientia/models/novena_content.dart';
import 'package:sanctaconscientia/utils/fuzzy_search.dart';

/// Nome da categoria de uma oração (para mostrar nos resultados e buscar por ela).
String prayerCategoryLabel(AppLocalizations l10n, String? category) {
  switch (category) {
    case 'main':
      return l10n.catPrayersMain;
    case 'daily':
      return l10n.catPrayersDaily;
    case 'sacraments':
      return l10n.catPrayersSacraments;
    case 'devotions':
      return l10n.catPrayersDevotions;
    case 'psalms':
      return l10n.catPrayersPsalms;
    case 'consecrations':
      return l10n.catPrayersConsecrations;
    case 'saints':
      return l10n.catPrayersSaints;
    case 'jaculatorias':
      return l10n.catJaculatoriasTitle;
    case 'litanies':
      return l10n.catLitaniesTitle;
    case 'special':
      return l10n.catPrayersSpecial;
  }
  return '';
}

/// Resultado da busca por oração.
class PrayerHit {
  final Map<String, dynamic> prayer;
  final String categoryLabel;
  final String? snippet;
  const PrayerHit(this.prayer, this.categoryLabel, this.snippet);
}

class PrayerSearch {
  PrayerSearch._();

  static SearchIndex<Map<String, dynamic>>? _index;
  static String? _indexKey;

  /// Busca nas orações (título, categoria, texto e latim).
  static ({List<PrayerHit> hits, bool approximate}) search(BuildContext context, String query) {
    final l10n = AppLocalizations.of(context)!;
    final prayers = PrayerData.getAllPrayers(context);
    final key = '${Localizations.localeOf(context)}-${prayers.length}';
    if (_index == null || _indexKey != key) {
      _index = SearchIndex<Map<String, dynamic>>(prayers, (p) => [
            SearchField(p['title'] as String? ?? '', weight: 3, fuzzy: true),
            SearchField(prayerCategoryLabel(l10n, p['category'] as String?), weight: 1.5, fuzzy: true),
            SearchField(p['content'] as String? ?? ''),
            SearchField(p['contentLatin'] as String? ?? '', weight: 0.8),
          ]);
      _indexKey = key;
    }
    final result = _index!.search(query);
    return (
      hits: [
        for (final h in result.hits)
          PrayerHit(
            h.item,
            prayerCategoryLabel(l10n, h.item['category'] as String?),
            _snippetFor(h.item, query),
          ),
      ],
      approximate: result.approximate,
    );
  }

  static String? _snippetFor(Map<String, dynamic> prayer, String query) {
    // Só mostra trecho quando a palavra está no texto (e não no título)
    final title = FuzzySearch.fold(prayer['title'] as String? ?? '');
    final inTitle = FuzzySearch.queryTokens(query).every((q) => title.contains(q));
    if (inTitle) return null;
    return FuzzySearch.snippet(prayer['content'] as String? ?? '', query) ??
        FuzzySearch.snippet(prayer['contentLatin'] as String? ?? '', query);
  }
}

class NovenaSearch {
  NovenaSearch._();

  static SearchIndex<NovenaContent>? _index;
  static String? _indexKey;

  /// Busca nas novenas (título, descrição, títulos dos dias e orações).
  static ({List<NovenaContent> hits, bool approximate}) search(BuildContext context, String query) {
    final novenas = NovenaData.getAllNovenas(context);
    final key = '${Localizations.localeOf(context)}-${novenas.length}';
    if (_index == null || _indexKey != key) {
      _index = SearchIndex<NovenaContent>(novenas, (n) => [
            SearchField(n.title, weight: 3, fuzzy: true),
            SearchField(n.description, weight: 1.5, fuzzy: true),
            SearchField(n.days.map((d) => d.title).join(' · '), weight: 1),
            SearchField(n.openingPrayer, weight: 0.6),
          ]);
      _indexKey = key;
    }
    final result = _index!.search(query);
    return (hits: [for (final h in result.hits) h.item], approximate: result.approximate);
  }
}

/// Um item do exame de consciência encontrado na busca.
class SinHit {
  final Categoria categoria;
  final int subcategoriaId;
  final int index;
  final String text;

  const SinHit(this.categoria, this.subcategoriaId, this.index, this.text);

  /// Chave do contador no banco: `<categoria>-<subcategoria>-<índice>`.
  String get key => '${categoria.id}-$subcategoriaId-$index';
}

class SinSearch {
  SinSearch._();

  /// Ordena e filtra [items] (de uma categoria) pela busca. Itens são
  /// pesquisados com tolerância a erros e sinônimos.
  static ({List<SinHit> hits, bool approximate}) searchCategories(
    List<Categoria> categorias,
    String query,
  ) {
    final all = <SinHit>[];
    for (final c in categorias) {
      c.itens.forEach((sub, list) {
        for (var i = 0; i < list.length; i++) {
          all.add(SinHit(c, sub, i, list[i]));
        }
      });
    }
    return searchHits(all, query);
  }

  static ({List<SinHit> hits, bool approximate}) searchHits(List<SinHit> all, String query) {
    final index = SearchIndex<SinHit>(all, (h) => [SearchField(h.text, fuzzy: true)]);
    final r = index.search(query);
    return (hits: [for (final h in r.hits) h.item], approximate: r.approximate);
  }
}
