import 'package:flutter/material.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';

class Categoria {
  final String id;
  final String titulo;
  final String descricao;
  final String icone;
  final String subtitulo;
  final Map<int, List<String>> itens;
  final bool highlight;

  Categoria({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.icone,
    required this.subtitulo,
    required this.itens,
    this.highlight = false,
  });

  static String getTituloSubcategoria(BuildContext context, String categoriaId, int subcategoriaId) {
    final l10n = AppLocalizations.of(context)!;
    
    if (categoriaId == 'antes') {
      if (subcategoriaId == 1) return l10n.catAntesSub1;
    } else if (categoriaId == 'mandamentos') {
      switch (subcategoriaId) {
        case 1: return l10n.catMandamentosSub1;
        case 2: return l10n.catMandamentosSub2;
        case 3: return l10n.catMandamentosSub3;
        case 4: return l10n.catMandamentosSub4;
        case 5: return l10n.catMandamentosSub5;
        case 6: return l10n.catMandamentosSub6;
        case 7: return l10n.catMandamentosSub7;
        case 8: return l10n.catMandamentosSub8;
        case 9: return l10n.catMandamentosSub9;
        case 10: return l10n.catMandamentosSub10;
      }
    } else if (categoriaId == 'igreja') {
      if (subcategoriaId == 1) return l10n.catIgrejaSub1;
    }

    return 'Item $subcategoriaId';
  }

  static List<Categoria> getCategorias(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return [
      Categoria(
        id: 'devocional',
        titulo: l10n.devotionalTitle,
        descricao: l10n.devotionalSubtitle,
        icone: 'volunteer_activism',
        subtitulo: l10n.devotionalSubtitle,
        itens: {},
      ),
      Categoria(
        id: 'novenas',
        titulo: l10n.prayersTitle, // Using existing key for Novenas
        descricao: l10n.comingSoon,
        icone: 'local_florist',
        subtitulo: l10n.comingSoon,
        itens: {},
      ),
      Categoria(
        id: 'jaculatorias',
        titulo: l10n.rosaryTitle, // Using existing key for Jaculatórias
        descricao: l10n.comingSoon,
        icone: 'format_quote',
        subtitulo: l10n.comingSoon,
        itens: {},
      ),
      Categoria(
        id: 'exame',
        titulo: l10n.examinationMenuTitle,
        descricao: l10n.examinationSubtitle,
        icone: 'assignment',
        subtitulo: l10n.examinationSubtitle,
        itens: {},
      ),
      Categoria(
        id: 'mais',
        titulo: l10n.moreTitle,
        descricao: l10n.comingSoon,
        icone: 'calendar_month',
        subtitulo: l10n.comingSoon,
        itens: {},
      ),
    ];
  }

  static List<Categoria> getExaminationCategories(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return [
      Categoria(
        id: 'oracao',
        titulo: l10n.catOracaoTitle,
        descricao: l10n.catOracaoDesc,
        icone: 'volunteer_activism',
        subtitulo: l10n.catOracaoSub,
        itens: {},
      ),
      Categoria(
        id: 'jornada',
        titulo: l10n.catJornadaTitle,
        descricao: l10n.catJornadaDesc,
        icone: 'favorite',
        subtitulo: l10n.catJornadaSub,
        itens: {},
        highlight: true,
      ),
      Categoria(
        id: 'antes',
        titulo: l10n.catAntesTitle,
        subtitulo: l10n.catAntesSub,
        descricao: l10n.catAntesDesc,
        icone: 'access_time',
        itens: {
          1: [
            l10n.catAntesItem1,
            l10n.catAntesItem2,
            l10n.catAntesItem3,
            l10n.catAntesItem4,
            l10n.catAntesItem5,
            l10n.catAntesItem6,
            l10n.catAntesItem7,
          ]
        },
      ),
      Categoria(
        id: 'mandamentos',
        titulo: l10n.catMandamentosTitle,
        descricao: l10n.catMandamentosDesc,
        icone: 'filter_9_plus',
        subtitulo: l10n.catMandamentosSub,
        itens: {
          1: [
            l10n.catMandamentos1Item1,
            l10n.catMandamentos1Item2,
            l10n.catMandamentos1Item3,
            l10n.catMandamentos1Item4,
            l10n.catMandamentos1Item5,
            l10n.catMandamentos1Item6,
            l10n.catMandamentos1Item7,
            l10n.catMandamentos1Item8,
            l10n.catMandamentos1Item9,
            l10n.catMandamentos1Item10,
          ],
          2: [
            l10n.catMandamentos2Item1,
            l10n.catMandamentos2Item2,
            l10n.catMandamentos2Item3,
            l10n.catMandamentos2Item4,
            l10n.catMandamentos2Item5,
            l10n.catMandamentos2Item6,
          ],
          3: [
            l10n.catMandamentos3Item1,
            l10n.catMandamentos3Item2,
            l10n.catMandamentos3Item3,
            l10n.catMandamentos3Item4,
          ],
          4: [
            l10n.catMandamentos4Item1,
            l10n.catMandamentos4Item2,
            l10n.catMandamentos4Item3,
            l10n.catMandamentos4Item4,
            l10n.catMandamentos4Item5,
            l10n.catMandamentos4Item6,
            l10n.catMandamentos4Item7,
          ],
          5: [
            l10n.catMandamentos5Item1,
            l10n.catMandamentos5Item2,
            l10n.catMandamentos5Item3,
            l10n.catMandamentos5Item4,
            l10n.catMandamentos5Item5,
            l10n.catMandamentos5Item6,
            l10n.catMandamentos5Item7,
            l10n.catMandamentos5Item8,
          ],
          6: [
            l10n.catMandamentos6Item1,
            l10n.catMandamentos6Item2,
            l10n.catMandamentos6Item3,
            l10n.catMandamentos6Item4,
            l10n.catMandamentos6Item5,
            l10n.catMandamentos6Item6,
            l10n.catMandamentos6Item7,
          ],
          7: [
            l10n.catMandamentos7Item1,
            l10n.catMandamentos7Item2,
            l10n.catMandamentos7Item3,
            l10n.catMandamentos7Item4,
            l10n.catMandamentos7Item5,
            l10n.catMandamentos7Item6,
          ],
          8: [
            l10n.catMandamentos8Item1,
            l10n.catMandamentos8Item2,
            l10n.catMandamentos8Item3,
            l10n.catMandamentos8Item4,
            l10n.catMandamentos8Item5,
          ],
          9: [
            l10n.catMandamentos9Item1,
            l10n.catMandamentos9Item2,
            l10n.catMandamentos9Item3,
          ],
          10: [
            l10n.catMandamentos10Item1,
            l10n.catMandamentos10Item2,
            l10n.catMandamentos10Item3,
            l10n.catMandamentos10Item4,
          ],
        },
      ),
      Categoria(
        id: 'igreja',
        titulo: l10n.catIgrejaTitle,
        descricao: l10n.catIgrejaDesc,
        icone: 'church',
        subtitulo: l10n.catIgrejaSub,
        itens: {
          1: [
            l10n.catIgrejaItem1,
            l10n.catIgrejaItem2,
            l10n.catIgrejaItem3,
            l10n.catIgrejaItem4,
            l10n.catIgrejaItem5,
            l10n.catIgrejaItem6,
            l10n.catIgrejaItem7,
          ]
        },
      ),
      Categoria(
        id: 'metodo',
        titulo: l10n.catMetodoTitle,
        descricao: l10n.catMetodoDesc,
        icone: 'format_list_numbered',
        subtitulo: l10n.catMetodoSub,
        itens: {},
      ),
    ];
  }
}