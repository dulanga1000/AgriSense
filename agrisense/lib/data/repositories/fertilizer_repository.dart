import 'dart:convert';

import 'package:agrisense/data/models/fertilizer_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FertilizerRepository {
  static const String _cachePrefix = "fertilizer_recommendation_";
  static const String _geminiModel = "gemini-2.5-flash"; // Gemini API model

  SharedPreferences? _prefs;
  late final GenerativeModel _model;
  bool _isInitialized = false;

  FertilizerRepository() {
    _initializeAPI();
  }

  void _initializeAPI() {
    try {
      final apiKey = dotenv.env['GEMINI_API_KEY'];
      if (apiKey == null || apiKey.isEmpty) {
        throw Exception('GEMINI_API_KEY not found in .env file');
      }
      _model = GenerativeModel(model: _geminiModel, apiKey: apiKey);
      _isInitialized = true;
    } catch (e) {
      throw Exception("Failed to initialize Gemini API: $e");
    }
  }

  String _getCacheKey(String cropType, double landSize) {
    return "$_cachePrefix${cropType.toLowerCase()}_${landSize.toStringAsFixed(1)}";
  }

  /// Gets fertilizer recommendation using Gemini API with caching
  Future<FertilizerModel> getRecommendation(
    String cropType,
    double landSize,
  ) async {
    if (!_isInitialized) {
      throw Exception(
        "Repository not initialized. Ensure GEMINI_API_KEY is set in .env",
      );
    }

    try {
      // Initialize SharedPreferences for caching
      _prefs ??= await SharedPreferences.getInstance();

      // Check cache first
      final cacheKey = _getCacheKey(cropType, landSize);
      final cachedData = _prefs?.getString(cacheKey);

      if (cachedData != null) {
        final jsonData = jsonDecode(cachedData) as Map<String, dynamic>;
        return FertilizerModel.fromJson(jsonData);
      }

      // Call Gemini API for recommendation
      final recommendation = await _getFromAPI(cropType, landSize);

      // Cache the result
      _cacheRecommendation(cacheKey, recommendation);

      return recommendation;
    } catch (e) {
      throw Exception("Fertilizer recommendation failed: $e");
    }
  }

  /// Get recommendation from Gemini API
  Future<FertilizerModel> _getFromAPI(String cropType, double landSize) async {
    final prompt = _buildFertilizerPrompt(cropType, landSize);
    final content = [Content.text(prompt)];

    final response = await _model.generateContent(content);

    if (response.text == null || response.text!.isEmpty) {
      throw Exception("Empty response from Gemini API");
    }

    return _parseFertilizerResponse(response.text!, cropType);
  }

  /// Builds optimized prompt for fertilizer recommendations
  String _buildFertilizerPrompt(String cropType, double landSize) {
    return """Provide fertilizer recommendation for $cropType on $landSize acres.
Return ONLY this JSON format (no markdown):
{
  "fertilizer_name": "specific fertilizer name",
  "npk_ratio": "N-P-K ratio like 10-26-26",
  "total_quantity": total_kg_needed,
  "estimated_cost": cost_per_kg,
  "usage_steps": ["step1", "step2", "step3"],
  "application_timing": "when to apply"
}""";
  }

  /// Parse AI response and convert to FertilizerModel
  FertilizerModel _parseFertilizerResponse(
    String responseText,
    String cropType,
  ) {
    try {
      // Clean response - remove markdown if present
      String cleaned = responseText
          .replaceAll('```json', '')
          .replaceAll('```', '')
          .trim();

      final jsonData = jsonDecode(cleaned) as Map<String, dynamic>;

      return FertilizerModel(
        cropType: cropType,
        fertilizerName: jsonData['fertilizer_name'] ?? 'Recommended Fertilizer',
        npkRatio: jsonData['npk_ratio'] ?? '0-0-0',
        totalQuantity: _toDouble(jsonData['total_quantity']),
        estimatedCost: _toDouble(jsonData['estimated_cost']),
        usageSteps: List<String>.from(jsonData['usage_steps'] ?? []),
        applicationTiming:
            jsonData['application_timing'] ?? 'As per recommendations',
      );
    } catch (e) {
      throw Exception("Failed to parse AI response: $e");
    }
  }

  /// Helper to safely convert to double
  double _toDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  /// Cache recommendation to local storage
  void _cacheRecommendation(String key, FertilizerModel model) {
    try {
      if (_prefs == null) return;

      final jsonData = {
        'crop_type': model.cropType,
        'fertilizer_name': model.fertilizerName,
        'npk_ratio': model.npkRatio,
        'total_quantity': model.totalQuantity,
        'estimated_cost': model.estimatedCost,
        'usage_steps': model.usageSteps,
        'application_timing': model.applicationTiming,
      };
      _prefs?.setString(key, jsonEncode(jsonData));
    } catch (_) {
      // Silently fail - caching is optional
    }
  }
}
