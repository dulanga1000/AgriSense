class WeatherModel {
  final String city;
  final double temperature;
  final int humidity;
  final String condition;

  WeatherModel({
    required this.city,
    required this.temperature,
    required this.humidity,
    required this.condition,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['name'] ?? "",
      temperature: (json['main']['temp'] ?? 0).toDouble(),
      humidity: (json['main']['humidity'] ?? 0).toInt(),
      condition: json['weather'][0]['main'] ?? "",
    );
  }
}

class RainPredictionModel {
  final String title;
  final String todayPrediction;
  final double rainChance;
  final String description;

  RainPredictionModel({
    required this.title,
    required this.todayPrediction,
    required this.rainChance,
    required this.description,
  });

  factory RainPredictionModel.fromWeather(WeatherModel weather) {
    double rainChance = 0.1;
    String description =
        "Low rain probability - good day for outdoor farming activities";

    if (weather.condition.toLowerCase().contains("rain")) {
      rainChance = 0.8;
      description =
          "High chance of rain - consider delaying outdoor farming tasks";
    } else if (weather.condition.toLowerCase().contains("cloud")) {
      rainChance = 0.4;
      description = "Moderate chance of rain - keep an eye on weather updates";
    }

    return RainPredictionModel(
      title: "Rain Prediction",
      todayPrediction: "Today - ${(rainChance * 100).toInt()}% chance of rain",
      rainChance: rainChance,
      description: description,
    );
  }
}

class ForecastModel {
  final String day;
  final String temp;
  final String rain;
  final String condition;

  ForecastModel({
    required this.day,
    required this.temp,
    required this.rain,
    required this.condition,
  });
}

class RecommendedActivitiesModel {
  final List<String> bestActivities;
  final List<String> avoidActivities;

  RecommendedActivitiesModel({
    required this.bestActivities,
    required this.avoidActivities,
  });
}
