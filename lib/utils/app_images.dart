import 'package:flutter/widgets.dart';

/// Imagens de fundo das páginas. São decodificadas uma vez, durante a tela de
/// entrada, no mesmo tamanho usado nos cabeçalhos (cacheWidth 900), para as
/// páginas abrirem já com a imagem, sem o "pisca" de carregamento.
class AppImages {
  static const headerWidth = 900;

  static const headers = [
    'lib/imgs/jardim_page.webp',
    'lib/imgs/oracoes_page.webp',
    'lib/imgs/novenas_page.webp',
    'lib/imgs/terco_page.webp',
    'lib/imgs/exame_page.webp',
    'lib/imgs/misterios_gozosos.webp',
    'lib/imgs/misterios_dolorosos.webp',
    'lib/imgs/misterios_gloriosos.webp',
  ];

  /// Decodifica todas as imagens de cabeçalho. A do Jardim (primeira página)
  /// vem primeiro; falhas são ignoradas.
  static Future<void> precacheAll(BuildContext context) async {
    for (final path in headers) {
      if (!context.mounted) return;
      await precacheImage(ResizeImage(AssetImage(path), width: headerWidth), context)
          .catchError((_) {});
    }
  }
}
