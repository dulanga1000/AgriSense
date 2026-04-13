import 'package:agrisense/data/models/weather_model.dart';

class WeatherRepository {
<<<<<<< Updated upstream
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
=======
  final String apiKey = "00987b3eb10e67bc4d51f1227428b027";

  // ✅ Real current-weather API call
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
          'rainChance': _calculateRainChance(jsonData),
          'rainPrediction':
              "Today - ${(_calculateRainChance(jsonData) * 100).toInt()}% chance of rain",
        };
      }
>>>>>>> Stashed changes
    }
  }

<<<<<<< Updated upstream
=======
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

  double _calculateRainChance(Map<String, dynamic> json) {
    final condition = json['weather'][0]['main'].toString().toLowerCase();

    if (condition.contains("rain")) return 0.8;
    if (condition.contains("cloud")) return 0.4;
    return 0.1;
  }

  // ✅ Unchanged — gets current weather
>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
=======
  // ✅ Unchanged — rain prediction
>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
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
=======
  // ---------------------------------------------------------------------------
  // Real OpenWeather 5-day forecast endpoint (/data/2.5/forecast)
  // Provides 3-hour interval slots for the next 5 days.
  // Shared across all methods below to avoid repeated API calls.
  // ---------------------------------------------------------------------------

  /// Fetches the raw 5-day / 3-hour forecast JSON slot list from OpenWeather.
  Future<List<dynamic>> _fetchForecastData(String location) async {
    final queryCandidates = _buildQueryCandidates(location);

    for (final query in queryCandidates) {
      final url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?q=$query&units=metric&cnt=40&appid=$apiKey",
>>>>>>> Stashed changes
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return jsonData['list'] as List<dynamic>;
      }
    }

    throw Exception("Failed to load forecast data");
  }

  /// Groups 3-hour forecast slots by calendar day (YYYY-MM-DD key).
  Map<String, List<dynamic>> _groupSlotsByDay(List<dynamic> slots) {
    final grouped = <String, List<dynamic>>{};
    for (final slot in slots) {
      // dt_txt format: "2024-04-14 09:00:00"
      final dateKey = (slot['dt_txt'] as String).substring(0, 10);
      grouped.putIfAbsent(dateKey, () => []).add(slot);
    }
    return grouped;
  }

  /// Maps a "YYYY-MM-DD" string to a short day abbreviation (Mon, Tue, …).
  String _dayAbbreviation(String dateKey) {
    final date = DateTime.parse(dateKey);
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1]; // weekday: 1 = Monday … 7 = Sunday
  }

  /// Returns the dominant display condition ("sunny", "cloud", or "rain")
  /// from the most frequently occurring weather main value in the day's slots.
  String _dominantCondition(List<dynamic> slots) {
    final counts = <String, int>{};
    for (final slot in slots) {
      final main = (slot['weather'][0]['main'] as String).toLowerCase();
      counts[main] = (counts[main] ?? 0) + 1;
    }
    final sorted = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final top = sorted.first.key;

    if (top.contains('rain') || top.contains('drizzle')) return 'rain';
    if (top.contains('cloud')) return 'cloud';
    return 'sunny';
  }

  /// Calculates average precipitation probability (pop) across all slots.
  double _averagePop(List<dynamic> slots) {
    if (slots.isEmpty) return 0.0;
    final total = slots.fold<double>(
      0.0,
      (sum, slot) => sum + ((slot['pop'] ?? 0.0) as num).toDouble(),
    );
    return total / slots.length;
  }

  // ---------------------------------------------------------------------------
  // 5-Day Forecast — real data from /data/2.5/forecast
  // ---------------------------------------------------------------------------

  Future<List<ForecastModel>> getForecast(String location) async {
    final slots = await _fetchForecastData(location);
    final grouped = _groupSlotsByDay(slots);

    // Take the first 5 distinct days.
    final days = grouped.keys.take(5).toList();

    return days.map((dateKey) {
      final daySlots = grouped[dateKey]!;

      final avgTemp = daySlots.fold<double>(
            0.0,
            (sum, s) => sum + ((s['main']['temp'] as num).toDouble()),
          ) /
          daySlots.length;

      final pop = _averagePop(daySlots);
      final condition = _dominantCondition(daySlots);

      return ForecastModel(
        day: _dayAbbreviation(dateKey),
        temp: "${avgTemp.round()}°",
        rain: "${(pop * 100).round()}%",
        condition: condition,
      );
    }).toList();
  }

  // ---------------------------------------------------------------------------
  // Weather Trends — real daily aggregates for temperature, humidity & rainfall
  // ---------------------------------------------------------------------------

  Future<List<WeatherTrendModel>> getWeatherTrends(String location) async {
<<<<<<< Updated upstream
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
=======
    final slots = await _fetchForecastData(location);
    final grouped = _groupSlotsByDay(slots);

    // Take up to 5 days (free-tier OpenWeather provides 5 days).
    final days = grouped.keys.take(5).toList();

    return days.map((dateKey) {
      final daySlots = grouped[dateKey]!;

      final avgTemp = daySlots.fold<double>(
            0.0,
            (sum, s) => sum + ((s['main']['temp'] as num).toDouble()),
          ) /
          daySlots.length;

      final avgHumidity = daySlots.fold<double>(
            0.0,
            (sum, s) => sum + ((s['main']['humidity'] as num).toDouble()),
          ) /
          daySlots.length;

      // Express rain probability as a 0-100 integer for chart display.
      final avgRainfall = _averagePop(daySlots) * 100;

      return WeatherTrendModel(
        day: _dayAbbreviation(dateKey),
        temperature: avgTemp.round(),
        rainfall: avgRainfall.round(),
        humidity: avgHumidity.round(),
      );
    }).toList();
  }

  // ---------------------------------------------------------------------------
  // Weather Alerts — based on today's forecast slots
  // ---------------------------------------------------------------------------

  Future<List<WeatherAlertModel>> getWeatherAlerts(String location) async {
    final slots = await _fetchForecastData(location);

    // Use only today's slots for the alert assessment.
    final grouped = _groupSlotsByDay(slots);
    final todayKey = grouped.keys.first;
    final todaySlots = grouped[todayKey]!;

    final rainChance = _averagePop(todaySlots);

    final avgHumidity = todaySlots.fold<double>(
          0.0,
          (sum, s) => sum + ((s['main']['humidity'] as num).toDouble()),
        ) /
        todaySlots.length;

    final avgWindKph = todaySlots.fold<double>(
          0.0,
          (sum, s) => sum + ((s['wind']['speed'] as num).toDouble() * 3.6),
        ) /
        todaySlots.length;
>>>>>>> Stashed changes

    final alerts = <WeatherAlertModel>[];

    // High rain probability alert.
    if (rainChance > 0.6) {
      alerts.add(
        WeatherAlertModel(
          title: "Heavy Rain Alert",
          message:
<<<<<<< Updated upstream
              "High chance of rain (${rainChance * 100}%) - Postpone outdoor farming activities."
                  .replaceAll('.0', ''),
=======
              "High chance of rain (${(rainChance * 100).round()}%) today — postpone outdoor farming activities.",
          type: "rain",
        ),
      );
    }

    // High humidity alert.
    if (avgHumidity > 75) {
      alerts.add(
        WeatherAlertModel(
          title: "High Humidity Notice",
          message:
              "Humidity at ${avgHumidity.round()}% — monitor crops for fungal diseases.",
          type: "humidity",
        ),
      );
    }

    // Strong wind alert (> 40 km/h).
    if (avgWindKph > 40) {
      alerts.add(
        WeatherAlertModel(
          title: "Strong Wind Advisory",
          message:
              "Average wind speed ${avgWindKph.round()} km/h — secure stakes, trellises, and equipment.",
>>>>>>> Stashed changes
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

    // No adverse conditions — show a clear / all-good notice.
    if (alerts.isEmpty) {
      alerts.add(
        WeatherAlertModel(
          title: "All Clear",
          message:
<<<<<<< Updated upstream
              "Humidity at $humidity% - Monitor crops for fungal diseases. Ensure proper ventilation.",
          type: "humidity",
=======
              "No significant weather events expected today — ideal conditions for outdoor farming.",
          type: "clear",
>>>>>>> Stashed changes
        ),
      );
    }

    return alerts;
  }

  // ---------------------------------------------------------------------------
  // Recommended Activities — driven by rain probability, temperature & humidity
  // ---------------------------------------------------------------------------

  Future<RecommendedActivitiesModel> getRecommendedActivities(
    String location,
  ) async {
<<<<<<< Updated upstream
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
=======
    final slots = await _fetchForecastData(location);

    final grouped = _groupSlotsByDay(slots);
    final todayKey = grouped.keys.first;
    final todaySlots = grouped[todayKey]!;

    final rainChance = _averagePop(todaySlots);
    final condition = _dominantCondition(todaySlots);

    final avgTemp = todaySlots.fold<double>(
          0.0,
          (sum, s) => sum + ((s['main']['temp'] as num).toDouble()),
        ) /
        todaySlots.length;

    final avgHumidity = todaySlots.fold<double>(
          0.0,
          (sum, s) => sum + ((s['main']['humidity'] as num).toDouble()),
        ) /
        todaySlots.length;

    final List<String> bestActivities;
    final List<String> avoidActivities;

    if (rainChance >= 0.6 || condition == 'rain') {
      // Rainy day — indoor or rain-tolerant tasks.
      bestActivities = [
        "Indoor crop monitoring & record-keeping",
        "Greenhouse maintenance",
        "Equipment servicing & repairs",
        "Post-harvest processing in covered areas",
      ];
      avoidActivities = [
        "Planting & transplanting seedlings",
        "Applying fertilizers or pesticides",
        "Harvesting field crops",
        "Soil tilling & land preparation",
      ];
    } else if (rainChance >= 0.3 || condition == 'cloud') {
      // Partly cloudy / mild rain risk — light outdoor work.
      bestActivities = [
        "Light weeding & crop inspection",
        "Irrigation system maintenance",
        "Soil sampling & testing",
        "Covered seedling preparation",
      ];
      avoidActivities = [
        "Spraying agrochemicals (risk of rain wash-off)",
        "Heavy harvesting without cover nearby",
      ];
    } else {
      // Clear / sunny — optimal conditions for fieldwork.
      final isHot = avgTemp > 32;
      final isHumid = avgHumidity > 70;

      bestActivities = [
        "Planting & transplanting seedlings",
        "Field preparation & soil tilling",
        if (!isHot) "Fertilizer & pesticide application",
        "Harvesting mature crops",
        if (!isHumid) "Drying & post-harvest processing outdoors",
      ];
      avoidActivities = [
        if (isHot) "Heavy fieldwork during peak heat (12 PM–3 PM)",
        "Over-watering — natural conditions are sufficient",
        if (isHumid) "Leaving harvested produce exposed for long periods",
        if (!isHot && !isHumid)
          "No major restrictions — enjoy the clear weather!",
      ];
    }

    return RecommendedActivitiesModel(
      bestActivities: bestActivities,
      avoidActivities: avoidActivities,
>>>>>>> Stashed changes
    );
  }

  // ---------------------------------------------------------------------------
  // Irrigation Advice — driven by rain probability, expected rainfall & humidity
  // ---------------------------------------------------------------------------

  Future<IrrigationAdviceModel> getIrrigationAdvice(String location) async {
<<<<<<< Updated upstream
    final data = _getLocationData(location);
    final rainChance = data['rainChance'] as double;
    final humidity = data['humidity'] as int;

    await Future.delayed(const Duration(milliseconds: 300));
=======
    final slots = await _fetchForecastData(location);

    final grouped = _groupSlotsByDay(slots);
    final todayKey = grouped.keys.first;
    final todaySlots = grouped[todayKey]!;
>>>>>>> Stashed changes

    final rainChance = _averagePop(todaySlots);

    final avgHumidity = todaySlots.fold<double>(
          0.0,
          (sum, s) => sum + ((s['main']['humidity'] as num).toDouble()),
        ) /
        todaySlots.length;

    // Sum expected rainfall in mm across all 3-hour slots for today.
    final totalRainMm = todaySlots.fold<double>(
      0.0,
      (sum, s) =>
          sum + (((s['rain'] as Map?)?['3h'] ?? 0.0) as num).toDouble(),
    );

    final String irrigationLevel;
    final List<String> tips;

    if (rainChance >= 0.7 || totalRainMm >= 10) {
      // Heavy rain expected — no irrigation needed.
      irrigationLevel = "No";
      tips = [
        "Skip irrigation entirely — sufficient rainfall expected today.",
        "Check drainage channels to prevent waterlogging.",
        "Inspect fields for standing water after rainfall.",
      ];
    } else if (rainChance >= 0.4 || totalRainMm >= 4) {
      // Light to moderate rain expected — reduce irrigation.
      irrigationLevel = "Minimal";
      tips = [
        "Reduce irrigation by 50% — light rain is forecast.",
        "Water only drought-sensitive crops or new seedlings.",
        "Early morning irrigation (before 7 AM) is most efficient.",
      ];
    } else if (avgHumidity >= 70) {
      // High humidity reduces crop water demand.
      irrigationLevel = "Moderate";
      tips = [
        "Apply moderate irrigation — high humidity limits evaporation.",
        "Prefer drip irrigation to avoid wetting foliage.",
        "Monitor soil moisture before each irrigation cycle.",
      ];
    } else {
      // Dry and clear — full irrigation required.
      irrigationLevel = "Full";
      tips = [
        "Full irrigation recommended — dry conditions expected.",
        "Water deeply in the early morning (before 8 AM).",
        "Consider mulching to slow soil moisture evaporation.",
        "Schedule irrigation every 1–2 days based on crop type.",
      ];
    }

    return IrrigationAdviceModel(
      title: "$irrigationLevel Irrigation\nNeeded",
      subtitle:
<<<<<<< Updated upstream
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
=======
          "Based on ${(rainChance * 100).round()}% rain chance & ${avgHumidity.round()}% humidity",
      basedOn:
          "${(rainChance * 100).round()}% rain probability and ${avgHumidity.round()}% humidity",
      tips: tips,
>>>>>>> Stashed changes
    );
  }
}
