import 'package:flutter/material.dart';
import 'package:agrisense/data/models/weather_model.dart';
import 'package:agrisense/data/repositories/weather_repository.dart';

class WeatherState extends ChangeNotifier {
  final WeatherRepository _repository = WeatherRepository();

  String selectedLocation = "Western Province, Sri Lanka";
  bool isLoading = false;

  WeatherModel? weather;
  RainPredictionModel? rainPrediction;
  List<ForecastModel> forecast = [];
  List<WeatherTrendModel> trends = [];
  List<WeatherAlertModel> alerts = [];
  RecommendedActivitiesModel? activities;
  IrrigationAdviceModel? irrigationAdvice;

  Future<void> loadWeatherData() async {
    isLoading = true;
    notifyListeners();

    weather = await _repository.getCurrentWeather(selectedLocation);
    rainPrediction = await _repository.getRainPrediction(selectedLocation);
    forecast = await _repository.getForecast(selectedLocation);
    trends = await _repository.getWeatherTrends(selectedLocation);
    alerts = await _repository.getWeatherAlerts(selectedLocation);
    activities = await _repository.getRecommendedActivities(selectedLocation);
    irrigationAdvice = await _repository.getIrrigationAdvice(selectedLocation);

    isLoading = false;
    notifyListeners();
  }

  Future<void> updateLocation(String location) async {
    selectedLocation = location;
    notifyListeners();
    await loadWeatherData();
  }
}
