import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:agrisense/data/models/weather_model.dart';

class WeatherRepository {
  final String apiKey = "00987b3eb10e67bc4d51f1227428b027"; // 🔐 put your key

  // ✅ NEW: Real API call
  Future<Map<String, dynamic>> _getLocationData(String location) async {
    final queryCandidates = _buildQueryCandidates(location);

    for (final query in queryCandidates) {
      final url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$query&units=metric&appid=$apiKey",
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        return {
          'city': jsonData['name'],
          'temperature': jsonData['main']['temp'],
          'humidity': jsonData['main']['humidity'],
          'condition': jsonData['weather'][0]['main'],
          'windSpeed': (jsonData['wind']['speed'] ?? 0) * 3.6,
          'visibility': (jsonData['visibility'] ?? 10000) / 1000,

          // 👇 calculated values (IMPORTANT - keeps your features working)
          'rainChance': _calculateRainChance(jsonData),
          'rainPrediction':
              "Today - ${(_calculateRainChance(jsonData) * 100).toInt()}% chance of rain",

          // 👇 fake forecast (keep your UI working)
          'temps': ['28°', '30°', '26°', '27°', '29°'],
          'rains': ['45%', '30%', '70%', '50%', '20%'],
          'conditions': ['cloud', 'cloud', 'rain', 'cloud', 'sunny'],
        };
      }
    }

    throw Exception("Failed to load weather");
  }

  List<String> _buildQueryCandidates(String location) {
    final normalized = location.trim();
    final city = normalized.split(',').first.trim();

    final candidates = <String>[
      Uri.encodeComponent('$city,LK'),
      Uri.encodeComponent(normalized),
      Uri.encodeComponent(city),
    ];

    return candidates.toSet().toList();
  }

  // ✅ NEW: simple rain logic
  double _calculateRainChance(Map<String, dynamic> json) {
    final condition = json['weather'][0]['main'].toString().toLowerCase();

    if (condition.contains("rain")) return 0.8;
    if (condition.contains("cloud")) return 0.4;
    return 0.1;
  }

  // ✅ UPDATED (ONLY small change)
  Future<WeatherModel> getCurrentWeather(String location) async {
    final data = await _getLocationData(location);

    return WeatherModel(
      city: (data['city'] ?? location).toString(),
      temperature: (data['temperature']).toDouble(),
      humidity: data['humidity'],
      condition: data['condition'],
      windSpeed: (data['windSpeed']).toDouble(),
      visibility: (data['visibility']).toDouble(),
    );
  }

  // ❌ DO NOT CHANGE BELOW (your existing logic remains SAME)

  Future<RainPredictionModel> getRainPrediction(String location) async {
    final data = await _getLocationData(location);

    return RainPredictionModel(
      title: "Rain Prediction",
      todayPrediction: data['rainPrediction'],
      rainChance: data['rainChance'],
      description: (data['rainChance']) > 0.5
          ? "High rain probability - plan indoor activities"
          : "Low rain probability - good day for outdoor farming activities",
    );
  }

  Future<List<ForecastModel>> getForecast(String location) async {
    final data = await _getLocationData(location);
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

    return List.generate(5, (i) {
      return ForecastModel(
        day: days[i],
        temp: data['temps'][i],
        rain: data['rains'][i],
        condition: data['conditions'][i],
      );
    });
  }

  Future<List<WeatherTrendModel>> getWeatherTrends(String location) async {
    final data = await _getLocationData(location);

    final baseTemp = data['temperature'].toInt();
    final baseHumidity = data['humidity'];
    final baseRainfall = ((data['rainChance']) * 100).toInt();

    return [
      WeatherTrendModel(
        day: "Mon",
        temperature: baseTemp,
        rainfall: baseRainfall,
        humidity: baseHumidity,
      ),
      WeatherTrendModel(
        day: "Tue",
        temperature: baseTemp + 2,
        rainfall: baseRainfall - 10,
        humidity: baseHumidity - 5,
      ),
      WeatherTrendModel(
        day: "Wed",
        temperature: baseTemp - 3,
        rainfall: baseRainfall + 15,
        humidity: baseHumidity + 8,
      ),
      WeatherTrendModel(
        day: "Thu",
        temperature: baseTemp - 1,
        rainfall: baseRainfall + 5,
        humidity: baseHumidity + 3,
      ),
      WeatherTrendModel(
        day: "Fri",
        temperature: baseTemp + 1,
        rainfall: baseRainfall - 15,
        humidity: baseHumidity - 3,
      ),
    ];
  }

  Future<List<WeatherAlertModel>> getWeatherAlerts(String location) async {
    final data = await _getLocationData(location);

    final rainChance = data['rainChance'];
    final humidity = data['humidity'];

    final alerts = <WeatherAlertModel>[];

    if (rainChance > 0.6) {
      alerts.add(
        WeatherAlertModel(
          title: "Heavy Rain Alert",
          message:
              "High chance of rain (${(rainChance * 100).toInt()}%) - Postpone outdoor farming activities.",
          type: "warning",
        ),
      );
    }

    if (humidity > 70) {
      alerts.add(
        WeatherAlertModel(
          title: "High Humidity Notice",
          message:
              "Humidity at $humidity% - Monitor crops for fungal diseases.",
          type: "humidity",
        ),
      );
    }

    return alerts;
  }

  Future<RecommendedActivitiesModel> getRecommendedActivities(
    String location,
  ) async {
    final data = await _getLocationData(location);

    final rainChance = data['rainChance'];

    return RecommendedActivitiesModel(
      bestActivities: rainChance < 0.3
          ? ["Planting & transplanting seedlings", "Field preparation"]
          : ["Indoor crop monitoring", "Equipment maintenance"],
      avoidActivities: rainChance > 0.4
          ? ["Delay harvesting", "Avoid fertilizer application"]
          : ["Heavy watering"],
    );
  }

  Future<IrrigationAdviceModel> getIrrigationAdvice(String location) async {
    final data = await _getLocationData(location);

    final rainChance = data['rainChance'];
    final humidity = data['humidity'];

    final irrigationLevel = rainChance > 0.6
        ? "Minimal"
        : rainChance > 0.3
        ? "Moderate"
        : "High";

    return IrrigationAdviceModel(
      title: "$irrigationLevel Irrigation Needed",
      subtitle:
          "Based on ${(rainChance * 100).toInt()}% rain & $humidity% humidity",
      basedOn:
          "${(rainChance * 100).toInt()}% rain chance and $humidity% humidity",
      tips: rainChance > 0.5
          ? ["Reduce irrigation", "Skip irrigation for 2-3 days"]
          : ["Morning irrigation recommended", "Check irrigation system"],
    );
  }
}
