/// Sugestão de começar uma novena: a novena termina na véspera da festa,
/// então começa 9 dias antes dela.
class NovenaSuggestion {
  final String novenaId;
  final DateTime start;
  final DateTime feast;
  const NovenaSuggestion({required this.novenaId, required this.start, required this.feast});

  /// Dias até o início ideal (negativo se já passou).
  int daysUntilStart(DateTime today) => start.difference(_dateOnly(today)).inDays;
}

DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

/// Datas das festas de cada novena (as móveis saem da data da Páscoa).
class NovenaFeasts {
  NovenaFeasts._();

  /// Domingo de Páscoa (algoritmo de Meeus/Jones/Butcher).
  static DateTime easter(int y) {
    final a = y % 19;
    final b = y ~/ 100;
    final c = y % 100;
    final d = b ~/ 4;
    final e = b % 4;
    final f = (b + 8) ~/ 25;
    final g = (b - f + 1) ~/ 3;
    final h = (19 * a + b - d - g + 15) % 30;
    final i = c ~/ 4;
    final k = c % 4;
    final l = (32 + 2 * e + 2 * i - h - k) % 7;
    final m = (a + 11 * h + 22 * l) ~/ 451;
    final month = (h + l - 7 * m + 114) ~/ 31;
    final day = ((h + l - 7 * m + 114) % 31) + 1;
    return DateTime(y, month, day);
  }

  /// Solenidade de Cristo Rei: domingo antes do 1º domingo do Advento.
  static DateTime christTheKing(int y) {
    final christmas = DateTime(y, 12, 25);
    final w = christmas.weekday % 7; // domingo = 0
    final advent1 = christmas.subtract(Duration(days: w == 0 ? 28 : w + 21));
    return advent1.subtract(const Duration(days: 7));
  }

  static DateTime? feastIn(String novenaId, int y) {
    switch (novenaId) {
      case 'novena_natal':
        return DateTime(y, 12, 25);
      case 'novena_carlo_acutis':
      case 'novena_aparecida':
        return DateTime(y, 10, 12);
      case 'novena_teresa_lisieux':
        return DateTime(y, 10, 1);
      case 'novena_sagrado_coracao':
        return easter(y).add(const Duration(days: 68));
      case 'novena_conceicao':
        return DateTime(y, 12, 8);
      case 'novena_sao_jose':
        return DateTime(y, 3, 19);
      case 'novena_sao_judas':
        return DateTime(y, 10, 28);
      case 'novena_pentecostes':
        return easter(y).add(const Duration(days: 49));
      case 'novena_perpetuo_socorro':
        return DateTime(y, 6, 27);
      case 'novena_sao_miguel':
        return DateTime(y, 9, 29);
      case 'novena_almas':
        return DateTime(y, 11, 2);
      case 'novena_fatima':
        return DateTime(y, 5, 13);
      case 'novena_misericordia':
        return easter(y).add(const Duration(days: 7));
      case 'novena_santo_antonio':
        return DateTime(y, 6, 13);
      case 'novena_santa_rita':
        return DateTime(y, 5, 22);
      case 'novena_cristo_rei':
        return christTheKing(y);
    }
    return null;
  }

  static const List<String> _ids = [
    'novena_natal',
    'novena_carlo_acutis',
    'novena_teresa_lisieux',
    'novena_sagrado_coracao',
    'novena_conceicao',
    'novena_sao_jose',
    'novena_sao_judas',
    'novena_pentecostes',
    'novena_perpetuo_socorro',
    'novena_sao_miguel',
    'novena_almas',
    'novena_aparecida',
    'novena_fatima',
    'novena_misericordia',
    'novena_santo_antonio',
    'novena_santa_rita',
    'novena_cristo_rei',
  ];

  /// Novenas cujo início ideal (festa − 9 dias) cai de [lookBackDays] dias atrás
  /// até [lookAheadDays] dias à frente, da mais próxima da data à mais distante.
  static List<NovenaSuggestion> suggestionsFor(
    DateTime today, {
    int lookBackDays = 2,
    int lookAheadDays = 3,
  }) {
    final base = _dateOnly(today);
    final out = <NovenaSuggestion>[];
    for (final id in _ids) {
      for (final year in [base.year, base.year + 1]) {
        final feast = feastIn(id, year);
        if (feast == null) continue;
        final start = feast.subtract(const Duration(days: 9));
        final diff = start.difference(base).inDays;
        if (diff >= -lookBackDays && diff <= lookAheadDays) {
          out.add(NovenaSuggestion(novenaId: id, start: start, feast: feast));
        }
      }
    }
    out.sort((a, b) => a.start.difference(base).inDays.abs().compareTo(b.start.difference(base).inDays.abs()));
    return out;
  }
}
