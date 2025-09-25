import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class MapsService {
  static final String? _apiKey = dotenv.env['API_KEY'];

  Future<double> getDistance(String origin, String destination) async {


    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&mode=driving&key=$_apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      if ((jsonResponse['routes'] as List).isNotEmpty) {
        final route = jsonResponse['routes'][0];
        final leg = route['legs'][0];
        final distance = leg['distance']['value']/ 1000.0; 

        return distance;
      } else {
        throw Exception('Nenhuma rota encontrada. Verifique os endereços.');
      }
    } else {
      final error = json.decode(response.body)['error_message'] ?? 'Erro desconhecido';
      throw Exception('Erro na API do Google Maps: $error');
    }
  }
}