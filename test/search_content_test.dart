// Busca de orações, novenas e itens do exame com os textos reais do app.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/models/categoria.dart';
import 'package:sanctaconscientia/pages/devotional_home_page.dart';
import 'package:sanctaconscientia/pages/novena_home_page.dart';
import 'package:sanctaconscientia/utils/content_search.dart';
import 'package:provider/provider.dart';
import 'package:sanctaconscientia/providers/prayer_provider.dart';
import 'package:sanctaconscientia/services/database_service.dart';
import 'package:sanctaconscientia/services/notification_service.dart';
import 'package:sanctaconscientia/services/reminder_service.dart';

/// Monta um app mínimo só para ter um BuildContext com o idioma escolhido.
Future<BuildContext> pumpContext(WidgetTester tester, String lang) async {
  late BuildContext captured;
  await tester.pumpWidget(MaterialApp(
    locale: Locale(lang),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Builder(builder: (c) {
      captured = c;
      return const SizedBox();
    }),
  ));
  await tester.pumpAndSettle();
  return captured;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('orações', () {
    testWidgets('acha por título, acento, plural, erro de digitação e sinônimo (pt)', (tester) async {
      final c = await pumpContext(tester, 'pt');
      List<String> titles(String q) =>
          PrayerSearch.search(c, q).hits.map((h) => h.prayer['title'] as String).toList();

      expect(titles('contricao'), contains('Ato de Contrição'));
      expect(titles('contriçao'), contains('Ato de Contrição'));
      expect(titles('ladainhas').length, greaterThanOrEqualTo(6));
      expect(titles('ladainas').length, greaterThanOrEqualTo(6)); // erro de digitação
      expect(titles('arcajno'), contains('Oração a São Miguel Arcanjo'));
      expect(titles('rosario').any((t) => t.toLowerCase().contains('terço')), isTrue); // sinônimo
      expect(titles('salmo'), contains('Salmo 129 (De Profundis)'));
      expect(titles('memorare'), contains('Lembrai-vos (Memorare)'));
      expect(titles('xilofone'), isEmpty);
    });

    testWidgets('acha pelo texto da oração e mostra um trecho', (tester) async {
      final c = await pumpContext(tester, 'pt');
      final r = PrayerSearch.search(c, 'defendei');
      expect(r.hits, isNotEmpty);
      expect(r.hits.first.snippet, isNotNull);
      expect(r.hits.first.snippet!.toLowerCase(), contains('defend'));
    });

    testWidgets('também em inglês', (tester) async {
      final c = await pumpContext(tester, 'en');
      List<String> titles(String q) =>
          PrayerSearch.search(c, q).hits.map((h) => h.prayer['title'] as String).toList();
      expect(titles('litanies').length, greaterThanOrEqualTo(6));
      expect(titles('contrition'), contains('Act of Contrition'));
      expect(titles('mercy').isNotEmpty, isTrue);
    });
  });

  group('novenas', () {
    testWidgets('por santo, acento, parte do nome e erro de digitação', (tester) async {
      final c = await pumpContext(tester, 'pt');
      List<String> titles(String q) => NovenaSearch.search(c, q).hits.map((n) => n.title).toList();

      expect(titles('aparecida').first, 'Novena a Nossa Senhora Aparecida');
      expect(titles('antonio').first, 'Novena a Santo Antônio');
      expect(titles('misericordia').first, contains('Misericórdia'));
      expect(titles('fatima').first, contains('Fátima'));
      expect(titles('judas').first, contains('Judas'));
      expect(titles('apareceda'), contains('Novena a Nossa Senhora Aparecida')); // erro de digitação
      expect(titles('rit').first, contains('Rita'));
      expect(titles('cristo rei').first, contains('Cristo Rei'));
      expect(titles('qwertyuiop'), isEmpty);
    });

    testWidgets('em inglês', (tester) async {
      final c = await pumpContext(tester, 'en');
      expect(NovenaSearch.search(c, 'anthony').hits.first.title, contains('Anthony'));
      expect(NovenaSearch.search(c, 'mercy').hits.first.title, contains('Mercy'));
    });
  });

  group('exame de consciência', () {
    testWidgets('palavras parecidas acham os mesmos itens (pt)', (tester) async {
      final c = await pumpContext(tester, 'pt');
      final cats = Categoria.getExaminationCategories(c).where((x) => x.itens.isNotEmpty).toList();
      List<String> find(String q) => SinSearch.searchCategories(cats, q).hits.map((h) => h.text.toLowerCase()).toList();

      // nenhum termo pode voltar vazio e todos devem trazer itens do tema
      expect(find('mentira'), isNotEmpty);
      expect(find('mentir'), isNotEmpty);
      expect(find('roubo'), isNotEmpty);
      expect(find('roubar'), isNotEmpty);
      expect(find('furto').toSet().intersection(find('roubar').toSet()), isNotEmpty);
      expect(find('missa'), isNotEmpty);
      expect(find('mísa'), isNotEmpty); // acento + erro de digitação
      expect(find('xilofone'), isEmpty);
      // todos os resultados de "mentira" realmente falam disso (ou sinônimos)
      for (final t in find('mentira')) {
        expect(RegExp(r'ment|enga|falso|falsi|fraud|calun|difam').hasMatch(FoldHelper.fold(t)), isTrue, reason: t);
      }
    });

    testWidgets('a chave do item é a usada pelo contador do exame', (tester) async {
      final c = await pumpContext(tester, 'pt');
      final cats = Categoria.getExaminationCategories(c).where((x) => x.itens.isNotEmpty).toList();
      final hit = SinSearch.searchCategories(cats, 'missa').hits.first;
      final original = hit.categoria.itens[hit.subcategoriaId]![hit.index];
      expect(original, hit.text);
      expect(hit.key, '${hit.categoria.id}-${hit.subcategoriaId}-${hit.index}');
    });
  });

  group('telas', () {
    Widget app(Widget home, String lang) => MaterialApp(
          locale: Locale(lang),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: home,
        );

    testWidgets('Orações: digitar mostra resultados e limpar volta às categorias', (tester) async {
      tester.view.physicalSize = const Size(800, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(app(const DevotionalHomePage(), 'pt'));
      await tester.pumpAndSettle();
      expect(find.text('CATEGORIAS'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'contriçao');
      await tester.pumpAndSettle();
      expect(find.text('Ato de Contrição'), findsWidgets);
      expect(find.text('CATEGORIAS'), findsNothing);

      await tester.enterText(find.byType(TextField), 'xilofone');
      await tester.pumpAndSettle();
      expect(find.textContaining('Nenhuma oração encontrada'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();
      expect(find.text('CATEGORIAS'), findsOneWidget);
    });

    testWidgets('Novenas: digitar filtra a lista', (tester) async {
      tester.view.physicalSize = const Size(800, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      final reminders = ReminderService(
        databaseService: DatabaseService(),
        notificationService: NotificationService(),
      );
      await tester.pumpWidget(ChangeNotifierProvider(
        create: (_) => PrayerProvider(reminderService: reminders),
        child: app(const NovenaHomePage(), 'pt'),
      ));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'apareceda');
      await tester.pumpAndSettle();
      expect(find.text('Novena a Nossa Senhora Aparecida'), findsOneWidget);
      expect(find.text('Novena a São José'), findsNothing);

      await tester.enterText(find.byType(TextField), 'qwertyuiop');
      await tester.pumpAndSettle();
      expect(find.textContaining('Nenhuma novena encontrada'), findsOneWidget);
    });
  });
}

class FoldHelper {
  static String fold(String s) => s
      .toLowerCase()
      .replaceAll(RegExp('[áàâãä]'), 'a')
      .replaceAll(RegExp('[éèêë]'), 'e')
      .replaceAll(RegExp('[íìîï]'), 'i')
      .replaceAll(RegExp('[óòôõö]'), 'o')
      .replaceAll(RegExp('[úùûü]'), 'u')
      .replaceAll('ç', 'c');
}
