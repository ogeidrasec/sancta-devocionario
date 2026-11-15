// Garante que o app está traduzido por inteiro nos dois idiomas e que nenhum
// texto visível ficou escrito direto no código (fora dos arquivos de tradução).
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

Map<String, dynamic> _load(String path) =>
    jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;

/// Chaves de primeiro nível na ordem do arquivo (o JSON em si esconde repetições).
List<String> _topLevelKeys(String path) {
  final keys = <String>[];
  final re = RegExp(r'^  "([^"@][^"]*)"\s*:', multiLine: true);
  for (final m in re.allMatches(File(path).readAsStringSync())) {
    keys.add(m.group(1)!);
  }
  return keys;
}

/// Nomes dos parâmetros: {nome} direto ou o de um plural/select ({count, plural, ...}).
/// Palavras dentro dos ramos (=1{dia} other{dias}) não são parâmetros.
Set<String> _params(String message) {
  final plural = RegExp(r'\{(\w+),\s*(?:plural|select)').allMatches(message).map((m) => m.group(1)!);
  final direct = RegExp(r'(?<![=\w])\{(\w+)\}').allMatches(message).map((m) => m.group(1)!);
  return {...plural, ...direct};
}

void main() {
  const ptPath = 'lib/l10n/app_pt.arb';
  const enPath = 'lib/l10n/app_en.arb';
  final pt = _load(ptPath);
  final en = _load(enPath);
  Map<String, String> messages(Map<String, dynamic> d) => {
        for (final e in d.entries)
          if (!e.key.startsWith('@') && e.value is String) e.key: e.value as String,
      };
  final ptMsgs = messages(pt);
  final enMsgs = messages(en);

  group('Arquivos de tradução (ARB)', () {
    test('as mesmas chaves em português e inglês', () {
      expect(enMsgs.keys.toSet().difference(ptMsgs.keys.toSet()), isEmpty,
          reason: 'chaves só no inglês');
      expect(ptMsgs.keys.toSet().difference(enMsgs.keys.toSet()), isEmpty,
          reason: 'chaves sem tradução para o inglês');
    });

    test('nenhuma chave repetida (a última valeria em silêncio)', () {
      for (final path in [ptPath, enPath]) {
        final keys = _topLevelKeys(path);
        final seen = <String>{};
        final dup = keys.where((k) => !seen.add(k)).toSet();
        expect(dup, isEmpty, reason: 'chaves repetidas em $path');
      }
    });

    test('os mesmos parâmetros em português e inglês', () {
      final diff = <String>[];
      for (final k in ptMsgs.keys) {
        final e = enMsgs[k];
        if (e == null) continue;
        if (_params(ptMsgs[k]!).difference(_params(e)).isNotEmpty ||
            _params(e).difference(_params(ptMsgs[k]!)).isNotEmpty) {
          diff.add('$k: pt${_params(ptMsgs[k]!)} en${_params(e)}');
        }
      }
      expect(diff, isEmpty);
    });

    test('nenhuma mensagem vazia', () {
      expect(ptMsgs.entries.where((e) => e.value.trim().isEmpty && !e.key.endsWith('Closing')), isEmpty);
    });
  });

  group('Texto escrito direto no código', () {
    // Arquivos em que texto em português é intencional.
    const allowedFiles = {
      'lib/utils/notification_strings.dart', // dicionário pt/en das notificações
      'lib/pages/plano_vida/meu_plano_tab.dart', // tela antiga, sem uso
      'lib/models/scheduled_prayer.dart', // rótulos sem uso na interface
    };
    // Textos padrão gravados no banco no primeiro uso (a tela mostra o título do catálogo).
    const allowedSnippets = {
      'Oferecimento do Dia',
      'Angelus / Regina Caeli',
      'Santo Terço',
      'Exame Diário',
      'Oração da Noite',
      'Hora de Rezar', // título antigo (compatibilidade)
      'Lembrete de Oração', // idem: título padrão antigo, só usado para comparar
    };

    test('sem frases em português nos arquivos de código', () {
      final accent = RegExp(r'[ãõçáéíóúâêôà]');
      final literal = RegExp(r'''(["'])((?:(?!\1)[^\\\n]|\\.)*)\1''');
      final offenders = <String>[];

      for (final entity in Directory('lib').listSync(recursive: true)) {
        if (entity is! File || !entity.path.endsWith('.dart')) continue;
        final path = entity.path.replaceAll('\\', '/');
        if (path.contains('/l10n/') || allowedFiles.contains(path)) continue;

        final lines = entity.readAsLinesSync();
        for (var i = 0; i < lines.length; i++) {
          final line = lines[i];
          final trimmed = line.trim();
          if (trimmed.startsWith('//') || trimmed.startsWith('import') || trimmed.contains('debugPrint')) continue;
          final code = line.replaceFirst(RegExp(r'\s//.*$'), '');
          for (final m in literal.allMatches(code)) {
            final text = m.group(2)!;
            if (text.length < 3 || text.startsWith('package:')) continue;
            if (!accent.hasMatch(text)) continue;
            if (allowedSnippets.any(text.contains)) continue;
            offenders.add('$path:${i + 1}: $text');
          }
        }
      }
      expect(offenders, isEmpty,
          reason: 'Texto em português fora dos arquivos de tradução:\n${offenders.join('\n')}');
    });
  });
}
