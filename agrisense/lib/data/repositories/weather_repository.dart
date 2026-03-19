import 'package:agrisense/data/models/weather_model.dart';

class WeatherRepository {
  Map<String, dynamic> _getLocationData(String location) {
    final locationLower = location.toLowerCase();

    if (locationLower.contains('western')) {
      return {
        'temperature': 28,
        'humidity': 72,
        'condition': 'Cloudy',
        'windSpeed': 15,
        'visibility': 8,
        'rainChance': 0.45,
        'rainPrediction': 'Today - 45% chance of rain',
        'temps': ['28°', '30°', '26°', '27°', '29°'],
        'rains': ['45%', '30%', '70%', '50%', '20%'],
        'conditions': ['cloud', 'cloud', 'rain', 'cloud', 'sunny'],
      };
    } else if (locationLower.contains('central')) {
      return {
        'temperature': 22,
        'humidity': 55,
        'condition': 'Sunny',
        'windSpeed': 8,
        'visibility': 10,
        'rainChance': 0.10,
        'rainPrediction': 'Today - 10% chance of rain',
        'temps': ['22°', '24°', '20°', '21°', '23°'],
        'rains': ['10%', '5%', '20%', '15%', '8%'],
        'conditions': ['sunny', 'sunny', 'cloud', 'sunny', 'sunny'],
      };
    } else if (locationLower.contains('eastern')) {
      return {
        'temperature': 32,
        'humidity': 78,
        'condition': 'Rainy',
        'windSpeed': 18,
        'visibility': 5,
        'rainChance': 0.80,
        'rainPrediction': 'Today - 80% chance of rain',
        'temps': ['32°', '31°', '28°', '30°', '32°'],
        'rains': ['80%', '75%', '85%', '70%', '60%'],
        'conditions': ['rain', 'rain', 'rain', 'cloud', 'cloud'],
      };
    } else if (locationLower.contains('northern')) {
      return {
        'temperature': 35,
        'humidity': 65,
        'condition': 'Hot & Sunny',
        'windSpeed': 12,
        'visibility': 9,
        'rainChance': 0.05,
        'rainPrediction': 'Today - 5% chance of rain',
        'temps': ['35°', '36°', '34°', '34°', '35°'],
        'rains': ['5%', '3%', '10%', '8%', '5%'],
        'conditions': ['sunny', 'sunny', 'cloud', 'sunny', 'sunny'],
      };
    } else if (locationLower.contains('southern')) {
      return {
        'temperature': 30,
        'humidity': 68,
        'condition': 'Partly Cloudy',
        'windSpeed': 16,
        'visibility': 8,
        'rainChance': 0.35,
        'rainPrediction': 'Today - 35% chance of rain',
        'temps': ['30°', '31°', '28°', '29°', '30°'],
        'rains': ['35%', '25%', '60%', '40%', '20%'],
        'conditions': ['cloud', 'cloud', 'rain', 'cloud', 'sunny'],
      };
    } else {
      return {
        'temperature': 25,
        'humidity': 60,
        'condition': 'Clear',
        'windSpeed': 10,
        'visibility': 10,
        'rainChance': 0.15,
        'rainPrediction': 'Today - 15% chance of rain',
        'temps': ['25°', '27°', '23°', '24°', '26°'],
        'rains': ['15%', '10%', '30%', '20%', '10%'],
        'conditions': ['sunny', 'sunny', 'cloud', 'sunny', 'sunny'],
      };
    }
  }

  Future<WeatherModel> getCurrentWeather(String location) async {
    final data = _getLocationData(location);
    await Future.delayed(const Duration(milliseconds: 300));

    return WeatherModel(
      city: location,
      temperature: (data['temperature'] as int).toDouble(),
      humidity: data['humidity'] as int,
      condition: data['condition'] as String,
      windSpeed: (data['windSpeed'] as int).toDouble(),
      visibility: (data['visibility'] as int).toDouble(),
    );
  }

  Future<RainPredictionModel> getRainPrediction(String location) async {
    final data = _getLocationData(location);
    await Future.delayed(const Duration(milliseconds: 300));

    return RainPredictionModel(
      title: "Rain Prediction",
      todayPrediction: data['rainPrediction'] as String,
      rainChance: data['rainChance'] as double,
      description: (data['rainChance'] as double) > 0.5
          ? "High rain probability - plan indoor activities"
          : "Low rain probability - good day for outdoor farming activities",
    );
  }

  Future<List<ForecastModel>> getForecast(String location) async {
    final data = _getLocationData(location);
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
    await Future.delayed(const Duration(milliseconds: 300));

    return List.generate(5, (i) {
      return ForecastModel(
        day: days[i],
        temp: (data['temps'] as List)[i] as String,
        rain: (data['rains'] as List)[i] as String,
        condition: (data['conditions'] as List)[i] as String,
      );
    });
  }

  Future<List<WeatherTrendModel>> getWeatherTrends(String location) async {
    final data = _getLocationData(location);
    final baseTemp = data['temperature'] as int;
    final baseHumidity = data['humidity'] as int;
    final baseRainfall = (((data['rainChance'] as double) * 100).toInt());

    await Future.delayed(const Duration(milliseconds: 300));

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
      WeatherTrendModel(
        day: "Sat",
        temperature: baseTemp,
        rainfall: baseRainfall - 5,
        humidity: baseHumidity - 8,
      ),
      WeatherTrendModel(
        day: "Sun",
        temperature: baseTemp + 1,
        rainfall: baseRainfall,
        humidity: baseHumidity - 2,
      ),
    ];
  }

  Future<List<WeatherAlertModel>> getWeatherAlerts(String location) async {
    final data = _getLocationData(location);
    final rainChance = data['rainChance'] as double;
    final humidity = data['humidity'] as int;

    await Future.delayed(const Duration(milliseconds: 300));

    final alerts = <WeatherAlertModel>[];

    if (rainChance > 0.6) {
      alerts.add(
        WeatherAlertModel(
          title: "Heavy Rain Alert",
          message:
              "High chance of rain (${rainChance * 100}%) - Postpone outdoor farming activities."
                  .replaceAll('.0', ''),
          type: "warning",
        ),
      );
    } else if (rainChance < 0.2) {
      alerts.add(
        WeatherAlertModel(
          title: "Good Farming Day",
          message:
              "Low rain probability (${rainChance * 100}%) - Excellent for outdoor activities."
                  .replaceAll('.0', ''),
          type: "clear",
        ),
      );
    } else {
      alerts.add(
        WeatherAlertModel(
          title: "Moderate Conditions",
          message:
              "Rain probability at ${(rainChance * 100).toStringAsFixed(0)}% - Plan activities accordingly.",
          type: "clear",
        ),
      );
    }

    if (humidity > 70) {
      alerts.add(
        WeatherAlertModel(
          title: "High Humidity Notice",
          message:
              "Humidity at $humidity% - Monitor crops for fungal diseases. Ensure proper ventilation.",
          type: "humidity",
        ),
      );
    }

    return alerts;
  }

  Future<RecommendedActivitiesModel> getRecommendedActivities(
    String location,
  ) async {
    final data = _getLocationData(location);
    final rainChance = data['rainChance'] as double;

    await Future.delayed(const Duration(milliseconds: 300));

    return RecommendedActivitiesModel(
      bestActivities: rainChance < 0.3
          ? [
              "Planting & transplanting seedlings",
              "Field preparation and plowing",
              "Pesticide and fungicide application",
            ]
          : [
              "Indoor crop monitoring",
              "Equipment maintenance",
              "Seed preparation and sorting",
            ],
      avoidActivities: rainChance > 0.4
          ? [
              "Delay harvesting - heavy rain expected",
              "Avoid fertilizer application",
              "Postpone spraying activities",
            ]
          : ["Heavy watering - insufficient rain"],
    );
  }

  Future<IrrigationAdviceModel> getIrrigationAdvice(String location) async {
    final data = _getLocationData(location);
    final rainChance = data['rainChance'] as double;
    final humidity = data['humidity'] as int;

    await Future.delayed(const Duration(milliseconds: 300));

    final irrigationLevel = rainChance > 0.6
        ? "Minimal"
        : rainChance > 0.3
        ? "Moderate"
        : "High";

    return IrrigationAdviceModel(
      title: "$irrigationLevel Irrigation\nNeeded",
      subtitle:
          "Based on ${(rainChance * 100).toStringAsFixed(0)}% rain chance and\n$humidity% humidity",
      basedOn:
          "${(rainChance * 100).toStringAsFixed(0)}% rain chance and $humidity% humidity",
      tips: rainChance > 0.5
          ? [
              "Reduce irrigation - rain expected",
              "Monitor soil moisture carefully",
              "Skip irrigation for next 2-3 days",
            ]
          : [
              "Morning irrigation recommended (6-8 AM)",
              "Water deeply for soil saturation",
              "Check irrigation system for leaks",
            ],
    );
  }
}
