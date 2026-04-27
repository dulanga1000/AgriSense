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
      city: json['name']?.toString() ?? "",
      temperature:
          num.tryParse(json['main']['temp'].toString())?.toDouble() ?? 0.0,
      humidity: num.tryParse(json['main']['humidity'].toString())?.toInt() ?? 0,
      condition: json['weather'][0]['main']?.toString() ?? "",
      windSpeed:
          num.tryParse(json['wind']['speed'].toString())?.toDouble() ?? 0.0,
      visibility:
          (num.tryParse(json['visibility'].toString())?.toDouble() ?? 0.0) /
          1000,
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

  // ✅ Ultra-safe AI Parsing
  factory RainPredictionModel.fromJson(Map<String, dynamic> json) {
    return RainPredictionModel(
      title: json['title']?.toString() ?? "Rain Prediction",
      todayPrediction: json['todayPrediction']?.toString() ?? "",
      rainChance:
          num.tryParse(json['rainChance'].toString())?.toDouble() ?? 0.0,
      description: json['description']?.toString() ?? "",
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
      day: json['day']?.toString() ?? "N/A",
      temp: json['temp']?.toString() ?? "0°",
      rain: json['rain']?.toString() ?? "0%",
      condition: json['condition']?.toString() ?? "Clear",
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

  // ✅ Ultra-safe AI Parsing (handles ints, doubles, and strings safely)
  factory WeatherTrendModel.fromJson(Map<String, dynamic> json) {
    return WeatherTrendModel(
      day: json['day']?.toString() ?? "N/A",
      temperature: num.tryParse(json['temperature'].toString())?.toInt() ?? 0,
      rainfall: num.tryParse(json['rainfall'].toString())?.toInt() ?? 0,
      humidity: num.tryParse(json['humidity'].toString())?.toInt() ?? 0,
    );
  }
}

class WeatherAlertModel {
  final String title;
  final String message;
  final String type;

  const WeatherAlertModel({
    required this.title,
    required this.message,
    required this.type,
  });

  // ✅ Ultra-safe AI Parsing
  factory WeatherAlertModel.fromJson(Map<String, dynamic> json) {
    return WeatherAlertModel(
      title: json['title']?.toString() ?? "Notice",
      message: json['message']?.toString() ?? "",
      type: json['type']?.toString() ?? "clear",
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

  // ✅ Ultra-safe AI Parsing
  factory RecommendedActivitiesModel.fromJson(Map<String, dynamic> json) {
    return RecommendedActivitiesModel(
      bestActivities:
          (json['best_activities'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      avoidActivities:
          (json['avoid_activities'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
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

  // ✅ Ultra-safe AI Parsing
  factory IrrigationAdviceModel.fromJson(Map<String, dynamic> json) {
    return IrrigationAdviceModel(
      title: json['title']?.toString() ?? "Irrigation Info",
      subtitle: json['subtitle']?.toString() ?? "",
      basedOn: json['based_on']?.toString() ?? "",
      tips:
          (json['tips'] as List<dynamic>?)?.map((e) => e.toString()).toList() ??
          [],
    );
  }
}
