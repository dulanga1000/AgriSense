import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class AgriRepository {
  // 💡 ඔබ ලබාදුන් නිවැරදි Groq API Key එක:
  final String apiKey = "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";

  Future<Map<String, dynamic>> getFertilizerRecommendation(String cropType, double landSize) async {
    final url = Uri.parse("https://api.groq.com/openai/v1/chat/completions");

    final prompt = """
    Return a raw JSON object for $cropType fertilizer recommendation in Sri Lanka for $landSize acres.
    JSON structure:
    {
      "fertilizerName": "Example Name",
      "npkRatio": "20:10:10",
      "totalQuantity": 500.0,
      "estimatedCost": 45000.0,
      "usageSteps": ["Step 1", "Step 2"],
      "applicationTiming": "3 stages"
    }
    Strictly return ONLY JSON.
    """;

    try {
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "model": "llama-3.1-8b-instant", // ⚡ වේගවත් සහ ස්ථාවර මාදිලිය
          "messages": [
            {"role": "user", "content": prompt}
          ],
          "response_format": {"type": "json_object"},
          "temperature": 0.1
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String text = data['choices'][0]['message']['content'];
        return jsonDecode(text.trim());
      } else {
        throw Exception("Groq API Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      developer.log("AgriRepository Error", error: e);
      rethrow;
    }
  }

  // 💡 Crop Advisory සඳහා Function එක
  // lib/data/repositories/agri_repository.dart ඇතුළත

Future<Map<String, dynamic>> getCropAdvisory(String season, String district) async {
    final url = Uri.parse("https://api.groq.com/openai/v1/chat/completions");

    // 💡 Prompt එක දියුණු කර ඇත: "Recommend diverse seasonal crops"
    final prompt = """
    Provide a highly specific agricultural advisory for $season in $district, Sri Lanka.
    Do NOT only recommend Rice. Suggest 3-4 DIFFERENT crops suitable for the $district climate.
    
    Return ONLY a raw JSON object with these EXACT keys:
    1. "crops": List of { "crop_name", "duration", "water", "profit", "tag", "image_path", "suited" }
    2. "calendar": List of { "month", "crops", "label", "image_path" }
    3. "market_prices": List of { "crop", "price", "demand", "demandType" }
    4. "expert_tips": List of { "title", "description", "type" }

    Important: Use only these image paths:
    - assets/images/rice.png, assets/images/vegetables.png, assets/images/maize.png, assets/images/cowpea.png
    - assets/images/tractor.png, assets/images/plant.png, assets/images/basket.png
    """;

    try {
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "model": "llama-3.3-70b-versatile",
          "messages": [{"role": "user", "content": prompt}],
          "response_format": {"type": "json_object"},
          "temperature": 0.7 // 💡 නිර්මාණශීලී පිළිතුරු ලබා ගැනීමට
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return jsonDecode(data['choices'][0]['message']['content']);
      }
      throw Exception("API Error: ${response.statusCode}");
    } catch (e) {
      developer.log("getCropAdvisory Error", error: e);
      rethrow;
    }
  }
}
