import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:agrisense/data/models/calendar_entry_model.dart';
import 'package:agrisense/data/models/crop_model.dart';
import 'package:agrisense/data/models/expert_tip_model.dart';
import 'package:agrisense/data/models/market_price_model.dart';

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
        msg.contains('deadline exceeded');
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
    final seasonLower = season.toLowerCase();
    final locationLower = location.toLowerCase();

    final isYala = seasonLower.contains('yala');
    final isMaha = seasonLower.contains('maha');

    // Categorize zones
    final isDryZone =
        locationLower.contains('anuradhapura') ||
        locationLower.contains('polonnaruwa') ||
        locationLower.contains('hambantota') ||
        locationLower.contains('monaragala') ||
        locationLower.contains('ampara');

    final isWetZone =
        locationLower.contains('colombo') ||
        locationLower.contains('galle') ||
        locationLower.contains('kalutara') ||
        locationLower.contains('matara') ||
        locationLower.contains('rathnapura');

    final isUpCountry =
        locationLower.contains('nuwara') ||
        locationLower.contains('kandy') ||
        locationLower.contains('matale') ||
        locationLower.contains('kegalle');

    List<Map<String, dynamic>> crops = [];

    if (isDryZone) {
      crops = [
        {
          'crop_name': isYala ? 'Rice (Yala Paddy)' : 'Rice (Maha Paddy)',
          'duration': isYala ? '3-4 months' : '4 months',
          'water': 'Medium',
          'profit': 'High',
          'tag': 'Prime Time',
          'icon_name': 'rice',
          'suited': 'Irrigated paddy fields in $location',
        },
        {
          'crop_name': 'Maize',
          'duration': '3 months',
          'water': 'Low',
          'profit': 'Medium',
          'tag': 'Good Time',
          'icon_name': 'maize',
          'suited': 'Well-drained upland areas',
        },
        {
          'crop_name': 'Cowpea (Lunu Dhal)',
          'duration': '2-3 months',
          'water': 'Low',
          'profit': 'High',
          'tag': 'Prime Time',
          'icon_name': 'leaf',
          'suited': 'Dry zone drought-tolerant cultivation',
        },
        {
          'crop_name': 'Groundnut',
          'duration': '3-4 months',
          'water': 'Low',
          'profit': 'High',
          'tag': 'Prime Time',
          'icon_name': 'leaf',
          'suited': 'Sandy and laterite soils',
        },
        {
          'crop_name': 'Green Gram (Mung)',
          'duration': '2-3 months',
          'water': 'Medium',
          'profit': 'Medium',
          'tag': 'Good Time',
          'icon_name': 'vegetable',
          'suited': 'Upland cultivation zones',
        },
        {
          'crop_name': 'Chili (Dried)',
          'duration': '3-4 months',
          'water': 'Medium',
          'profit': 'Very High',
          'tag': 'Prime Time',
          'icon_name': 'vegetable',
          'suited': 'High-value crop in dry areas',
        },
        {
          'crop_name': 'Sesame',
          'duration': '3 months',
          'water': 'Low',
          'profit': 'High',
          'tag': 'Prime Time',
          'icon_name': 'leaf',
          'suited': 'Light and well-drained soils',
        },
        {
          'crop_name': 'Watermelon',
          'duration': '2-3 months',
          'water': 'Medium',
          'profit': 'High',
          'tag': 'Good Time',
          'icon_name': 'vegetable',
          'suited': 'Sandy loam soils with irrigation',
        },
      ];
    } else if (isWetZone) {
      crops = [
        {
          'crop_name': 'Rice (Maha Paddy)',
          'duration': '4 months',
          'water': 'High',
          'profit': 'High',
          'tag': 'Prime Time',
          'icon_name': 'rice',
          'suited': 'Well-watered paddy fields',
        },
        {
          'crop_name': 'Brinjal (Eggplant)',
          'duration': '3-4 months',
          'water': 'High',
          'profit': 'Very High',
          'tag': 'Prime Time',
          'icon_name': 'vegetable',
          'suited': 'Intensive market garden zones',
        },
        {
          'crop_name': 'Tomato',
          'duration': '3 months',
          'water': 'High',
          'profit': 'Very High',
          'tag': 'Prime Time',
          'icon_name': 'vegetable',
          'suited': 'Commercial vegetable farming',
        },
        {
          'crop_name': 'Cucumber (Wattakka)',
          'duration': '2-3 months',
          'water': 'High',
          'profit': 'High',
          'tag': 'Good Time',
          'icon_name': 'vegetable',
          'suited': 'Trellised cultivation',
        },
        {
          'crop_name': 'Cabbage & Cauliflower',
          'duration': '3-4 months',
          'water': 'Medium',
          'profit': 'High',
          'tag': 'Good Time',
          'icon_name': 'vegetable',
          'suited': 'Cool season cultivation',
        },
        {
          'crop_name': 'Onion (Local)',
          'duration': '4-5 months',
          'water': 'Medium',
          'profit': 'High',
          'tag': 'Prime Time',
          'icon_name': 'vegetable',
          'suited': 'Market-oriented farming',
        },
        {
          'crop_name': 'Okra (Ladyfinger)',
          'duration': '2-3 months',
          'water': 'High',
          'profit': 'High',
          'tag': 'Good Time',
          'icon_name': 'vegetable',
          'suited': 'Year-round production',
        },
        {
          'crop_name': 'Beans (Green)',
          'duration': '2-3 months',
          'water': 'Medium',
          'profit': 'High',
          'tag': 'Prime Time',
          'icon_name': 'vegetable',
          'suited': 'High-value export potential',
        },
      ];
    } else if (isUpCountry) {
      crops = [
        {
          'crop_name': 'Tea',
          'duration': 'Perennial',
          'water': 'High',
          'profit': 'Very High',
          'tag': 'Prime Time',
          'icon_name': 'leaf',
          'suited': 'Traditional upland cultivation',
        },
        {
          'crop_name': 'Potato',
          'duration': '3 months',
          'water': 'Medium',
          'profit': 'High',
          'tag': 'Prime Time',
          'icon_name': 'vegetable',
          'suited': 'Cool highland soils above 1000m',
        },
        {
          'crop_name': 'Cabbage',
          'duration': '3-4 months',
          'water': 'Medium',
          'profit': 'High',
          'tag': 'Prime Time',
          'icon_name': 'vegetable',
          'suited': 'High altitude cool climate',
        },
        {
          'crop_name': 'Carrot',
          'duration': '3 months',
          'water': 'Medium',
          'profit': 'High',
          'tag': 'Good Time',
          'icon_name': 'vegetable',
          'suited': 'Well-drained upland soils',
        },
        {
          'crop_name': 'Beetroot',
          'duration': '2-3 months',
          'water': 'Medium',
          'profit': 'High',
          'tag': 'Good Time',
          'icon_name': 'vegetable',
          'suited': 'Cool season upland areas',
        },
        {
          'crop_name': 'Spices (Cardamom, Pepper)',
          'duration': 'Perennial',
          'water': 'High',
          'profit': 'Very High',
          'tag': 'Prime Time',
          'icon_name': 'leaf',
          'suited': 'Shade and moisture-rich slopes',
        },
        {
          'crop_name': 'Maize (Off-season)',
          'duration': '3 months',
          'water': 'Medium',
          'profit': 'Medium',
          'tag': 'Good Time',
          'icon_name': 'maize',
          'suited': 'Open highland areas',
        },
        {
          'crop_name': 'Cinnamon',
          'duration': 'Perennial',
          'water': 'High',
          'profit': 'Very High',
          'tag': 'Prime Time',
          'icon_name': 'leaf',
          'suited': 'Mid-elevation (500-1000m) plots',
        },
      ];
    } else {
      // General fallback for other zones
      crops = [
        {
          'crop_name': isYala ? 'Rice (Yala)' : 'Rice (Maha)',
          'duration': isYala ? '3-4 months' : '4 months',
          'water': 'High',
          'profit': 'High',
          'tag': 'Prime Time',
          'icon_name': 'rice',
          'suited': 'General paddy cultivation',
        },
        {
          'crop_name': 'Maize',
          'duration': '3 months',
          'water': 'Medium',
          'profit': 'Medium',
          'tag': 'Good Time',
          'icon_name': 'maize',
          'suited': 'Upland fields',
        },
        {
          'crop_name': 'Vegetables (Mixed)',
          'duration': '2-3 months',
          'water': 'High',
          'profit': 'High',
          'tag': 'Prime Time',
          'icon_name': 'vegetable',
          'suited': 'Garden cultivation',
        },
        {
          'crop_name': 'Green Gram',
          'duration': '2-3 months',
          'water': 'Medium',
          'profit': 'Medium',
          'tag': 'Good Time',
          'icon_name': 'leaf',
          'suited': 'Quick-maturing crop',
        },
        {
          'crop_name': 'Chili',
          'duration': '3-4 months',
          'water': 'Medium',
          'profit': 'High',
          'tag': 'Prime Time',
          'icon_name': 'vegetable',
          'suited': 'High-value crop',
        },
        {
          'crop_name': 'Sesame',
          'duration': '3 months',
          'water': 'Low',
          'profit': 'High',
          'tag': 'Prime Time',
          'icon_name': 'leaf',
          'suited': 'Dry season crop',
        },
        {
          'crop_name': 'Coconut',
          'duration': 'Perennial',
          'water': 'Medium',
          'profit': 'High',
          'tag': 'Prime Time',
          'icon_name': 'leaf',
          'suited': 'Year-round cultivation',
        },
        {
          'crop_name': 'Papaya',
          'duration': '8-10 months',
          'water': 'Medium',
          'profit': 'High',
          'tag': 'Prime Time',
          'icon_name': 'vegetable',
          'suited': 'Long-season fruit crop',
        },
      ];
    }

    final calendar = <Map<String, dynamic>>[
      if (isYala)
        {
          'month': 'Mar-Apr',
          'crops': 'Prepare fields, start Yala paddy and maize',
          'label': 'Planting',
          'icon_name': 'tractor',
        }
      else
        {
          'month': 'Sep-Oct',
          'crops': 'Land prep, plant Maha paddy and vegetables',
          'label': 'Planting',
          'icon_name': 'tractor',
        },
      if (isYala)
        {
          'month': 'May-Jun',
          'crops': 'Weeding, fertilizer, pest monitoring',
          'label': 'Field Care',
          'icon_name': 'leaf',
        }
      else
        {
          'month': 'Nov-Dec',
          'crops': 'Maintenance, nutrient top-dressing',
          'label': 'Field Care',
          'icon_name': 'leaf',
        },
      if (isYala)
        {
          'month': 'Jul-Aug',
          'crops': 'Harvest paddy and short-duration crops',
          'label': 'Harvesting',
          'icon_name': 'basket',
        }
      else
        {
          'month': 'Jan-Feb',
          'crops': 'Main harvest season - collect paddy and vegetables',
          'label': 'Harvesting',
          'icon_name': 'basket',
        },
    ];

    final prices = <Map<String, dynamic>>[
      if (isDryZone) ...[
        {
          'crop': 'Rice',
          'price': isYala ? 'Rs. 220-270/kg' : 'Rs. 200-250/kg',
          'demand': isYala ? '↑ High Demand' : '→ Medium Demand',
          'demand_type': isYala ? 'high' : 'medium',
        },
        {
          'crop': 'Cowpea',
          'price': 'Rs. 260-340/kg',
          'demand': '↑ High Demand',
          'demand_type': 'high',
        },
        {
          'crop': 'Groundnut',
          'price': 'Rs. 240-330/kg',
          'demand': '↑ High Demand',
          'demand_type': 'high',
        },
      ] else if (isUpCountry) ...[
        {
          'crop': 'Potato',
          'price': 'Rs. 210-300/kg',
          'demand': '↑ High Demand',
          'demand_type': 'high',
        },
        {
          'crop': 'Carrot',
          'price': 'Rs. 180-260/kg',
          'demand': '→ Medium Demand',
          'demand_type': 'medium',
        },
        {
          'crop': 'Cabbage',
          'price': 'Rs. 140-220/kg',
          'demand': '→ Medium Demand',
          'demand_type': 'medium',
        },
      ] else ...[
        {
          'crop': 'Rice',
          'price': isMaha ? 'Rs. 190-240/kg' : 'Rs. 210-260/kg',
          'demand': isMaha ? '→ Medium Demand' : '↑ High Demand',
          'demand_type': isMaha ? 'medium' : 'high',
        },
        {
          'crop': 'Tomato',
          'price': 'Rs. 190-320/kg',
          'demand': '↑ High Demand',
          'demand_type': 'high',
        },
        {
          'crop': 'Beans',
          'price': 'Rs. 220-360/kg',
          'demand': '↑ High Demand',
          'demand_type': 'high',
        },
      ],
    ];

    final tips = <Map<String, dynamic>>[
      {
        'title': isDryZone
            ? 'Water Saving for $location'
            : 'Moisture Management for $location',
        'description': isDryZone
            ? 'Use drip or interval irrigation and mulch during ${isYala ? 'Yala' : 'Maha'} to reduce evaporation.'
            : 'Check field moisture before irrigation and avoid overwatering in low-lying fields.',
        'type': 'water',
      },
      {
        'title': isYala
            ? 'Yala Nutrient Split Plan'
            : 'Maha Nutrient Base Plan',
        'description': isYala
            ? 'Split nitrogen into 2-3 doses for short-duration crops and apply potassium before flowering.'
            : 'Apply basal compost and phosphorus before planting, then top-dress nitrogen after establishment.',
        'type': 'soil',
      },
      {
        'title': isUpCountry
            ? 'Cool-Climate Disease Watch'
            : 'Pest Monitoring Routine',
        'description': isUpCountry
            ? 'Monitor for late blight and leaf spot in cool mornings, especially in potato and cabbage blocks.'
            : 'Scout fields twice weekly and act early on leaf damage, borers, and sucking pests.',
        'type': 'pest',
      },
      {
        'title': 'Market Timing for $season',
        'description': isYala
            ? 'Target early harvest windows to capture higher prices before peak market supply.'
            : 'Stagger planting dates to avoid market gluts during main harvest months.',
        'type': 'soil',
      },
    ];

    return {
      'crops': crops,
      'calendar': calendar,
      'prices': prices,
      'tips': tips,
    };
  }

  // =======================================================================
  // PUBLIC METHODS
  // =======================================================================

  Future<List<CropModel>> getRecommendedCrops(
    String location,
    String season,
  ) async {
    await _ensureDataLoaded(location, season);
    final List<dynamic> data = _aiCache!['crops'] ?? [];
    return data.map((json) => CropModel.fromJson(json)).toList();
  }

  Future<List<CalendarEntryModel>> getCalendarEntries(
    String location,
    String season,
  ) async {
    await _ensureDataLoaded(location, season);
    final List<dynamic> data = _aiCache!['calendar'] ?? [];
    // Note: Ensure your CalendarEntryModel has a fromJson method!
    return data.map((json) => CalendarEntryModel.fromJson(json)).toList();
  }

  Future<List<MarketPriceModel>> getMarketPrices(
    String location,
    String season,
  ) async {
    await _ensureDataLoaded(location, season);
    final List<dynamic> data = _aiCache!['prices'] ?? [];
    return data.map((json) => MarketPriceModel.fromJson(json)).toList();
  }

  Future<List<ExpertTipModel>> getExpertTips(
    String location,
    String season,
  ) async {
    await _ensureDataLoaded(location, season);
    final List<dynamic> data = _aiCache!['tips'] ?? [];
    return data.map((json) => ExpertTipModel.fromJson(json)).toList();
  }
}
