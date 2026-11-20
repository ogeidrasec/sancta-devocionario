// As imagens pré-carregadas na entrada existem e estão declaradas no pubspec;
// e os cabeçalhos usam o mesmo tamanho (senão o pré-carregamento não vale).
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sanctaconscientia/utils/app_images.dart';

void main() {
  test('imagens de cabeçalho existem e estão no pubspec', () {
    final pubspec = File('pubspec.yaml').readAsStringSync();
    for (final path in AppImages.headers) {
      expect(File(path).existsSync(), isTrue, reason: path);
      expect(pubspec.contains(path), isTrue, reason: '$path fora do pubspec');
    }
  });

  test('toda imagem de cabeçalho usada nas páginas é pré-carregada', () {
    final used = <String>{};
    for (final f in Directory('lib').listSync(recursive: true).whereType<File>()) {
      if (!f.path.endsWith('.dart')) continue;
      used.addAll(RegExp(r"lib/imgs/[a-z_]+\.webp").allMatches(f.readAsStringSync()).map((m) => m.group(0)!));
    }
    expect(used.difference(AppImages.headers.toSet()), isEmpty);
  });

  test('ícone e logo pequenos existem, estão no pubspec e não passam de 640 px', () {
    final pubspec = File('pubspec.yaml').readAsStringSync();
    for (final path in [AppImages.icon, AppImages.logo]) {
      expect(File(path).existsSync(), isTrue, reason: path);
      expect(pubspec.contains(path), isTrue, reason: '$path fora do pubspec');
      expect(File(path).lengthSync(), lessThan(200 * 1024), reason: path);
    }
    // os originais grandes não vão mais dentro do app
    expect(pubspec.contains('    - lib/imgs/sancta_icon.png'), isFalse);
    expect(pubspec.contains('    - lib/imgs/sancta_splashscreen.png'), isFalse);
  });

  test('nenhuma página usa largura fixa de imagem (usa a da tela)', () {
    for (final f in Directory('lib').listSync(recursive: true).whereType<File>()) {
      if (!f.path.endsWith('.dart')) continue;
      expect(f.readAsStringSync().contains('cacheWidth: 900'), isFalse, reason: f.path);
    }
  });
}
