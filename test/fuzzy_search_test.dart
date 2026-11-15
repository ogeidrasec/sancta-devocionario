// Busca tolerante: acentos, plural/flexões, erros de digitação e sinônimos.
import 'package:flutter_test/flutter_test.dart';
import 'package:sanctaconscientia/utils/fuzzy_search.dart';

typedef Doc = ({String title, String body});

SearchIndex<Doc> index(List<Doc> docs) => SearchIndex<Doc>(docs, (d) => [
      SearchField(d.title, weight: 3, fuzzy: true),
      SearchField(d.body),
    ]);

List<String> titles(SearchIndex<Doc> i, String q) => i.search(q).hits.map((h) => h.item.title).toList();

void main() {
  group('fold / tokens', () {
    test('minúsculas e sem acentos, mantendo o tamanho', () {
      expect(FuzzySearch.fold('Ação, Coração! Ç'), 'acao  coracao  c');
      expect('Ação, Coração! Ç'.length, FuzzySearch.fold('Ação, Coração! Ç').length);
      expect(FuzzySearch.tokenize('Santo Terço (1/2)'), ['santo', 'terco', '1', '2']);
    });

    test('palavras de ligação são ignoradas, a menos que sejam tudo', () {
      expect(FuzzySearch.queryTokens('oração de São Miguel'), ['oracao', 'sao', 'miguel']);
      expect(FuzzySearch.queryTokens('de da'), ['de', 'da']);
    });
  });

  group('distância de edição', () {
    test('troca, inserção, remoção e letras invertidas valem 1', () {
      expect(FuzzySearch.editDistance('ladainha', 'ladainhas'), 1);
      expect(FuzzySearch.editDistance('mentria', 'mentira'), 1);
      expect(FuzzySearch.editDistance('confisao', 'confissao'), 1);
      expect(FuzzySearch.editDistance('terco', 'tarco'), 1);
      expect(FuzzySearch.editDistance('abc', 'xyz', limit: 1), greaterThan(1));
    });
  });

  group('orações (títulos tolerantes, texto exato)', () {
    final idx = index([
      (title: 'Santo Terço', body: 'Rezar o rosário com os mistérios do dia'),
      (title: 'Ladainha de Nossa Senhora', body: 'Santa Maria, rogai por nós'),
      (title: 'Oração a São Miguel Arcanjo', body: 'defendei-nos no combate'),
      (title: 'Ato de Contrição', body: 'pesa-me de todo o coração de vos ter ofendido'),
      (title: 'Salmo 129 (De Profundis)', body: 'Das profundezas clamo a vós, Senhor'),
      (title: 'Anjo da Guarda', body: 'Santo Anjo do Senhor, meu zeloso guardador'),
    ]);

    test('acentos e maiúsculas não importam', () {
      expect(titles(idx, 'ORACAO'), ['Oração a São Miguel Arcanjo']);
      expect(titles(idx, 'contricao'), ['Ato de Contrição']);
      expect(titles(idx, 'sao miguel').first, 'Oração a São Miguel Arcanjo');
    });

    test('plural, singular e começo da palavra', () {
      expect(titles(idx, 'ladainhas'), contains('Ladainha de Nossa Senhora'));
      expect(titles(idx, 'lada'), contains('Ladainha de Nossa Senhora'));
      expect(titles(idx, 'anjos'), contains('Anjo da Guarda'));
    });

    test('erros de digitação', () {
      expect(titles(idx, 'ladainas'), contains('Ladainha de Nossa Senhora'));
      expect(titles(idx, 'contriçao'), contains('Ato de Contrição'));
      expect(titles(idx, 'arcajno'), contains('Oração a São Miguel Arcanjo'));
      expect(titles(idx, 'tarço'), contains('Santo Terço'));
    });

    test('sinônimos: rosário encontra o Santo Terço', () {
      expect(titles(idx, 'rosario').first, 'Santo Terço');
    });

    test('texto da oração é achado pela palavra ou pela raiz, sem sinônimos', () {
      expect(titles(idx, 'combate'), ['Oração a São Miguel Arcanjo']);
      expect(titles(idx, 'combates'), ['Oração a São Miguel Arcanjo']);
      expect(titles(idx, 'xombate'), isEmpty);
      // sinônimos valem nos títulos ("perdão" → Ato de Contrição), não no corpo
      expect(titles(idx, 'perdao'), ['Ato de Contrição']);
      expect(titles(idx, 'zeloso'), ['Anjo da Guarda']);
    });

    test('título vale mais que o corpo', () {
      final i = index([
        (title: 'Outra oração', body: 'terço terço terço'),
        (title: 'Santo Terço', body: ''),
      ]);
      expect(titles(i, 'terço').first, 'Santo Terço');
    });

    test('termos sem relação não trazem nada', () {
      expect(titles(idx, 'xilofone'), isEmpty);
      expect(titles(idx, 'zzzz'), isEmpty);
      expect(idx.search('').hits, isEmpty);
      expect(idx.search('   ').hits, isEmpty);
    });
  });

  group('várias palavras', () {
    final idx = index([
      (title: 'Novena a São José', body: ''),
      (title: 'Novena a São Miguel', body: ''),
      (title: 'Oração a São José', body: ''),
    ]);

    test('exige todas as palavras quando dá', () {
      expect(titles(idx, 'novena jose'), ['Novena a São José']);
    });

    test('se nenhuma serve inteira, mostra aproximados', () {
      final r = idx.search('novena antonio');
      expect(r.approximate, isTrue);
      expect(r.hits.map((h) => h.item.title), containsAll(['Novena a São José', 'Novena a São Miguel']));
    });
  });

  group('exame de consciência (sinônimos e flexões)', () {
    final sins = [
      'Roubei ou furtei coisas de outras pessoas.',
      'Menti para me livrar de problemas.',
      'Falei mal dos outros e espalhei fofocas.',
      'Deixei de ir à Missa aos domingos sem motivo grave.',
      'Tive raiva e briguei com meus familiares.',
      'Fui preguiçoso no trabalho e nos estudos.',
      'Fiz uso excessivo da internet e de jogos.',
    ];
    final idx = SearchIndex<String>(sins, (s) => [SearchField(s, fuzzy: true)]);
    List<String> find(String q) => idx.search(q).hits.map((h) => h.item).toList();

    test('palavras parecidas encontram o mesmo pecado', () {
      expect(find('roubar'), contains('Roubei ou furtei coisas de outras pessoas.'));
      expect(find('furto'), contains('Roubei ou furtei coisas de outras pessoas.'));
      expect(find('mentira'), contains('Menti para me livrar de problemas.'));
      expect(find('mentir'), contains('Menti para me livrar de problemas.'));
      expect(find('fofoca'), contains('Falei mal dos outros e espalhei fofocas.'));
      expect(find('calunia'), contains('Falei mal dos outros e espalhei fofocas.'));
      expect(find('ira'), contains('Tive raiva e briguei com meus familiares.'));
      expect(find('preguica'), contains('Fui preguiçoso no trabalho e nos estudos.'));
    });

    test('erros de digitação e acentos', () {
      expect(find('domingo'), contains('Deixei de ir à Missa aos domingos sem motivo grave.'));
      expect(find('mísa'), contains('Deixei de ir à Missa aos domingos sem motivo grave.'));
      expect(find('internte'), contains('Fiz uso excessivo da internet e de jogos.'));
    });

    test('inglês também', () {
      final en = SearchIndex<String>(
        ['I stole things from other people.', 'I lied to avoid problems.', 'I missed Mass on Sundays.'],
        (s) => [SearchField(s, fuzzy: true)],
      );
      expect(en.search('theft').hits.map((h) => h.item), contains('I stole things from other people.'));
      expect(en.search('lie').hits.map((h) => h.item), contains('I lied to avoid problems.'));
      expect(en.search('sunday').hits.map((h) => h.item), contains('I missed Mass on Sundays.'));
    });

    test('sem falsos positivos conhecidos', () {
      final idx2 = SearchIndex<String>([
        'Consenti em paixões ou pensamentos imorais quando vieram à mente.',
        'Causei morte, lesão física, briguei ou tive desejos de vingança.',
        'Trapaceei, cometi plágio ou violei direitos autorais sem causa séria.',
        'Tive apego excessivo a coisas ou criaturas.',
      ], (s) => [SearchField(s, fuzzy: true)]);
      List<String> f(String q) => idx2.search(q).hits.map((h) => h.item).toList();
      expect(f('mentira'), isEmpty); // "mente" (cabeça) não é "mentira"
      expect(f('jejum'), isEmpty); // "morte" não é "mortificação"
      expect(f('raiva'), contains('Causei morte, lesão física, briguei ou tive desejos de vingança.'));
      expect(f('raiva'), isNot(contains('Trapaceei, cometi plágio ou violei direitos autorais sem causa séria.')));
      expect(f('bebida'), isEmpty);
    });

    test('sem falsos positivos óbvios', () {
      expect(find('xilofone'), isEmpty);
      expect(find('roubar'), isNot(contains('Menti para me livrar de problemas.')));
    });
  });

  group('trecho', () {
    test('mostra o contexto da palavra encontrada', () {
      const text = 'Senhor, tende piedade de nós. Cristo, tende piedade de nós. Santa Maria, rogai por nós.';
      final s = FuzzySearch.snippet(text, 'rogai');
      expect(s, contains('rogai'));
      expect(FuzzySearch.snippet(text, 'inexistente'), isNull);
    });
  });
}
