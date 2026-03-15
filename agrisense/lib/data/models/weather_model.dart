class WeatherModel {
  final String city;
  final double temperature;
  final int humidity;
  final String condition;
  final double windSpeed;
  final double visibility;

  const WeatherModel({
    required this.city,
    required this.temperature,
    required this.humidity,
    required this.condition,
    required this.windSpeed,
    required this.visibility,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['name'] ?? "",
      temperature: (json['main']['temp'] ?? 0).toDouble(),
      humidity: (json['main']['humidity'] ?? 0).toInt(),
      condition: json['weather'][0]['main'] ?? "",
      windSpeed: (json['wind']['speed'] ?? 0).toDouble(),
      visibility: (json['visibility'] ?? 0).toDouble() / 1000,
    );
  }
}

class RainPredictionModel {
  final String title;
  final String todayPrediction;
  final double rainChance;
  final String description;

  const RainPredictionModel({
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

  const ForecastModel({
    required this.day,
    required this.temp,
    required this.rain,
    required this.condition,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      day: json['day'],
      temp: json['temp'],
      rain: json['rain'],
      condition: json['condition'],
    );
  }
}

class WeatherTrendModel {
  final String day;
  final int temperature;
  final int rainfall;
  final int humidity;

  const WeatherTrendModel({
    required this.day,
    required this.temperature,
    required this.rainfall,
    required this.humidity,
  });

  factory WeatherTrendModel.fromJson(Map<String, dynamic> json) {
    return WeatherTrendModel(
      day: json['day'],
      temperature: json['temperature'],
      rainfall: json['rainfall'],
      humidity: json['humidity'],
    );
  }
}

class WeatherAlertModel {
  final String title;
  final String message;
  final String type; // "clear", "humidity", "rain", "wind"

  const WeatherAlertModel({
    required this.title,
    required this.message,
    required this.type,
  });

  factory WeatherAlertModel.fromJson(Map<String, dynamic> json) {
    return WeatherAlertModel(
      title: json['title'],
      message: json['message'],
      type: json['type'],
    );
  }
}

class RecommendedActivitiesModel {
  final List<String> bestActivities;
  final List<String> avoidActivities;

  const RecommendedActivitiesModel({
    required this.bestActivities,
    required this.avoidActivities,
  });

  factory RecommendedActivitiesModel.fromJson(Map<String, dynamic> json) {
    return RecommendedActivitiesModel(
      bestActivities: List<String>.from(json['best_activities']),
      avoidActivities: List<String>.from(json['avoid_activities']),
    );
  }
}

class IrrigationAdviceModel {
  final String title;
  final String subtitle;
  final String basedOn;
  final List<String> tips;

  const IrrigationAdviceModel({
    required this.title,
    required this.subtitle,
    required this.basedOn,
    required this.tips,
  });

  factory IrrigationAdviceModel.fromJson(Map<String, dynamic> json) {
    return IrrigationAdviceModel(
      title: json['title'],
      subtitle: json['subtitle'],
      basedOn: json['based_on'],
      tips: List<String>.from(json['tips']),
    );
  }
}
