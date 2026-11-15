import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'local_storage.dart';
import 'password_hasher.dart';

class AuthService {
  final LocalStorage _localStorage = LocalStorage();

  /// Hash SHA-256 simples, usado por versões antigas do app.
  /// Mantido apenas para reconhecer senhas já salvas (migração).
  String criarHash(String senha) {
    var bytes = utf8.encode(senha);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Define (ou troca) a senha, salvando-a com PBKDF2 + salt.
  Future<void> definirSenha(String senha) async {
    await _localStorage.savePassword(await PasswordHasher.hash(senha));
  }

  Future<bool> verificarSenha(String senha) async {
    final senhaSalva = await _localStorage.getPassword();
    if (senhaSalva == null || senhaSalva.isEmpty) return false;

    if (PasswordHasher.isModernHash(senhaSalva)) {
      return PasswordHasher.verify(senha, senhaSalva);
    }

    // Senha antiga (SHA-256 sem salt): confere e, se correta, migra.
    final legado = PasswordHasher.constantTimeEquals(
      utf8.encode(senhaSalva),
      utf8.encode(criarHash(senha)),
    );
    if (legado) await definirSenha(senha);
    return legado;
  }

  Future<bool> hasPassword() async {
    final senha = await _localStorage.getPassword();
    return senha != null && senha.isNotEmpty;
  }
}
