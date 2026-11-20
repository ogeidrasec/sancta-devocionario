import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// Imagens do app e o tamanho em que são decodificadas.
///
/// Para poupar memória em celulares simples:
/// - as fotos de cabeçalho são decodificadas na largura da tela (no máximo
///   900 px), não no tamanho original;
/// - na entrada só a do Jardim é preparada; as das outras abas vêm logo depois
///   que o app abre, uma por vez; as dos mistérios, só ao abrir o Santo Terço.
class AppImages {
  /// Largura (em pixels) das fotos de cabeçalho. É ajustada à tela em
  /// [configure]; o mesmo valor é usado ao pré-carregar e ao desenhar, para a
  /// imagem pré-carregada ser reaproveitada.
  static int headerWidth = 900;

  /// Ícone do menu e logo da abertura, já em tamanho pequeno.
  static const icon = 'lib/imgs/sancta_icon_small.png';
  static const logo = 'lib/imgs/sancta_logo_small.png';

  static const garden = 'lib/imgs/jardim_page.webp';

  static const tabHeaders = [
    'lib/imgs/oracoes_page.webp',
    'lib/imgs/novenas_page.webp',
    'lib/imgs/terco_page.webp',
    'lib/imgs/exame_page.webp',
  ];

  static const mysteries = [
    'lib/imgs/misterios_gozosos.webp',
    'lib/imgs/misterios_dolorosos.webp',
    'lib/imgs/misterios_gloriosos.webp',
  ];

  /// Todas as fotos de cabeçalho.
  static const headers = [garden, ...tabHeaders, ...mysteries];

  /// Ajusta [headerWidth] à largura da tela em pixels (entre 480 e 900).
  static void configure(BuildContext context) {
    final mq = MediaQuery.maybeOf(context);
    if (mq == null || mq.size.width <= 0) return;
    final px = (mq.size.width * mq.devicePixelRatio).round();
    headerWidth = math.min(900, math.max(480, px));
  }

  static ImageProvider header(String path) => ResizeImage(AssetImage(path), width: headerWidth);

  static Future<void> _precache(BuildContext context, List<String> paths) async {
    for (final path in paths) {
      if (!context.mounted) return;
      await precacheImage(header(path), context).catchError((_) {});
    }
  }

  /// Na entrada: só a foto do Jardim (a primeira tela).
  static Future<void> precacheStart(BuildContext context) {
    configure(context);
    return _precache(context, const [garden]);
  }

  /// Depois que o app abriu: as fotos das outras abas.
  static Future<void> precacheTabs(BuildContext context) => _precache(context, tabHeaders);

  /// Ao abrir o Santo Terço: as fotos dos mistérios.
  static Future<void> precacheMysteries(BuildContext context) => _precache(context, mysteries);
}
