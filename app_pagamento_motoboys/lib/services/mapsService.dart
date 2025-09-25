import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class MapsService {
  static final String? _apiKey = dotenv.env['API_KEY'];

  Future<double> getDistance(String origin, String destination) async {
    if (_apiKey == null) {
      throw Exception("Chave de API do Google Maps não encontrada no .env");
    }

    // --- MUDANÇA PRINCIPAL AQUI ---
    // Em vez de construir a string da URL manualmente, usamos o construtor Uri.https
    // que formata e codifica os parâmetros por nós, de forma segura.
    final uri = Uri.https(
      'maps.googleapis.com', // Autoridade (o domínio principal)
      '/maps/api/directions/json', // O caminho para o recurso
      <String, String>{      // Os parâmetros da query
        'origin': origin,
        'destination': destination,
        'mode': 'driving',
        'units': 'metric',
        'key': _apiKey!,
      },
    );

    // Agora a chamada http usa o 'uri' que foi construído de forma segura
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      if ((jsonResponse['routes'] as List).isNotEmpty) {
        final route = jsonResponse['routes'][0];
        final leg = route['legs'][0];
        
        final distanceInMeters = leg['distance']['value'];
        final double distanceInKm = distanceInMeters / 1000.0;
        return distanceInKm;

      } else {
        // Se a resposta do Google não tem rotas, pode ser um endereço inválido
        final status = jsonResponse['status'];
        if (status == 'ZERO_RESULTS') {
          throw Exception('Não foi possível encontrar uma rota. Verifique os endereços.');
        }
        throw Exception('Erro ao obter rota: $status');
      }
    } else {
      final error = json.decode(response.body)['error_message'] ?? 'Erro desconhecido ao comunicar com a API.';
      throw Exception('Erro na API do Google Maps: $error');
    }
  }
}