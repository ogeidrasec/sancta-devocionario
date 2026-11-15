// Orações no padrão tradicional (Missal e manuais de devoção): garante que as
// formas corrigidas não voltem às versões modernas por engano.
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

Map<String, dynamic> _load(String path) => jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;

void main() {
  final pt = _load('lib/l10n/app_pt.arb');
  final en = _load('lib/l10n/app_en.arb');
  String p(String k) => pt[k] as String;
  String e(String k) => en[k] as String;

  group('português', () {
    test('Glória ao Pai (termina com "por todos os séculos dos séculos")', () {
      expect(p('prayerGloriaContent'),
          'Glória ao Pai, ao Filho e ao Espírito Santo. Como era no princípio, agora e sempre, por todos os séculos dos séculos. Amém.');
    });

    test('Oração de Fátima (forma tradicional)', () {
      const traditional =
          'Ó meu Jesus, perdoai-nos, livrai-nos do fogo do inferno, levai as almas todas para o Céu, principalmente as que mais precisarem.';
      expect(p('prayerFatimaContent'), traditional);
      expect(p('novenaFatimaClosing'), startsWith(traditional));
    });

    test('Sinal da Cruz com "e do"', () {
      expect(p('prayerSignCrossContent'), 'Em nome do Pai, e do Filho, e do Espírito Santo. Amém.');
    });

    test('Pai Nosso com "ofensas" (não "dívidas")', () {
      final t = p('prayerPaterNosterContent');
      expect(t, contains('perdoai-nos as nossas ofensas'));
      expect(t, contains('a quem nos tem ofendido'));
      expect(t, isNot(contains('dívidas')));
      expect(t, isNot(contains('devedores')));
    });

    test('Angelus: "escrava do Senhor" e oração "Infundi"', () {
      final t = p('prayerAngelusContent');
      expect(t, contains('escrava do Senhor'));
      expect(t, contains('Infundi, Senhor, a vossa graça'));
    });

    test('Regina Caeli: "gozos da vida eterna"', () {
      expect(p('prayerReginaCaeliContent'), contains('gozos da vida eterna'));
    });

    test('bênção da mesa: "dons" (e latim)', () {
      expect(p('prayerMealsContent'), contains('estes dons'));
      expect(p('prayerMealsContentLatin'), startsWith('Benedic, Domine'));
    });

    test('erros de digitação corrigidos', () {
      expect(p('prayerSalveContent'), isNot(contains('dodoçura')));
      expect(p('prayerSalveContent'), isNot(contains('(agradecer)')));
      expect(p('prayerNightContent'), isNot(contains('morrestre')));
      expect(p('prayerMorningContent'), isNot(contains('nessa noite')));
    });
  });

  group('inglês', () {
    test('Glory Be e Fátima na forma tradicional', () {
      expect(e('prayerGloriaContent'), contains('world without end'));
      expect(e('prayerFatimaContent'), contains('lead all souls to Heaven'));
      expect(e('prayerFatimaContent'), contains('those most in need of Thy mercy'));
    });
  });
}
