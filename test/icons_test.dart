// Ícones que não combinam com o app católico (meditação, lótus, etc.) não
// podem voltar ao código.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('sem ícones de meditação, lótus ou outros alheios à fé', () {
    const banned = [
      'Icons.self_improvement', // pessoa meditando de pernas cruzadas
      'Icons.spa', // lótus (também cobre spa_outlined/rounded)
      'Icons.psychology', // cérebro (também cobre psychology_alt)
      'Icons.ac_unit', // floco de neve
      'Icons.emoji_nature',
      "'spa'", // nome usado no mapa de ícones das categorias
      "'self_improvement'",
    ];
    final offenders = <String>[];
    for (final entity in Directory('lib').listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      final path = entity.path.replaceAll('\\', '/');
      if (path.contains('/Backup/')) continue;
      final lines = entity.readAsLinesSync();
      for (var i = 0; i < lines.length; i++) {
        final line = lines[i];
        if (line.trim().startsWith('//')) continue;
        for (final b in banned) {
          if (line.contains(b)) offenders.add('$path:${i + 1}: $b');
        }
      }
    }
    expect(offenders, isEmpty, reason: 'Ícones não permitidos:\n${offenders.join('\n')}');
  });
}
