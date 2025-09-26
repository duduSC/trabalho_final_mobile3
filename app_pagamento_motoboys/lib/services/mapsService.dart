// lib/services/mapsService.dart

import 'dart:convert';
import 'dart:math'; // Usado para gerar um número aleatório
import 'package:flutter/foundation.dart'; // Para o print de depuração
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class MapsService {
  static final String? _apiKey = dotenv.env['API_KEY'];

  // --- MODO DE DEPURACÃO ---
  // Mude para 'true' para saltar a chamada à API e usar um valor falso.
  // Mude para 'false' para tentar a chamada real à API do Google.
  final bool _debugMode = false;

  Future<double> getDistance(String origin, String destination) async {
    // --- LÓGICA DE DEPURACÃO ---
    if (_debugMode) {
      debugPrint("--- MODO DE DEPURACAO ATIVO ---");
      // Simula um atraso de 2 segundos, como se fosse uma chamada de rede real
      await Future.delayed(const Duration(seconds: 2));
      // Retorna um valor de distância aleatório entre 2 e 20 km.
      final double fakeDistance = Random().nextDouble() * 18 + 2;
      debugPrint("--- Distancia Falsa Gerada: ${fakeDistance.toStringAsFixed(2)} km ---");
      return fakeDistance;
    }

    // --- CÓDIGO DE PRODUÇÃO (CHAMADA REAL) ---
    if (_apiKey == null) {
      throw Exception("Chave de API do Google Maps não encontrada no .env");
    }

    final uri = Uri.https(
      'maps.googleapis.com',
      '/maps/api/directions/json',
      <String, String>{
        'origin': origin.trim(),
        'destination': destination.trim(),
        'mode': 'driving',
        'units': 'metric',
        'key': _apiKey!,
      },
    );
    
    // Imprime a URL exata que está a ser chamada no console de depuração
    debugPrint("--- URL da API Chamada: ${uri.toString()} ---");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      if ((jsonResponse['routes'] as List).isNotEmpty) {
        final route = jsonResponse['routes'][0];
        final leg = route['legs'][0];
        final distanceInMeters = leg['distance']['value'];
        return distanceInMeters / 1000.0;
      } else {
        final status = jsonResponse['status'];
        if (status == 'ZERO_RESULTS') {
          throw Exception('Não foi possível encontrar uma rota. Verifique os endereços.');
        }
        throw Exception('Erro ao obter rota: $status. Verifique se a API Directions está ativa no Google Console.');
      }
    } else {
      final error = json.decode(response.body)['error_message'] ?? 'Erro desconhecido na API.';
      throw Exception('Erro na API do Google Maps: $error');
    }
  }
}