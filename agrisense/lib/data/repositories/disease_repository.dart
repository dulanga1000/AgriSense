import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:agrisense/data/models/disease_result_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DiseaseRepository {
  final String apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';

  DiseaseRepository() {
    if (apiKey.isEmpty) {
      throw Exception("GEMINI_API_KEY is not set in .env file");
    }
  }

  Future<DiseaseResultModel> analyzeImage(File image) async {
    try {
      final bytes = await image.readAsBytes();
      final base64Image = base64Encode(bytes);

      final models = [
        "gemini-2.5-flash",
        "gemini-2.0-flash",
        "gemini-2.0-flash-lite",
      ];

      http.Response? lastResponse;

      for (final model in models) {
        for (var attempt = 0; attempt < 3; attempt++) {
          final response = await http.post(
            Uri.parse(_buildModelUrl(model)),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(_buildRequestBody(base64Image)),
          );

          if (response.statusCode == 200) {
            final data = jsonDecode(response.body);
            final text =
                data["candidates"][0]["content"]["parts"][0]["text"] ?? "";

            final cleaned = _extractJson(text);
            final jsonMap = jsonDecode(cleaned);
            return DiseaseResultModel.fromJson(jsonMap);
          }

          lastResponse = response;

          final shouldRetry =
              _isRetryableStatus(response.statusCode) && attempt < 2;
          if (shouldRetry) {
            await Future.delayed(Duration(milliseconds: 800 * (attempt + 1)));
            continue;
          }

          if (!_isRetryableStatus(response.statusCode)) {
            break;
          }
        }
      }

      throw Exception(
        "API Error (${lastResponse?.statusCode}): ${lastResponse?.body}",
      );
    } catch (e) {
      return const DiseaseResultModel(
        plantName: "Unknown",
        diseaseName: "Unknown",
        scientificName: "Unknown",
        confidence: 0.5,
        symptoms: ["Unable to analyze image"],
        treatments: ["Try again"],
        preventions: ["Use clear image"],
      );
    }
  }

  String _buildModelUrl(String model) {
    return "https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent?key=$apiKey";
  }

  bool _isRetryableStatus(int statusCode) {
    return statusCode == 429 || statusCode == 503;
  }

  Map<String, dynamic> _buildRequestBody(String base64Image) {
    return {
      "contents": [
        {
          "parts": [
            {
              "text": """
You are a plant disease expert.

Only identify plants that are grown in Sri Lanka (all major Sri Lankan crops across provinces and climate zones).
This includes plantation crops, field crops, vegetables, fruits, spices, and export crops.

Examples include (not limited to):
- Rice (paddy), maize, finger millet, green gram, cowpea, soybean, sesame, groundnut, cassava, sweet potato
- Tea, rubber, coconut, cinnamon, pepper, clove, cardamom, nutmeg, coffee, cocoa, arecanut
- Banana, mango, papaya, pineapple, avocado, guava, rambutan, mangosteen, orange, lime, lemon, passion fruit, wood apple
- Tomato, chili, capsicum, brinjal (eggplant), okra, onion, big onion, garlic, potato
- Cabbage, carrot, leeks, beetroot, radish, cauliflower, broccoli, lettuce, beans, peas (important in Nuwara Eliya and other up-country areas)
- Cucumber, watermelon, pumpkin, bitter gourd, snake gourd, ridge gourd, ash plantain, long bean, winged bean

Treat common Sri Lankan local names and English names as valid matches.

If the image is not a Sri Lankan plant (or you are not confident it is), return this exact fallback JSON format with meaningful reason in symptoms:
{
  "plant_name": "Unsupported",
  "disease_name": "Unsupported",
  "scientific_name": "Unknown",
  "confidence": 0.0,
  "symptoms": ["Plant not recognized as a common Sri Lankan crop"],
  "treatments": ["Please upload a clear image of a Sri Lankan crop"],
  "preventions": ["N/A"]
}

Analyze the plant image and return ONLY JSON:

{
  "plant_name": "",
  "disease_name": "",
  "scientific_name": "",
  "confidence": 0.0,
  "symptoms": [],
  "treatments": [],
  "preventions": []
}
""",
            },
            {
              "inlineData": {"mimeType": "image/jpeg", "data": base64Image},
            },
          ],
        },
      ],
    };
  }

  String _extractJson(String text) {
    // Strip markdown formatting that Gemini sometimes includes
    text = text.replaceAll("```json", "").replaceAll("```", "");

    final start = text.indexOf('{');
    final end = text.lastIndexOf('}');

    if (start != -1 && end != -1) {
      return text.substring(start, end + 1);
    }

    throw Exception("Invalid JSON");
  }
}
