// Novena dos Santos Anjos da Guarda: de 23 de setembro a 1º de outubro.
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanctaconscientia/data/novena_data.dart';
import 'package:sanctaconscientia/data/novena_feasts.dart';
import 'package:sanctaconscientia/models/novena_content.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';

void main() {
  test('começa em 23 de setembro, termina em 1º de outubro, festa em 2 de outubro', () {
    final s = NovenaFeasts.suggestionsFor(DateTime(2027, 9, 23)).where((x) => x.novenaId == 'novena_anjos_guarda');
    expect(s, hasLength(1));
    expect(s.first.start, DateTime(2027, 9, 23));
    expect(s.first.feast, DateTime(2027, 10, 2));
    expect(s.first.feast.subtract(const Duration(days: 1)), DateTime(2027, 10, 1));
  });

  for (final loc in ['pt', 'en']) {
    testWidgets('conteúdo em $loc: texto corrido, sem quebras de linha soltas nem erros de acento', (tester) async {
      late NovenaContent n;
      await tester.pumpWidget(MaterialApp(
        locale: Locale(loc),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(builder: (c) {
          n = NovenaData.getNovenaById(c, 'novena_anjos_guarda');
          return const SizedBox();
        }),
      ));
      expect(n.id, 'novena_anjos_guarda');
      expect(n.openingPrayer, isNotEmpty);
      expect(n.closingPrayer, isNotEmpty);
      // cada oração é um parágrafo só: quebras apenas entre orações (linha em branco)
      for (final t in [n.openingPrayer, n.prayerInstruction]) {
        expect(t.replaceAll('\n\n', ''), isNot(contains('\n')));
        expect(t, isNot(contains('  ')));
      }
      if (loc == 'pt') {
        for (final erro in ['nao ', 'ate ', 'presenca', 'habitacao', 'fidelissimos', 'beneficos', 'tentacões', 'Está é']) {
          expect('${n.openingPrayer}${n.prayerInstruction}', isNot(contains(erro)), reason: erro);
        }
      }
    });
  }
}
