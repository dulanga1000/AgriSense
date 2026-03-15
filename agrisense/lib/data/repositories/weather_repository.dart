import 'package:agrisense/data/models/weather_model.dart';

class WeatherRepository {
  Future<WeatherModel> getCurrentWeather(String location) async {
    return const WeatherModel(
      city: "Western Province, Sri Lanka",
      temperature: 28,
      humidity: 65,
      condition: "Cloudy",
      windSpeed: 12,
      visibility: 8,
    );
  }

  Future<RainPredictionModel> getRainPrediction(String location) async {
    return const RainPredictionModel(
      title: "Rain Prediction",
      todayPrediction: "Today - 20% chance of rain",
      rainChance: 0.2,
      description:
          "Low rain probability - good day for outdoor farming activities",
    );
  }

  Future<List<ForecastModel>> getForecast(String location) async {
    return const [
      ForecastModel(day: "Mon", temp: "28°", rain: "20%", condition: "cloud"),
      ForecastModel(day: "Tue", temp: "30°", rain: "5%", condition: "sunny"),
      ForecastModel(day: "Wed", temp: "26°", rain: "80%", condition: "rain"),
      ForecastModel(day: "Thu", temp: "27°", rain: "30%", condition: "cloud"),
      ForecastModel(day: "Fri", temp: "29°", rain: "10%", condition: "sunny"),
    ];
  }

  Future<List<WeatherTrendModel>> getWeatherTrends(String location) async {
    return const [
      WeatherTrendModel(
        day: "Mon",
        temperature: 28,
        rainfall: 20,
        humidity: 65,
      ),
      WeatherTrendModel(day: "Tue", temperature: 30, rainfall: 5, humidity: 60),
      WeatherTrendModel(
        day: "Wed",
        temperature: 26,
        rainfall: 75,
        humidity: 80,
      ),
      WeatherTrendModel(
        day: "Thu",
        temperature: 27,
        rainfall: 30,
        humidity: 70,
      ),
      WeatherTrendModel(
        day: "Fri",
        temperature: 29,
        rainfall: 10,
        humidity: 60,
      ),
      WeatherTrendModel(
        day: "Sat",
        temperature: 28,
        rainfall: 18,
        humidity: 55,
      ),
      WeatherTrendModel(
        day: "Sun",
        temperature: 27,
        rainfall: 25,
        humidity: 62,
      ),
    ];
  }

  Future<List<WeatherAlertModel>> getWeatherAlerts(String location) async {
    return const [
      WeatherAlertModel(
        title: "All Clear",
        message:
            "No weather warnings for Western Province today. Safe for all farming activities.",
        type: "clear",
      ),
      WeatherAlertModel(
        title: "Humidity Notice",
        message:
            "High humidity (65%) - Monitor crops for fungal diseases. Ensure proper ventilation.",
        type: "humidity",
      ),
    ];
  }

  Future<RecommendedActivitiesModel> getRecommendedActivities(
    String location,
  ) async {
    return const RecommendedActivitiesModel(
      bestActivities: [
        "Planting & transplanting seedlings",
        "Field preparation and plowing",
        "Irrigation system maintenance",
      ],
      avoidActivities: [
        "Postpone fertilizer application (80% rain Wed)",
        "Delay fungicide spraying due to humidity",
      ],
    );
  }

  Future<IrrigationAdviceModel> getIrrigationAdvice(String location) async {
    return const IrrigationAdviceModel(
      title: "Moderate Irrigation\nNeeded",
      subtitle: "Based on 20% rain chance and\n65% humidity",
      basedOn: "20% rain chance and 65% humidity",
      tips: [
        "Morning irrigation recommended (6-8 AM)",
        "Reduce water by 30% due to high humidity",
        "Skip Wed irrigation - heavy rain expected",
      ],
    );
  }
}
