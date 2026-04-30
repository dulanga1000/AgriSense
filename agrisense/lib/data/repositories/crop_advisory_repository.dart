import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:agrisense/data/constants/crop_fallback_data.dart';

class CropAdvisoryRepository {
  final String geminiApiKey = dotenv.env['GEMINI_API_KEY'] ?? '';

  // --- 🧠 Smart Cache System ---
  String? _cachedLocation;
  String? _cachedSeason;
  Map<String, dynamic>? _aiCache;
  Future<void>? _fetchTask;
  String? _fetchingKey;
  int _latestFetchId = 0;

  String _buildRequestKey(String location, String season) {
    return '${location.trim().toLowerCase()}|${season.trim().toLowerCase()}';
  }

  void _setCacheIfLatest(
    int fetchId,
    String location,
    String season,
    Map<String, dynamic> data,
  ) {
    if (fetchId != _latestFetchId) {
      return;
    }

    _cachedLocation = location;
    _cachedSeason = season;
    _aiCache = data;
  }

  Future<void> _ensureDataLoaded(String location, String season) async {
    final requestKey = _buildRequestKey(location, season);

    // If the data for this location+season is already loaded, return instantly
    if (_cachedLocation == location &&
        _cachedSeason == season &&
        _aiCache != null) {
      return;
    }

    // If a fetch is already running for this exact request, wait for it
    if (_fetchTask != null && _fetchingKey == requestKey) {
      await _fetchTask;
      return;
    }

    // Invalidate old cache immediately so stale data is never returned
    _aiCache = null;

    final fetchId = ++_latestFetchId;
    _fetchingKey = requestKey;
    _fetchTask = _fetchFromGeminiWithFallback(location, season, fetchId);

    try {
      await _fetchTask;
    } finally {
      if (_latestFetchId == fetchId) {
        _fetchTask = null;
        _fetchingKey = null;
      }
    }
  }

  Future<void> _fetchFromGeminiWithFallback(
    String location,
    String season,
    int fetchId,
  ) async {
    const maxAttempts = 3;

    for (var attempt = 0; attempt < maxAttempts; attempt++) {
      try {
        await _fetchFromGemini(location, season, fetchId);
        return;
      } catch (e) {
        final isLastAttempt = attempt == maxAttempts - 1;
        final isRetryable = _isRetryableGeminiError(e);

        if (!isRetryable || isLastAttempt) {
          _setCacheIfLatest(
            fetchId,
            location,
            season,
            _buildFallbackAdvisory(location, season),
          );
          return;
        }

        await Future.delayed(Duration(milliseconds: 800 * (attempt + 1)));
      }
    }

    _setCacheIfLatest(
      fetchId,
      location,
      season,
      _buildFallbackAdvisory(location, season),
    );
  }

  Future<void> _fetchFromGemini(
    String location,
    String season,
    int fetchId,
  ) async {
    if (geminiApiKey.isEmpty) {
      throw Exception('GEMINI_API_KEY is not set in .env file');
    }

    final model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: geminiApiKey,
    );

    final prompt =
        '''
    You are an expert Sri Lankan Agronomist AI specialized in diverse crop recommendations.
    Provide comprehensive crop and farming advisory for the selected context below.
    Location (district): $location
    Season: $season

    IMPORTANT: Return 6-8 DIFFERENT crops that are suitable and PROFITABLE for $location during the $season season.
    IMPORTANT: Crop list, tips, and market prices MUST change for different districts and different seasons.
    IMPORTANT: Include at least 2 recommendations unique to this district and at least 2 recommendations unique to this season.
    Prioritize: main crops, high-value crops, vegetables, pulses, and any specialty crops for this region.
    The response MUST be specific to this exact district and this exact season combination.
    Respond ONLY with a valid JSON object using exactly this schema. Do NOT use markdown code blocks like ```json.
    {
      "crops": [
        {"crop_name": "Crop Name", "duration": "3 months", "water": "High/Medium/Low", "profit": "High/Medium", "tag": "Prime Time or Good Time", "icon_name": "rice or maize or vegetable or leaf or tractor or basket or water or bug", "suited": "Soil/Area types"}
      ],
      "calendar": [
        {"month": "Month Name", "crops": "Crop names", "label": "Planting/Harvesting", "icon_name": "tractor or leaf or basket"}
      ],
      "prices": [
        {"crop": "Crop Name", "price": "Rs. X-Y/kg", "demand": "↑ High Demand", "demand_type": "high/medium/low"}
      ],
      "tips": [
        {"title": "Tip Title", "description": "Actionable farming advice", "type": "water/soil/pest"}
      ]
    }
    ''';

    final response = await model.generateContent([Content.text(prompt)]);
    final responseText = response.text;
    if (responseText == null || responseText.trim().isEmpty) {
      throw Exception('Empty response from Gemini API');
    }

    // JSON Cleaner
    String cleanText = responseText.trim();
    if (cleanText.startsWith('```json')) {
      cleanText = cleanText.substring(7);
    } else if (cleanText.startsWith('```')) {
      cleanText = cleanText.substring(3);
    }
    if (cleanText.endsWith('```')) {
      cleanText = cleanText.substring(0, cleanText.length - 3);
    }

    final parsed = json.decode(_extractJsonObject(cleanText));
    if (parsed is! Map<String, dynamic>) {
      throw Exception('Invalid advisory payload from Gemini');
    }

    _setCacheIfLatest(fetchId, location, season, parsed);
  }

  bool _isRetryableGeminiError(Object error) {
    final msg = error.toString().toLowerCase();
    return msg.contains('503') ||
        msg.contains('429') ||
        msg.contains('unavailable') ||
        msg.contains('high demand') ||
        msg.contains('deadline exceeded') ||
        msg.contains('quota') ||
        msg.contains('resource_exhausted') ||
        msg.contains('rate') ||
        msg.contains('overloaded');
  }

  String _extractJsonObject(String text) {
    final start = text.indexOf('{');
    final end = text.lastIndexOf('}');

    if (start == -1 || end == -1 || end <= start) {
      throw Exception('Invalid JSON from Gemini response');
    }

    return text.substring(start, end + 1).trim();
  }

  Map<String, dynamic> _buildFallbackAdvisory(String location, String season) {
    final isYala = season.toLowerCase().contains('yala');
    final zone = CropFallbackData.getZone(location);

    return {
      'crops': CropFallbackData.getCrops(zone, isYala, location),
      'calendar': CropFallbackData.getCalendar(zone, isYala),
      'prices': CropFallbackData.getPrices(zone, isYala),
      'tips': CropFallbackData.getTips(zone, isYala, location, season),
    };
  }

  // =======================================================================
  // PUBLIC METHOD
  // =======================================================================

  /// Returns the full advisory data map for a given location and season.
  /// Makes a single fetch call (or returns cached data) and provides
  /// all sections (crops, calendar, prices, tips) at once.
  Future<Map<String, dynamic>> getAdvisoryData(
    String location,
    String season,
  ) async {
    await _ensureDataLoaded(location, season);
    return _aiCache ?? _buildFallbackAdvisory(location, season);
  }
}
