import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/farming_tip_model.dart';

class FarmingTipRepository {
  FarmingTipRepository({http.Client? client, String? apiKey})
    : _client = client ?? http.Client(),
      _apiKey = (apiKey ?? dotenv.env['OPENWEATHER_API_KEY'] ?? '').trim();

  final http.Client _client;
  final String _apiKey;

  Future<List<FarmingTip>> getTips(String selectedLocation) async {
    if (_apiKey.isEmpty) {
      throw Exception('OPENWEATHER_API_KEY is not set in .env');
    }

    final locationCandidates = _buildLocationCandidates(selectedLocation);
    http.Response? response;

    for (final location in locationCandidates) {
      final url = Uri.https(
        'api.openweathermap.org',
        '/data/2.5/weather',
        <String, String>{'q': location, 'appid': _apiKey, 'units': 'metric'},
      );

      final candidateResponse = await _client.get(url);
      if (candidateResponse.statusCode == 200) {
        response = candidateResponse;
        break;
      }
    }

    if (response == null) {
      throw Exception(
        'OpenWeatherMap request failed for location: $selectedLocation',
      );
    }

    final data = jsonDecode(response.body);

    final temp = data['main']['temp'];
    final humidity = data['main']['humidity'];
    final weather = data['weather'][0]['main'];

    // 🌱 Always return 4 categories
    return [
      FarmingTip(
        id: 1,
        type: "sun",
        description: temp > 30
            ? "High temperature detected. Water crops early morning."
            : "Temperature is moderate. Maintain regular watering schedule.",
      ),
      FarmingTip(
        id: 2,
        type: "plant",
        description: humidity < 40
            ? "Low humidity. Improve soil moisture using compost."
            : "Soil conditions are stable. Continue using organic fertilizers.",
      ),
      FarmingTip(
        id: 3,
        type: "rain",
        description: weather.toLowerCase().contains("rain")
            ? "Rain expected. Avoid irrigation today."
            : "No rain expected. Plan irrigation accordingly.",
      ),
      FarmingTip(
        id: 4,
        type: "warning",
        description: humidity > 70
            ? "High humidity. Risk of pests and fungal diseases."
            : "Low pest risk. Continue regular monitoring.",
      ),
    ];
  }

  List<String> _buildLocationCandidates(String selectedLocation) {
    final normalized = selectedLocation.trim();
    if (normalized.isEmpty) {
      return const ['Colombo'];
    }

    final cityOnly = normalized.split(',').first.trim();
    final candidates = <String>{normalized, cityOnly};

    return candidates.toList();
  }
}
