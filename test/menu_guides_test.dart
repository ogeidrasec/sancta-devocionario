// Guias (Missa, Adoração, Intenções) ficam na aba Orações; o menu lateral só
// tem "Sobre o projeto", "Guia do app" e "Configurações".
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sanctaconscientia/l10n/app_localizations.dart';
import 'package:sanctaconscientia/pages/devotional_home_page.dart';
import 'package:sanctaconscientia/widgets/app_drawer.dart';

Widget _app(Widget home) => MaterialApp(
      locale: const Locale('pt'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: home,
    );

void main() {
  testWidgets('aba Orações mostra a seção de guias', (tester) async {
    tester.view.physicalSize = const Size(800, 3000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(_app(const DevotionalHomePage()));
    await tester.pumpAndSettle();

    expect(find.text('GUIAS E DEVOÇÕES'), findsOneWidget);
    expect(find.byKey(const ValueKey('guide_mass')), findsOneWidget);
    expect(find.byKey(const ValueKey('guide_adoration')), findsOneWidget);
    expect(find.byKey(const ValueKey('guide_intentions')), findsOneWidget);
    expect(find.text('Guia da Missa'), findsOneWidget);
  });

  testWidgets('menu lateral tem Sobre o Projeto, Guia do app e Configurações', (tester) async {
    await tester.pumpWidget(_app(const Scaffold(drawer: AppDrawer(), body: SizedBox())));
    final state = tester.state<ScaffoldState>(find.byType(Scaffold));
    state.openDrawer();
    await tester.pumpAndSettle();

    expect(find.text('Sobre o Projeto'), findsOneWidget);
    expect(find.text('Configurações'), findsOneWidget);
    expect(find.text('Guia da Missa'), findsNothing);
    expect(find.text('Adoração Eucarística'), findsNothing);
    expect(find.text('Intenções de oração'), findsNothing);
    expect(find.text('Guia do app'), findsOneWidget);
    expect(find.text('Minha Evolução'), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(4));
  });
}
