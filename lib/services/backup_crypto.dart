import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:sanctaconscientia/services/password_hasher.dart';

/// Senha incorreta (ou arquivo adulterado) ao abrir um backup protegido.
class BackupWrongPasswordException implements Exception {
  @override
  String toString() => 'BackupWrongPasswordException';
}

/// Criptografia de backup: AES-256-GCM com chave derivada da senha (PBKDF2).
class BackupCrypto {
  static const String formatId = 'sancta-backup-enc';
  static const int version = 1;
  static const int iterations = 150000;

  /// Indica se o conteúdo é um backup protegido por senha.
  static bool isEncrypted(Map<String, dynamic> json) =>
      json['format'] == formatId;

  static Future<String> encrypt(String plainJson, String password) async {
    final salt = PasswordHasher.randomBytes(16);
    final keyBytes =
        await PasswordHasher.derive(password, salt, iterations: iterations);
    final algorithm = AesGcm.with256bits();
    final nonce = algorithm.newNonce();
    final box = await algorithm.encrypt(
      utf8.encode(plainJson),
      secretKey: SecretKey(keyBytes),
      nonce: nonce,
    );
    return jsonEncode({
      'format': formatId,
      'v': version,
      'iterations': iterations,
      'salt': base64Encode(salt),
      'nonce': base64Encode(nonce),
      'cipher': base64Encode(box.cipherText),
      'mac': base64Encode(box.mac.bytes),
    });
  }

  /// Devolve o JSON original. Lança [BackupWrongPasswordException] se a senha
  /// estiver errada ou o arquivo tiver sido alterado.
  static Future<String> decrypt(
      Map<String, dynamic> json, String password) async {
    final salt = base64Decode(json['salt'] as String);
    final iters = json['iterations'] as int;
    final keyBytes = await PasswordHasher.derive(password, salt, iterations: iters);
    final box = SecretBox(
      base64Decode(json['cipher'] as String),
      nonce: base64Decode(json['nonce'] as String),
      mac: Mac(base64Decode(json['mac'] as String)),
    );
    try {
      final clear =
          await AesGcm.with256bits().decrypt(box, secretKey: SecretKey(keyBytes));
      return utf8.decode(clear);
    } on SecretBoxAuthenticationError {
      throw BackupWrongPasswordException();
    }
  }
}
