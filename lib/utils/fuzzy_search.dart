import 'dart:math' as math;

/// Um trecho de texto de um item pesquisável, com o peso dele no resultado.
/// [fuzzy]: aceita erros de digitação (use em títulos e textos curtos).
class SearchField {
  final String text;
  final double weight;
  final bool fuzzy;
  const SearchField(this.text, {this.weight = 1.0, this.fuzzy = false});
}

class SearchHit<T> {
  final T item;
  final double score;
  const SearchHit(this.item, this.score);
}

/// Busca tolerante: ignora maiúsculas e acentos, aceita plural/flexões
/// ("mentira", "mentiras", "mentir"), erros de digitação ("ladainas") e
/// palavras de sentido próximo (sinônimos: "roubar" encontra "furto").
class FuzzySearch {
  FuzzySearch._();

  static const _accents = {
    'á': 'a', 'à': 'a', 'â': 'a', 'ã': 'a', 'ä': 'a', 'å': 'a',
    'é': 'e', 'è': 'e', 'ê': 'e', 'ë': 'e',
    'í': 'i', 'ì': 'i', 'î': 'i', 'ï': 'i',
    'ó': 'o', 'ò': 'o', 'ô': 'o', 'õ': 'o', 'ö': 'o',
    'ú': 'u', 'ù': 'u', 'û': 'u', 'ü': 'u',
    'ç': 'c', 'ñ': 'n', 'ý': 'y', 'æ': 'a', 'œ': 'o',
  };

  static const _stopwords = {
    'de', 'da', 'do', 'das', 'dos', 'e', 'o', 'a', 'as', 'os', 'um', 'uma', 'para', 'por', 'com', 'em', 'no', 'na',
    'nos', 'nas', 'que', 'se', 'ao', 'the', 'of', 'and', 'to', 'in', 'for', 'on', 'my', 'is',
  };

  /// Minúsculas, sem acentos e com tudo que não é letra/número virando espaço.
  /// Cada caractere vira exatamente um (o tamanho não muda), então posições
  /// no texto dobrado valem para o texto original.
  static String fold(String s) {
    final out = StringBuffer();
    for (final rune in s.runes) {
      var ch = String.fromCharCode(rune).toLowerCase();
      ch = _accents[ch] ?? ch;
      final c = ch.codeUnitAt(0);
      final isAlnum = ch.length == 1 && ((c >= 48 && c <= 57) || (c >= 97 && c <= 122));
      out.write(isAlnum ? ch : ' ');
    }
    return out.toString();
  }

  static List<String> tokenize(String s) =>
      fold(s).split(' ').where((t) => t.isNotEmpty).toList();

  /// Palavras da consulta que valem a pena procurar (sem "de", "da", "the"…).
  static List<String> queryTokens(String query) {
    final all = tokenize(query);
    final useful = all.where((t) => !_stopwords.contains(t)).toList();
    return useful.isEmpty ? all : useful;
  }

  // ------------------------------------------------------------------
  // Sinônimos: grupos de palavras de sentido próximo (português e inglês).
  // Basta uma palavra do grupo na busca para achar as outras.
  // ------------------------------------------------------------------
  static const List<List<String>> synonymGroups = [
    // Pecados e vida moral
    ['roubar', 'furtar', 'roubo', 'furto', 'ladrao', 'subtrair', 'apropriar', 'steal', 'theft', 'robbery', 'stole'],
    ['mentir', 'mentira', 'falsidade', 'enganar', 'engano', 'fraude', 'lie', 'lying', 'deceit', 'deceive', 'false'],
    ['calunia', 'difamar', 'difamacao', 'fofoca', 'maledicencia', 'detracao', 'slander', 'gossip', 'defame'],
    ['raiva', 'ira', 'colera', 'odio', 'rancor', 'briga', 'brigar', 'briguei', 'agressao', 'anger', 'wrath', 'hatred', 'fight'],
    ['preguica', 'acidia', 'ociosidade', 'desleixo', 'desanimo', 'laziness', 'sloth', 'idleness'],
    ['gula', 'comilanca', 'bebedeira', 'embriaguez', 'alcool', 'bebida', 'gluttony', 'drunkenness', 'alcohol'],
    ['luxuria', 'impureza', 'impuro', 'pornografia', 'adulterio', 'fornicacao', 'masturbacao', 'castidade', 'lust', 'impurity', 'chastity', 'adultery'],
    ['orgulho', 'soberba', 'vaidade', 'arrogancia', 'presuncao', 'pride', 'vanity', 'arrogance'],
    ['inveja', 'ciume', 'ciumes', 'cobica', 'envy', 'jealousy', 'covet'],
    ['avareza', 'ganancia', 'avidez', 'usura', 'dinheiro', 'avarice', 'greed', 'money'],
    ['aborto', 'matar', 'homicidio', 'assassinato', 'eutanasia', 'abortion', 'kill', 'murder', 'euthanasia'],
    ['blasfemia', 'blasfemar', 'palavrao', 'praguejar', 'xingar', 'juramento', 'jurar', 'blasphemy', 'swear', 'curse', 'oath'],
    ['fe', 'duvida', 'incredulidade', 'heresia', 'supersticao', 'horoscopo', 'magia', 'ocultismo', 'tarot', 'doubt', 'faith', 'superstition', 'occult'],
    ['missa', 'domingo', 'preceito', 'culto', 'sunday', 'mass', 'obligation'],
    ['jejum', 'abstinencia', 'penitencia', 'mortificacao', 'fasting', 'abstinence', 'penance'],
    ['confissao', 'confessar', 'confesso', 'sacramento', 'confession', 'confess', 'sacrament'],
    ['pais', 'mae', 'genitores', 'familia', 'parents', 'mother', 'family'],
    ['trabalho', 'emprego', 'profissao', 'servico', 'work', 'job', 'labor'],
    ['internet', 'redes', 'celular', 'televisao', 'tela', 'jogo', 'phone', 'screen', 'social', 'game', 'gaming'],
    // Orações, devoções e novenas
    ['terco', 'rosario', 'misterios', 'rosary', 'mysteries'],
    ['salve', 'rainha', 'regina', 'hail'],
    ['anjo', 'anjos', 'arcanjo', 'angel', 'angels', 'archangel', 'guarda'],
    ['espirito', 'paraclito', 'pentecostes', 'spirit', 'pentecost', 'veni', 'creator'],
    ['misericordia', 'piedade', 'compaixao', 'mercy', 'compassion'],
    ['coracao', 'heart'],
    ['maria', 'virgem', 'mary', 'virgin', 'lady', 'imaculada', 'conceicao'],
    ['jose', 'joseph', 'carpinteiro'],
    ['jesus', 'cristo', 'senhor', 'christ', 'lord', 'redentor'],
    ['sangue', 'blood', 'paixao', 'passion'],
    ['almas', 'defuntos', 'mortos', 'purgatorio', 'souls', 'dead', 'purgatory', 'eterno', 'descanso'],
    ['contricao', 'arrependimento', 'perdao', 'contrition', 'repentance', 'sorry', 'forgiveness'],
    ['comunhao', 'eucaristia', 'sacramento', 'hostia', 'sacrario', 'communion', 'eucharist', 'adoracao', 'adoration'],
    ['salmo', 'salmos', 'psalm', 'psalms', 'cantico'],
    ['ladainha', 'ladainhas', 'litany', 'litanies', 'invocacoes'],
    ['consagracao', 'consagrar', 'entrega', 'consecration', 'consecrate', 'totus', 'tuus'],
    ['natal', 'menino', 'christmas', 'nativity', 'advento', 'advent'],
    ['proteger', 'protecao', 'defesa', 'defender', 'protection', 'defend', 'miguel', 'michael'],
    ['saude', 'doenca', 'enfermo', 'enfermos', 'doente', 'cura', 'health', 'sick', 'illness', 'healing'],
    ['causas', 'impossiveis', 'dificeis', 'desesperadas', 'impossible', 'desperate', 'rita'],
    ['perdido', 'perdidos', 'achar', 'encontrar', 'lost', 'find', 'antonio', 'anthony'],
  ];

  static final Map<String, Set<int>> _groupMemo = {};

  /// Duas palavras parecem da mesma família (roubar/roubei, mentir/mentiu), mas
  /// não "mentira"/"mente": exige começo comum longo e palavras curtas ou
  /// começo de 5+ letras.
  static bool _relatedRoots(String a, String b) {
    final p = _commonPrefix(a, b);
    if (p < 4 || p < 0.6 * math.min(a.length, b.length)) return false;
    return p >= 5 || math.max(a.length, b.length) <= 6;
  }

  /// Para grupos de sinônimos o critério é mais rígido (começo de 5+ letras),
  /// senão "mente" cairia no grupo de "mentir".
  static bool _sameRoot(String a, String b) {
    if (a == b) return true;
    final p = _commonPrefix(a, b);
    return p >= 5 && p >= 0.6 * math.min(a.length, b.length);
  }

  static Set<int> _groupsOf(String token) {
    return _groupMemo.putIfAbsent(token, () {
      final ids = <int>{};
      for (var i = 0; i < synonymGroups.length; i++) {
        if (synonymGroups[i].any((w) => _sameRoot(token, w))) ids.add(i);
      }
      return ids;
    });
  }

  static int _commonPrefix(String a, String b) {
    final n = math.min(a.length, b.length);
    var i = 0;
    while (i < n && a.codeUnitAt(i) == b.codeUnitAt(i)) {
      i++;
    }
    return i;
  }

  /// Distância de edição (inserir, apagar, trocar, inverter letras vizinhas).
  static int editDistance(String a, String b, {int limit = 3}) {
    if ((a.length - b.length).abs() > limit) return limit + 1;
    final d = List.generate(a.length + 1, (_) => List.filled(b.length + 1, 0));
    for (var i = 0; i <= a.length; i++) {
      d[i][0] = i;
    }
    for (var j = 0; j <= b.length; j++) {
      d[0][j] = j;
    }
    for (var i = 1; i <= a.length; i++) {
      for (var j = 1; j <= b.length; j++) {
        final cost = a.codeUnitAt(i - 1) == b.codeUnitAt(j - 1) ? 0 : 1;
        var v = math.min(math.min(d[i - 1][j] + 1, d[i][j - 1] + 1), d[i - 1][j - 1] + cost);
        if (i > 1 && j > 1 && a.codeUnitAt(i - 1) == b.codeUnitAt(j - 2) && a.codeUnitAt(i - 2) == b.codeUnitAt(j - 1)) {
          v = math.min(v, d[i - 2][j - 2] + 1);
        }
        d[i][j] = v;
      }
    }
    return d[a.length][b.length];
  }

  /// Quão bem a palavra buscada [q] combina com a palavra do texto [d] (0 a 1).
  static double tokenScore(String q, String d, {bool fuzzy = false, Set<int>? qGroups}) {
    if (q == d) return 1.0;
    if (q.length < 3) return 0; // palavras de 1 ou 2 letras: só exatas
    if (d.startsWith(q)) return 0.9; // está digitando a palavra
    if (d.length >= 4 && q.startsWith(d)) return 0.75; // "mentiras" → "mentira"
    if (q.length >= 4 && d.length >= 4 && _relatedRoots(q, d)) return 0.7; // flexões: roubar/roubei
    // Só em textos curtos (títulos, itens do exame): sinônimos e erros de digitação.
    // Em textos longos (o corpo das orações) isso traria resultados demais.
    if (!fuzzy) return 0;
    if (qGroups != null && qGroups.isNotEmpty && d.length >= 4) {
      final dg = _groupsOf(d);
      if (dg.isNotEmpty && qGroups.any(dg.contains)) return 0.65;
    }
    if (q.length >= 4 && d.length >= 4) {
      final limit = q.length >= 8 ? 2 : 1;
      var dist = editDistance(q, d, limit: limit);
      if (d.length > q.length) {
        dist = math.min(dist, editDistance(q, d.substring(0, q.length), limit: limit)); // digitando com erro
      }
      if (dist <= limit) return 0.6 - 0.1 * (dist - 1).clamp(0, 2);
    }
    return 0;
  }

  /// Trecho do [text] (original) em volta da primeira palavra que combina com a busca.
  static String? snippet(String text, String query, {int radius = 45}) {
    final folded = fold(text);
    final qs = queryTokens(query);
    if (qs.isEmpty) return null;
    final groups = {for (final q in qs) q: _groupsOf(q)};
    final words = RegExp(r'[a-z0-9]+').allMatches(folded);
    for (final w in words) {
      final token = w.group(0)!;
      for (final q in qs) {
        if (tokenScore(q, token, qGroups: groups[q]) >= 0.65) {
          final start = math.max(0, w.start - radius);
          final end = math.min(text.length, w.end + radius);
          var s = text.substring(start, end).replaceAll(RegExp(r'\s+'), ' ').trim();
          if (start > 0) s = '…$s';
          if (end < text.length) s = '$s…';
          return s;
        }
      }
    }
    return null;
  }
}

class _IndexedField {
  final Set<String> tokens;
  final String folded;
  final double weight;
  final bool fuzzy;
  _IndexedField(this.tokens, this.folded, this.weight, this.fuzzy);
}

class _Doc<T> {
  final T item;
  final int order;
  final List<_IndexedField> fields;
  _Doc(this.item, this.order, this.fields);
}

/// Índice de busca: monta as palavras de cada item uma vez e responde rápido
/// a cada letra digitada.
class SearchIndex<T> {
  final List<_Doc<T>> _docs = [];

  SearchIndex(Iterable<T> items, List<SearchField> Function(T item) fieldsOf) {
    var order = 0;
    for (final item in items) {
      final fields = <_IndexedField>[];
      for (final f in fieldsOf(item)) {
        final tokens = FuzzySearch.tokenize(f.text).toSet();
        fields.add(_IndexedField(tokens, FuzzySearch.fold(f.text).replaceAll(RegExp(r' +'), ' ').trim(), f.weight, f.fuzzy));
      }
      _docs.add(_Doc<T>(item, order++, fields));
    }
  }

  /// Resultados do mais ao menos parecido. Primeiro exige todas as palavras da
  /// busca; se nada servir, aceita itens que combinam com alguma delas
  /// ([approximate] fica verdadeiro nesse caso).
  ({List<SearchHit<T>> hits, bool approximate}) search(String query) {
    final qs = FuzzySearch.queryTokens(query);
    if (qs.isEmpty) return (hits: <SearchHit<T>>[], approximate: false);

    var hits = _run(qs, requireAll: true, query: query);
    if (hits.isNotEmpty || qs.length < 2) return (hits: hits, approximate: false);
    hits = _run(qs, requireAll: false, query: query);
    return (hits: hits, approximate: hits.isNotEmpty);
  }

  List<SearchHit<T>> _run(List<String> qs, {required bool requireAll, required String query}) {
    final groups = {for (final q in qs) q: FuzzySearch._groupsOf(q)};
    final phrase = FuzzySearch.fold(query).replaceAll(RegExp(r' +'), ' ').trim();
    final scored = <(_Doc<T>, double)>[];

    for (final doc in _docs) {
      var total = 0.0;
      var matched = 0;
      for (final q in qs) {
        var best = 0.0;
        for (final f in doc.fields) {
          for (final d in f.tokens) {
            final s = FuzzySearch.tokenScore(q, d, fuzzy: f.fuzzy, qGroups: groups[q]) * f.weight;
            if (s > best) best = s;
          }
        }
        if (best > 0) matched++;
        total += best;
      }
      if (matched == 0 || (requireAll && matched < qs.length)) continue;
      var score = total / qs.length;
      // Bônus: a frase inteira aparece no texto (mais ainda se for no título)
      if (phrase.length >= 3) {
        for (final f in doc.fields) {
          if (f.folded.contains(phrase)) score += 0.5 * f.weight;
        }
      }
      scored.add((doc, score));
    }

    scored.sort((a, b) {
      final c = b.$2.compareTo(a.$2);
      return c != 0 ? c : a.$1.order.compareTo(b.$1.order);
    });
    return [for (final s in scored) SearchHit<T>(s.$1.item, s.$2)];
  }
}
