import 'package:flutter/material.dart';
import 'package:agrisense/data/models/weather_model.dart';
import 'package:agrisense/data/repositories/weather_repository.dart';

class WeatherState extends ChangeNotifier {
  final WeatherRepository _repository;

  WeatherState(this._repository);

  String _selectedLocation = 'Colombo, Western Province';
  bool _isLoading = false;
  String? _errorMessage;

  WeatherModel? _weather;
  RainPredictionModel? _rainPrediction;
  List<ForecastModel> _forecast = [];
  List<WeatherTrendModel> _trends = [];
  List<WeatherAlertModel> _alerts = [];
  RecommendedActivitiesModel? _activities;
  IrrigationAdviceModel? _irrigationAdvice;

  String get selectedLocation => _selectedLocation;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null && _errorMessage!.isNotEmpty;

  WeatherModel? get weather => _weather;
  RainPredictionModel? get rainPrediction => _rainPrediction;
  List<ForecastModel> get forecast => _forecast;
  List<WeatherTrendModel> get trends => _trends;
  List<WeatherAlertModel> get alerts => _alerts;
  RecommendedActivitiesModel? get activities => _activities;
  IrrigationAdviceModel? get irrigationAdvice => _irrigationAdvice;

  Future<void> loadWeatherData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _repository.getCurrentWeather(_selectedLocation),
        _repository.getRainPrediction(_selectedLocation),
        _repository.getForecast(_selectedLocation),
        _repository.getWeatherTrends(_selectedLocation),
        _repository.getWeatherAlerts(_selectedLocation),
        _repository.getRecommendedActivities(_selectedLocation),
        _repository.getIrrigationAdvice(_selectedLocation),
      ]);

      _weather = results[0] as WeatherModel;
      _rainPrediction = results[1] as RainPredictionModel;
      _forecast = results[2] as List<ForecastModel>;
      _trends = results[3] as List<WeatherTrendModel>;
      _alerts = results[4] as List<WeatherAlertModel>;
      _activities = results[5] as RecommendedActivitiesModel;
      _irrigationAdvice = results[6] as IrrigationAdviceModel;
    } catch (e, st) {
      _errorMessage = 'Failed to load weather data. Please try again.';
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: e,
          stack: st,
          library: 'weather_state',
          context: ErrorDescription('while loading weather data'),
        ),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateLocation(String location) async {
    if (_selectedLocation == location) return;
    _selectedLocation = location;
    notifyListeners();
    await loadWeatherData();
  }

  Future<void> retry() async {
    await loadWeatherData();
  }

  void resetForLogout() {
    _selectedLocation = 'Colombo, Western Province';
    _isLoading = false;
    _errorMessage = null;
    _weather = null;
    _rainPrediction = null;
    _forecast = [];
    _trends = [];
    _alerts = [];
    _activities = null;
    _irrigationAdvice = null;
    notifyListeners();
  }
}
