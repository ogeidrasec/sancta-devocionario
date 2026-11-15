import 'dart:convert';
import 'dart:isolate';
import 'dart:math';

import 'package:cryptography/cryptography.dart';

/// Deriva chaves/hashes de senha com PBKDF2-HMAC-SHA256 + salt aleatório.
/// O cálculo roda em outro isolate para não travar a interface.
class PasswordHasher {
  static const int defaultIterations = 100000;
  static const String _prefix = 'pbkdf2';

  static List<int> randomBytes(int length) {
    final rng = Random.secure();
    return List<int>.generate(length, (_) => rng.nextInt(256));
  }

  /// Deriva [bits] bits a partir da senha e do salt.
  static Future<List<int>> derive(
    String password,
    List<int> salt, {
    int iterations = defaultIterations,
    int bits = 256,
  }) {
    return Isolate.run(() async {
      final pbkdf2 = Pbkdf2(
        macAlgorithm: Hmac.sha256(),
        iterations: iterations,
        bits: bits,
      );
      final key = await pbkdf2.deriveKeyFromPassword(
        password: password,
        nonce: salt,
      );
      return key.extractBytes();
    });
  }

  /// Formato: pbkdf2$<iterações>$<salt b64>$<hash b64>
  static Future<String> hash(String password) async {
    final salt = randomBytes(16);
    final bytes = await derive(password, salt);
    return '$_prefix\$$defaultIterations\$${base64Encode(salt)}\$${base64Encode(bytes)}';
  }

  static bool isModernHash(String stored) => stored.startsWith('$_prefix\$');

  static Future<bool> verify(String password, String stored) async {
    final parts = stored.split('\$');
    if (parts.length != 4 || parts[0] != _prefix) return false;
    final iterations = int.tryParse(parts[1]);
    if (iterations == null || iterations <= 0) return false;
    final salt = base64Decode(parts[2]);
    final expected = base64Decode(parts[3]);
    final actual = await derive(password, salt, iterations: iterations);
    return constantTimeEquals(actual, expected);
  }

  static bool constantTimeEquals(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    var diff = 0;
    for (var i = 0; i < a.length; i++) {
      diff |= a[i] ^ b[i];
    }
    return diff == 0;
  }
}
