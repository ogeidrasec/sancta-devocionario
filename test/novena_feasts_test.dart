// Festas das novenas e sugestão de início no tempo certo.
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/widgets/novena_suggestion_card.dart';
import 'package:sanctaconscientia/data/novena_feasts.dart';

void main() {
  cardTests();
  test('Páscoa e festas móveis', () {
    expect(NovenaFeasts.easter(2026), DateTime(2026, 4, 5));
    expect(NovenaFeasts.easter(2027), DateTime(2027, 3, 28));
    // Divina Misericórdia: domingo depois da Páscoa; novena começa na Sexta-feira Santa
    expect(NovenaFeasts.feastIn('novena_misericordia', 2026), DateTime(2026, 4, 12));
    final s = NovenaFeasts.suggestionsFor(DateTime(2026, 4, 3)).where((x) => x.novenaId == 'novena_misericordia');
    expect(s.single.start, DateTime(2026, 4, 3));
    expect(DateTime(2026, 4, 3).weekday, DateTime.friday);
    // Sagrado Coração: sexta-feira
    expect(NovenaFeasts.feastIn('novena_sagrado_coracao', 2026), DateTime(2026, 6, 12));
    expect(DateTime(2026, 6, 12).weekday, DateTime.friday);
    // Pentecostes: domingo
    expect(NovenaFeasts.feastIn('novena_pentecostes', 2026), DateTime(2026, 5, 24));
    expect(DateTime(2026, 5, 24).weekday, DateTime.sunday);
  });

  test('Cristo Rei cai sempre no domingo antes do Advento', () {
    expect(NovenaFeasts.christTheKing(2026), DateTime(2026, 11, 22));
    expect(NovenaFeasts.christTheKing(2025), DateTime(2025, 11, 23));
    for (var y = 2024; y <= 2034; y++) {
      final d = NovenaFeasts.christTheKing(y);
      expect(d.weekday, DateTime.sunday, reason: '$y');
      expect(d.month, 11);
    }
  });

  test('Aparecida: sugestão começa 9 dias antes da festa de 12 de outubro', () {
    final onStart = NovenaFeasts.suggestionsFor(DateTime(2026, 10, 3));
    final a = onStart.firstWhere((x) => x.novenaId == 'novena_aparecida');
    expect(a.start, DateTime(2026, 10, 3));
    expect(a.feast, DateTime(2026, 10, 12));
    expect(a.daysUntilStart(DateTime(2026, 10, 3)), 0);

    // 3 dias antes ainda aparece (começa em 3 dias); 4 dias antes não
    expect(NovenaFeasts.suggestionsFor(DateTime(2026, 9, 30)).any((x) => x.novenaId == 'novena_aparecida'), isTrue);
    expect(NovenaFeasts.suggestionsFor(DateTime(2026, 9, 29)).any((x) => x.novenaId == 'novena_aparecida'), isFalse);
    // atraso: ainda aparece até 2 dias depois do início ideal
    expect(NovenaFeasts.suggestionsFor(DateTime(2026, 10, 5)).any((x) => x.novenaId == 'novena_aparecida'), isTrue);
    expect(NovenaFeasts.suggestionsFor(DateTime(2026, 10, 6)).any((x) => x.novenaId == 'novena_aparecida'), isFalse);
  });

  test('a virada do ano é tratada (Natal começa em 16 de dezembro)', () {
    expect(NovenaFeasts.suggestionsFor(DateTime(2026, 12, 14)).any((x) => x.novenaId == 'novena_natal'), isTrue);
    // janeiro: novena de um ano para o outro não quebra
    expect(() => NovenaFeasts.suggestionsFor(DateTime(2026, 12, 31)), returnsNormally);
  });

  test('toda novena do app tem data de festa', () {
    final source = File('lib/data/novena_data.dart').readAsStringSync();
    final ids = RegExp(r"id: '(novena_[a-z_]+)'").allMatches(source).map((m) => m.group(1)!).toSet();
    expect(ids.length, greaterThanOrEqualTo(17));
    for (final id in ids) {
      expect(NovenaFeasts.feastIn(id, 2026), isNotNull, reason: 'sem festa para $id');
    }
  });
}

// Cartão de sugestão: aparece com o texto certo em português e inglês.
class _Harness extends StatelessWidget {
  final Locale locale;
  final NovenaSuggestion suggestion;
  const _Harness(this.locale, this.suggestion);

  @override
  Widget build(BuildContext context) => MaterialApp(
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: NovenaSuggestionCard(suggestion: suggestion)),
      );
}

void cardTests() {
  final today = DateTime.now();
  final t0 = DateTime(today.year, today.month, today.day);

  testWidgets('cartão: começa hoje (pt)', (tester) async {
    final s = NovenaSuggestion(novenaId: 'novena_aparecida', start: t0, feast: t0.add(const Duration(days: 9)));
    await tester.pumpWidget(_Harness(const Locale('pt'), s));
    await tester.pumpAndSettle();
    expect(find.text('Novena a Nossa Senhora Aparecida'), findsOneWidget);
    expect(find.textContaining('Hoje é o dia ideal'), findsOneWidget);
    expect(find.text('SUGESTÃO PARA ESTA ÉPOCA'), findsOneWidget);
  });

  testWidgets('cartão: em 2 dias (en)', (tester) async {
    final s = NovenaSuggestion(
        novenaId: 'novena_fatima', start: t0.add(const Duration(days: 2)), feast: t0.add(const Duration(days: 11)));
    await tester.pumpWidget(_Harness(const Locale('en'), s));
    await tester.pumpAndSettle();
    expect(find.text('Novena to Our Lady of Fátima'), findsOneWidget);
    expect(find.textContaining('Begins in 2 days'), findsOneWidget);
  });

  testWidgets('cartão: atrasado (pt)', (tester) async {
    final s = NovenaSuggestion(
        novenaId: 'novena_santa_rita', start: t0.subtract(const Duration(days: 1)), feast: t0.add(const Duration(days: 8)));
    await tester.pumpWidget(_Harness(const Locale('pt'), s));
    await tester.pumpAndSettle();
    expect(find.textContaining('Ainda dá tempo'), findsOneWidget);
  });
}
