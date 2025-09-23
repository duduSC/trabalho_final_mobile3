import 'package:app_pagamento_motoboys/model/user.dart';
import 'package:app_pagamento_motoboys/services/userService.dart';

class Authentication {
  static final Future<List<User>> _users = UserService().getUsers();

  static Future<bool> authenticate(String user, String password) async {
    final List<User> usuarios = await _users;
    final auth = usuarios.any((usuario) {
      return usuario.usuario == user && usuario.senha == password;
    });
    return auth;
  }
}
