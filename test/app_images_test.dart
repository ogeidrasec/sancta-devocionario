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
}
