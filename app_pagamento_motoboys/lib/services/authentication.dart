import 'package:app_pagamento_motoboys/model/user.dart';
import 'package:app_pagamento_motoboys/services/userService.dart';

// services/authentication.dart

class Authentication {
  static Future<User> authenticate(String user, String password) async {
    final List<User> usuarios = await UserService().getUsers();

    print('--- INICIANDO BUSCA PELO USUÁRIO: "$user" ---'); // Adicionado para clareza

    final usuario = usuarios.firstWhere(
      (x) {
        // --- LINHA DE DEBUG ---
        // Esta linha vai mostrar exatamente o que está sendo comparado.
        print("Comparando usuário da lista: [${x.nome}] com o usuário digitado: [${user}]");
        // --- FIM DO DEBUG ---
        return x.nome == user;
      },
      orElse: () => throw Exception("Usuário não encontrado."),
    );

    if (usuario.senha == password) {
      return usuario;
    } else {
      throw Exception('Senha inválida.');
    }
  }
}