import 'dart:convert';

import 'package:app_pagamento_motoboys/model/motoboy.dart';
import 'package:http/http.dart' as http;

class MotoboyService {
  static String _url = "https://68d1ccfde6c0cbeb39a5d531.mockapi.io/motoboys";
  final Uri _uri = Uri.parse(_url);

  Future<List<Motoboy>> getMotoboys() async {
    final response = await http.get(_uri);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((user) {
        return Motoboy.fromJson(user);
      }).toList();
    } else {
      throw Exception("Falha ao buscar motoboys ${response.statusCode}");
    }
  }

  Future<Motoboy> getMotoboy(String id) async {
    final response = await http.get(Uri.parse("$_uri/$id"));
    if (response.statusCode == 200) {
      return Motoboy.fromJson(json.decode(response.body));
    } else {
      throw Exception("Falha ao buscar motoboy ${response.statusCode}");
    }
  }

  Future<Motoboy> createMotoboy(Motoboy motoboy) async {
    final response = await http.post(
        _uri,
        headers: {"Content-Type": "Application/json"},
        body: json.encode(motoboy.toJson()));
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Motoboy.fromJson(json.decode(response.body));
    } else {
      throw Exception("Usuario nao foi criado: ${response.statusCode}");
    }
  }

  Future<Motoboy> updateMotoboy(Motoboy motoboy) async {
    final response = await http.put(Uri.parse("$_uri/${motoboy.id}"), headers:
    {"Content-Type": "application/json"},
        body: json.encode(motoboy.toJsonEdit()));
    if (response.statusCode == 200) {
      return Motoboy.fromJson(json.decode(response.body));
    } else {
      throw Exception("Erro ao atualizar ${response.statusCode}");
    }
  }

  Future<void> deleteMotoboy(String id) async {
    final response = await http.delete(Uri.parse("$_uri/$id"));
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Falha ao remover usuário (${response.statusCode})');
    }
  }
}