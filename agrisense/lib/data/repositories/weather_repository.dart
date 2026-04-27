import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:agrisense/data/models/weather_model.dart';

class WeatherRepository {
  // 🔐 Put your API Keys here
  final String owmApiKey =
      dotenv.env['OPENWEATHER_API_KEY'] ?? dotenv.env['OWM_API_KEY'] ?? '';
  final String geminiApiKey = dotenv.env['GEMINI_API_KEY'] ?? '';

  // --- 🧠 Smart Cache System ---
  String? _cachedLocation;
  WeatherModel? _currentWeatherCache;
  List<ForecastModel>? _forecastCache;
  Map<String, dynamic>? _aiInsightCache;
  Future<void>? _fetchTask;

  // Ensures we only make ONE API call, even if the UI asks for all 7 items at once
  Future<void> _ensureDataLoaded(String location) async {
    final cleanLocation = location.split(',').first.trim();

    if (_cachedLocation == cleanLocation && _aiInsightCache != null) return;

    if (_fetchTask != null && _cachedLocation == cleanLocation) {
      await _fetchTask;
      return;
    }

    _cachedLocation = cleanLocation;
    _fetchTask = _fetchAllData(cleanLocation);
    await _fetchTask;
    _fetchTask = null;
  }

  Future<void> _fetchAllData(String location) async {
    try {
      // 1. Fetch Current Weather (Real API)
      final currentUrl = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$location,LK&units=metric&appid=$owmApiKey",
      );
      final currentRes = await http.get(currentUrl);
      if (currentRes.statusCode != 200) {
        throw Exception("Failed to load current weather");
      }

      final currentJson = json.decode(currentRes.body);
      _currentWeatherCache = WeatherModel.fromJson(currentJson);

      // 2. Fetch 5-Day Forecast (Real API)
      final forecastUrl = Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?q=$location,LK&units=metric&appid=$owmApiKey",
      );
      final forecastRes = await http.get(forecastUrl);
      if (forecastRes.statusCode != 200) {
        throw Exception("Failed to load forecast");
      }

      final forecastJson = json.decode(forecastRes.body);
      _forecastCache = _parse5DayForecast(forecastJson['list']);

      // 3. Generate Smart Insights using Gemini AI
      _aiInsightCache = await _generateGeminiInsights(
        location,
        _currentWeatherCache!,
        _forecastCache!,
      );
    } catch (e) {
      throw Exception("Failed to sync weather data: $e");
    }
  }

  List<ForecastModel> _parse5DayForecast(List<dynamic> list) {
    final Map<String, ForecastModel> dailyForecasts = {};

    for (var item in list) {
      final dateText = item['dt_txt'] as String;
      final date = DateTime.parse(dateText);
      final dayName = DateFormat('E').format(date); // Mon, Tue, etc.

      // Grab the 12:00 PM reading for a standard daily view
      if (dateText.contains("12:00:00") && dailyForecasts.length < 5) {
        dailyForecasts[dayName] = ForecastModel(
          day: dayName,
          temp: "${item['main']['temp'].round()}°",
          rain: "${(item['pop'] * 100).round()}%",
          condition: item['weather'][0]['main'].toString(),
        );
      }
    }
    return dailyForecasts.values.toList();
  }

  Future<Map<String, dynamic>> _generateGeminiInsights(
    String location,
    WeatherModel current,
    List<ForecastModel> forecast,
  ) async {
    // Fallback models for handling high demand (503 errors)
    final models = [
      "gemini-2.5-flash",
      "gemini-2.0-flash",
      "gemini-2.0-flash-lite",
    ];

    String forecastSummary = forecast
        .map((f) => "${f.day}: ${f.temp}, ${f.condition}, Rain: ${f.rain}")
        .join(" | ");

    final prompt =
        '''
    You are an expert Sri Lankan Agronomist AI. Analyze the following weather data for $location, Sri Lanka.
    Current: ${current.temperature}°C, ${current.condition}, Humidity: ${current.humidity}%.
    5-Day Forecast: $forecastSummary.

    Generate farming advice and extend the trends to 7 days based on seasonal expectations.
    Respond ONLY with a valid JSON object using exactly this schema. Do NOT use markdown code blocks.
    {
      "rainPrediction": {
        "title": "Rain Prediction",
        "todayPrediction": "String (e.g., 'Today - 80% chance of rain')",
        "rainChance": 0.8,
        "description": "Short agricultural advice based on rain chance"
      },
      "trends": [
        {"day": "Mon", "temperature": 28, "rainfall": 40, "humidity": 75} 
      ],
      "alerts": [
        {"title": "Alert Title", "message": "Alert message", "type": "warning"} 
      ],
      "activities": {
        "best_activities": ["activity 1", "activity 2"],
        "avoid_activities": ["activity 1", "activity 2"]
      },
      "irrigation": {
        "title": "High/Moderate/Minimal Irrigation Needed",
        "subtitle": "Short reason",
        "based_on": "Detailed reason",
        "tips": ["tip 1", "tip 2"]
      }
    }
    ''';

    Exception? lastException;

    for (final modelName in models) {
      for (var attempt = 0; attempt < 3; attempt++) {
        try {
          final model = GenerativeModel(model: modelName, apiKey: geminiApiKey);

          final response = await model.generateContent([Content.text(prompt)]);

          final responseText = response.text;
          if (responseText == null || responseText.trim().isEmpty) {
            throw Exception('Empty response from Gemini API');
          }

          // ✅ JSON Cleaner: Safely removes markdown blocks if Gemini accidentally adds them
          String cleanText = responseText.trim();
          if (cleanText.startsWith('```json')) {
            cleanText = cleanText.substring(7);
          } else if (cleanText.startsWith('```')) {
            cleanText = cleanText.substring(3);
          }
          if (cleanText.endsWith('```')) {
            cleanText = cleanText.substring(0, cleanText.length - 3);
          }

          return json.decode(cleanText.trim());
        } catch (e) {
          lastException = Exception(e.toString());

          // Check if error is retryable (503 Service Unavailable, rate limit 429, etc.)
          final isRetryable =
              e.toString().contains('503') ||
              e.toString().contains('429') ||
              e.toString().contains('unavailable') ||
              e.toString().contains('UNAVAILABLE');

          if (isRetryable && attempt < 2) {
            // Exponential backoff: 800ms, 1600ms, 2400ms
            await Future.delayed(Duration(milliseconds: 800 * (attempt + 1)));
            continue;
          }

          if (!isRetryable) {
            // Non-retryable error, skip to next model immediately
            break;
          }
        }
      }
    }

    // All models exhausted, throw the last exception
    throw Exception(
      "Failed to generate Gemini insights after trying all models: ${lastException?.toString()}",
    );
  }

  // =======================================================================
  // PUBLIC METHODS (These keep your UI working perfectly)
  // =======================================================================

  Future<WeatherModel> getCurrentWeather(String location) async {
    await _ensureDataLoaded(location);
    return _currentWeatherCache!;
  }

  Future<List<ForecastModel>> getForecast(String location) async {
    await _ensureDataLoaded(location);
    return _forecastCache!;
  }

  Future<RainPredictionModel> getRainPrediction(String location) async {
    await _ensureDataLoaded(location);
    return RainPredictionModel.fromJson(_aiInsightCache!['rainPrediction']);
  }

  Future<List<WeatherTrendModel>> getWeatherTrends(String location) async {
    await _ensureDataLoaded(location);
    final List<dynamic> trendsList = _aiInsightCache!['trends'] ?? [];
    return trendsList.map((json) => WeatherTrendModel.fromJson(json)).toList();
  }

  Future<List<WeatherAlertModel>> getWeatherAlerts(String location) async {
    await _ensureDataLoaded(location);
    final List<dynamic> alertsList = _aiInsightCache!['alerts'] ?? [];
    return alertsList.map((json) => WeatherAlertModel.fromJson(json)).toList();
  }

  Future<RecommendedActivitiesModel> getRecommendedActivities(
    String location,
  ) async {
    await _ensureDataLoaded(location);
    return RecommendedActivitiesModel.fromJson(_aiInsightCache!['activities']);
  }

  Future<IrrigationAdviceModel> getIrrigationAdvice(String location) async {
    await _ensureDataLoaded(location);
    return IrrigationAdviceModel.fromJson(_aiInsightCache!['irrigation']);
  }
}
