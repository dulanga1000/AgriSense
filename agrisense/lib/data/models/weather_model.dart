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
      city: json['name'],
      temperature: json['main']['temp'].toDouble(),
      humidity: json['main']['humidity'].toInt(),
      condition: json['weather'][0]['main'],
    );
  }
}
