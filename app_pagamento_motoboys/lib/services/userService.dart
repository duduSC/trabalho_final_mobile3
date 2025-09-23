import 'dart:convert';

import 'package:app_pagamento_motoboys/model/user.dart';
import 'package:http/http.dart' as http;
class UserService{
  static String _url = "https://68d1ccfde6c0cbeb39a5d531.mockapi.io/users";
  final Uri _uri = Uri.parse(_url);

  Future<List<User>> getUsers() async {
    final response = await http.get(_uri);
    if(response == 200){
      List<dynamic> data = jsonDecode(response.body);
      return data.map((user) {
        return User.fromJson(user);
      }).toList();
    }else{
      throw Exception("Falha ao buscar motoboys ${response.statusCode}");
    }
  }
  Future<User> createUser(User user) async {
    final response = await http.post(
        _uri,
        headers: {"Content-Type":"Application/json"},
        body: json.encode(user.toJson()));
    if(response.statusCode== 201 || response.statusCode== 200){
      return User.fromJson(json.decode(response.body));
    }else{
      throw Exception("Usuario nao foi criado: ${response.statusCode}");
    }
  }
}