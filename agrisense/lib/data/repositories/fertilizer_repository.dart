import 'dart:convert';

import 'package:agrisense/data/models/fertilizer_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class FertilizerRepository {
  static const String _androidEmulatorEndpoint =
      "http://10.0.2.2:8000/fertilizer";
  static const String _localhostEndpoint = "http://127.0.0.1:8000/fertilizer";
  static const String _geminiModel = "gemini-2.0-flash";

  String get _fertilizerEndpoint {
    final envEndpoint = dotenv.env['FERTILIZER_API_URL'];
    if (envEndpoint != null && envEndpoint.trim().isNotEmpty) {
      final trimmed = envEndpoint.trim();

      // Android emulators cannot reach host machine services via localhost.
      if (defaultTargetPlatform == TargetPlatform.android &&
          (trimmed.contains('127.0.0.1') || trimmed.contains('localhost'))) {
        return trimmed
            .replaceAll('127.0.0.1', '10.0.2.2')
            .replaceAll('localhost', '10.0.2.2');
      }

      return trimmed;
    }

    return defaultTargetPlatform == TargetPlatform.android
        ? _androidEmulatorEndpoint
        : _localhostEndpoint;
  }

  Future<FertilizerModel> getRecommendation(
    String cropType,
    double landSize,
  ) async {
    final response = await http.post(
      Uri.parse(_fertilizerEndpoint),
      headers: const {"Content-Type": "application/json"},
      body: jsonEncode({
        "crop_type": cropType,
        "land_size": landSize,
        "model": _geminiModel,
      }),
    );

    final decoded = jsonDecode(response.body);

    if (response.statusCode != 200) {
      if (decoded is Map<String, dynamic>) {
        final detail = decoded['detail'];
        final error = decoded['error'];
        final message = detail is String
            ? detail
            : error is String
            ? error
            : "Fertilizer API Error (${response.statusCode})";
        throw Exception(message);
      }

      throw Exception(
        "Fertilizer API Error (${response.statusCode}): ${response.body}",
      );
    }

    if (decoded is! Map<String, dynamic>) {
      throw Exception("Invalid fertilizer API response format");
    }

    final apiError = decoded['error'];
    if (apiError is String && apiError.isNotEmpty) {
      throw Exception(apiError);
    }

    final jsonBody = decoded;
    return FertilizerModel.fromJson(jsonBody);
  }
}
