import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sanctaconscientia/services/backup_crypto.dart';
import 'package:sanctaconscientia/services/password_hasher.dart';

void main() {
  group('PasswordHasher', () {
    test('hash correto verifica e senha errada falha', () async {
      final h = await PasswordHasher.hash('minha-senha');
      expect(PasswordHasher.isModernHash(h), isTrue);
      expect(await PasswordHasher.verify('minha-senha', h), isTrue);
      expect(await PasswordHasher.verify('outra', h), isFalse);
    });

    test('mesmo texto gera hashes diferentes (salt aleatório)', () async {
      final a = await PasswordHasher.hash('1234');
      final b = await PasswordHasher.hash('1234');
      expect(a, isNot(b));
    });

    test('formato inválido não verifica', () async {
      expect(await PasswordHasher.verify('x', 'lixo'), isFalse);
    });
  });

  group('BackupCrypto', () {
    test('ida e volta com a senha certa', () async {
      const original = '{"pecados":{"a":1},"nota":"áéí ção"}';
      final enc = await BackupCrypto.encrypt(original, 'segredo');
      final json = jsonDecode(enc) as Map<String, dynamic>;
      expect(BackupCrypto.isEncrypted(json), isTrue);
      expect(enc.contains('pecados'), isFalse);
      expect(await BackupCrypto.decrypt(json, 'segredo'), original);
    });

    test('senha errada lança exceção', () async {
      final enc = await BackupCrypto.encrypt('{"a":1}', 'certa');
      final json = jsonDecode(enc) as Map<String, dynamic>;
      expect(
        () => BackupCrypto.decrypt(json, 'errada'),
        throwsA(isA<BackupWrongPasswordException>()),
      );
    });

    test('arquivo adulterado é rejeitado', () async {
      final enc = await BackupCrypto.encrypt('{"a":1}', 'certa');
      final json = jsonDecode(enc) as Map<String, dynamic>;
      final bytes = base64Decode(json['cipher'] as String);
      bytes[0] ^= 0xFF;
      json['cipher'] = base64Encode(bytes);
      expect(
        () => BackupCrypto.decrypt(json, 'certa'),
        throwsA(isA<BackupWrongPasswordException>()),
      );
    });
  });
}
