/// Sri Lankan crop fallback data by zone and season.
/// Used when Gemini API is unavailable.
class CropFallbackData {
  static String getZone(String district) {
    final d = district.toLowerCase();
    if (['anuradhapura', 'polonnaruwa', 'hambantota', 'monaragala', 'ampara',
         'mannar', 'vavuniya', 'mullaitivu', 'kilinochchi'].any((z) => d.contains(z))) {
      return 'dry';
    }
    if (['colombo', 'gampaha', 'kalutara', 'galle', 'matara',
         'ratnapura', 'kegalle'].any((z) => d.contains(z))) {
      return 'wet';
    }
    if (['kandy', 'matale', 'nuwara', 'badulla'].any((z) => d.contains(z))) {
      return 'up';
    }
    if (['kurunegala', 'puttalam'].any((z) => d.contains(z))) {
      return 'coconut';
    }
    if (d.contains('jaffna')) {
      return 'north';
    }
    if (['batticaloa', 'trincomalee'].any((z) => d.contains(z))) {
      return 'east';
    }
    return 'dry';
  }

  static List<Map<String, dynamic>> getCrops(String zone, bool isYala, String location) {
    switch (zone) {
      case 'dry':
        return isYala ? [
          _c('Sesame', '3 months', 'Low', 'High', 'Prime Time', 'leaf', 'Light well-drained soils in $location'),
          _c('Groundnut', '3-4 months', 'Low', 'High', 'Prime Time', 'leaf', 'Sandy laterite soils'),
          _c('Cowpea', '2-3 months', 'Low', 'High', 'Prime Time', 'leaf', 'Drought-tolerant dry zone crop'),
          _c('Chili (Dried)', '3-4 months', 'Medium', 'Very High', 'Prime Time', 'vegetable', 'High-value crop in $location'),
          _c('Green Gram', '2-3 months', 'Low', 'Medium', 'Good Time', 'vegetable', 'Quick-maturing pulse crop'),
          _c('Maize', '3 months', 'Low', 'Medium', 'Good Time', 'maize', 'Upland rainfed areas'),
          _c('Watermelon', '2-3 months', 'Medium', 'High', 'Good Time', 'vegetable', 'Sandy loam with irrigation'),
          _c('Finger Millet', '3-4 months', 'Low', 'Medium', 'Good Time', 'rice', 'Traditional highland crop'),
        ] : [
          _c('Rice (Maha Paddy)', '4 months', 'High', 'High', 'Prime Time', 'rice', 'Irrigated paddy fields in $location'),
          _c('Big Onion', '4-5 months', 'Medium', 'Very High', 'Prime Time', 'vegetable', 'Major cultivation in dry zone'),
          _c('Soya Bean', '3 months', 'Medium', 'High', 'Prime Time', 'leaf', 'Well-drained loamy soils'),
          _c('Black Gram', '2-3 months', 'Low', 'High', 'Prime Time', 'leaf', 'Post-paddy rotation crop'),
          _c('Sweet Potato', '3-4 months', 'Low', 'Medium', 'Good Time', 'vegetable', 'Sandy loam soils'),
          _c('Mustard', '2-3 months', 'Low', 'Medium', 'Good Time', 'leaf', 'Short-duration oilseed crop'),
          _c('Long Bean', '2-3 months', 'Medium', 'High', 'Good Time', 'vegetable', 'Trellised vegetable farming'),
          _c('Pumpkin', '3-4 months', 'Medium', 'Medium', 'Good Time', 'vegetable', 'Low maintenance field crop'),
        ];
      case 'wet':
        return isYala ? [
          _c('Cinnamon', 'Perennial', 'Medium', 'Very High', 'Prime Time', 'leaf', 'Traditional wet zone crop in $location'),
          _c('Brinjal', '3-4 months', 'High', 'Very High', 'Prime Time', 'vegetable', 'Market garden cultivation'),
          _c('Tomato', '3 months', 'High', 'Very High', 'Prime Time', 'vegetable', 'Commercial vegetable farming'),
          _c('Okra', '2-3 months', 'High', 'High', 'Good Time', 'vegetable', 'Year-round production'),
          _c('Bitter Gourd', '2-3 months', 'High', 'High', 'Good Time', 'vegetable', 'Trellised home garden crop'),
          _c('Snake Gourd', '2-3 months', 'High', 'Medium', 'Good Time', 'vegetable', 'Wet zone vegetable'),
          _c('Pumpkin', '3-4 months', 'Medium', 'Medium', 'Good Time', 'vegetable', 'Low maintenance cultivation'),
          _c('Rubber', 'Perennial', 'High', 'High', 'Prime Time', 'leaf', 'Tapping season in $location'),
        ] : [
          _c('Rice (Maha Paddy)', '4 months', 'High', 'High', 'Prime Time', 'rice', 'Main paddy season in $location'),
          _c('Tea', 'Perennial', 'High', 'Very High', 'Prime Time', 'leaf', 'Peak flush season'),
          _c('Ginger', '8-10 months', 'High', 'Very High', 'Prime Time', 'vegetable', 'Spice crop in moist soils'),
          _c('Turmeric', '8-9 months', 'High', 'High', 'Prime Time', 'vegetable', 'Shade-tolerant spice crop'),
          _c('Banana', '10-12 months', 'High', 'High', 'Prime Time', 'vegetable', 'Year-round fruit crop'),
          _c('Lemongrass', 'Perennial', 'Medium', 'Medium', 'Good Time', 'leaf', 'Essential oil crop'),
          _c('Clove', 'Perennial', 'High', 'Very High', 'Prime Time', 'leaf', 'High-value export spice'),
          _c('Nutmeg', 'Perennial', 'High', 'Very High', 'Prime Time', 'leaf', 'Premium spice tree crop'),
        ];
      case 'up':
        return isYala ? [
          _c('Potato (Off-season)', '3 months', 'Medium', 'High', 'Prime Time', 'vegetable', 'Cool highland soils in $location'),
          _c('Leeks', '3-4 months', 'Medium', 'High', 'Prime Time', 'vegetable', 'High-altitude vegetable'),
          _c('Beans (Green)', '2-3 months', 'Medium', 'High', 'Prime Time', 'vegetable', 'Export-quality production'),
          _c('Capsicum', '3-4 months', 'Medium', 'Very High', 'Prime Time', 'vegetable', 'Greenhouse and open field'),
          _c('Strawberry', '4-5 months', 'Medium', 'Very High', 'Prime Time', 'vegetable', 'Premium fruit above 1500m'),
          _c('Lettuce', '2 months', 'Medium', 'High', 'Good Time', 'leaf', 'Quick-growing salad crop'),
          _c('Beetroot', '2-3 months', 'Medium', 'High', 'Good Time', 'vegetable', 'Cool season root crop'),
          _c('Carrot', '3 months', 'Medium', 'High', 'Good Time', 'vegetable', 'Well-drained upland soils'),
        ] : [
          _c('Potato (Main)', '3 months', 'Medium', 'High', 'Prime Time', 'vegetable', 'Main season in $location'),
          _c('Cabbage', '3-4 months', 'Medium', 'High', 'Prime Time', 'vegetable', 'High altitude cool climate'),
          _c('Cauliflower', '3-4 months', 'Medium', 'High', 'Prime Time', 'vegetable', 'Cool weather vegetable'),
          _c('Radish', '1-2 months', 'Medium', 'Medium', 'Good Time', 'vegetable', 'Quick-maturing root crop'),
          _c('Knol-khol', '2-3 months', 'Medium', 'Medium', 'Good Time', 'vegetable', 'Cool climate specialty'),
          _c('Garlic', '4-5 months', 'Low', 'Very High', 'Prime Time', 'vegetable', 'High-value spice crop'),
          _c('Celery', '3-4 months', 'Medium', 'High', 'Good Time', 'leaf', 'Specialty highland crop'),
          _c('Spring Onion', '2-3 months', 'Medium', 'High', 'Good Time', 'vegetable', 'Year-round demand'),
        ];
      case 'coconut':
        return isYala ? [
          _c('Coconut', 'Perennial', 'Medium', 'High', 'Prime Time', 'leaf', 'Primary crop in $location'),
          _c('Cashew', 'Perennial', 'Low', 'Very High', 'Prime Time', 'leaf', 'Export crop in dry areas'),
          _c('Pineapple', '14-18 months', 'Low', 'High', 'Prime Time', 'vegetable', 'Well-drained laterite soils'),
          _c('Banana', '10-12 months', 'Medium', 'High', 'Prime Time', 'vegetable', 'Commercial fruit crop'),
          _c('Papaya', '8-10 months', 'Medium', 'High', 'Good Time', 'vegetable', 'Quick fruiting tree'),
          _c('Black Pepper', 'Perennial', 'Medium', 'Very High', 'Prime Time', 'leaf', 'Grown on coconut trunks'),
          _c('Cinnamon', 'Perennial', 'Medium', 'Very High', 'Prime Time', 'leaf', 'Major export spice'),
          _c('Maize', '3 months', 'Low', 'Medium', 'Good Time', 'maize', 'Intercrop with coconut'),
        ] : [
          _c('Rice', '4 months', 'High', 'High', 'Prime Time', 'rice', 'Maha paddy in $location'),
          _c('Finger Millet', '3-4 months', 'Low', 'Medium', 'Good Time', 'rice', 'Traditional highland crop'),
          _c('Gingelly', '3 months', 'Low', 'High', 'Prime Time', 'leaf', 'Oilseed crop'),
          _c('Sweet Potato', '3-4 months', 'Low', 'Medium', 'Good Time', 'vegetable', 'Sandy loam soils'),
          _c('Cassava', '8-12 months', 'Low', 'Medium', 'Good Time', 'vegetable', 'Drought-tolerant tuber'),
          _c('Cowpea', '2-3 months', 'Low', 'High', 'Prime Time', 'leaf', 'Short-duration pulse'),
          _c('Groundnut', '3-4 months', 'Low', 'High', 'Prime Time', 'leaf', 'Sandy soil cultivation'),
          _c('Vegetables (Mixed)', '2-3 months', 'Medium', 'High', 'Good Time', 'vegetable', 'Market garden crops'),
        ];
      case 'north':
        return isYala ? [
          _c('Red Onion', '3-4 months', 'Low', 'Very High', 'Prime Time', 'vegetable', 'Famous Jaffna crop'),
          _c('Chili', '3-4 months', 'Medium', 'Very High', 'Prime Time', 'vegetable', 'Major cash crop in $location'),
          _c('Tobacco', '4-5 months', 'Low', 'High', 'Prime Time', 'leaf', 'Traditional Jaffna cultivation'),
          _c('Grapes', 'Perennial', 'Low', 'Very High', 'Prime Time', 'vegetable', 'Unique to Jaffna peninsula'),
          _c('Palmyra', 'Perennial', 'Low', 'High', 'Prime Time', 'leaf', 'Iconic northern tree crop'),
          _c('Groundnut', '3-4 months', 'Low', 'High', 'Good Time', 'leaf', 'Sandy coastal soils'),
          _c('Brinjal', '3-4 months', 'Medium', 'High', 'Good Time', 'vegetable', 'Year-round vegetable'),
          _c('Bitter Gourd', '2-3 months', 'Medium', 'High', 'Good Time', 'vegetable', 'Trellised cultivation'),
        ] : [
          _c('Rice', '4 months', 'High', 'High', 'Prime Time', 'rice', 'Maha paddy in $location'),
          _c('Potato', '3 months', 'Medium', 'High', 'Prime Time', 'vegetable', 'Cool season crop'),
          _c('Big Onion', '4-5 months', 'Medium', 'Very High', 'Prime Time', 'vegetable', 'Export quality onion'),
          _c('Green Gram', '2-3 months', 'Low', 'Medium', 'Good Time', 'leaf', 'Pulse crop rotation'),
          _c('Black Gram', '2-3 months', 'Low', 'High', 'Good Time', 'leaf', 'Post-paddy crop'),
          _c('Tomato', '3 months', 'Medium', 'High', 'Prime Time', 'vegetable', 'Commercial vegetable'),
          _c('Drumstick', 'Perennial', 'Low', 'High', 'Prime Time', 'leaf', 'Northern specialty tree'),
          _c('Okra', '2-3 months', 'Medium', 'High', 'Good Time', 'vegetable', 'Popular market vegetable'),
        ];
      case 'east':
        return isYala ? [
          _c('Rice (Yala Paddy)', '3-4 months', 'Medium', 'High', 'Prime Time', 'rice', 'Irrigated fields in $location'),
          _c('Maize', '3 months', 'Low', 'Medium', 'Good Time', 'maize', 'Upland rainfed crop'),
          _c('Cowpea', '2-3 months', 'Low', 'High', 'Prime Time', 'leaf', 'Drought-tolerant pulse'),
          _c('Groundnut', '3-4 months', 'Low', 'High', 'Prime Time', 'leaf', 'Sandy coastal soils'),
          _c('Chili', '3-4 months', 'Medium', 'Very High', 'Prime Time', 'vegetable', 'High-value spice crop'),
          _c('Long Bean', '2-3 months', 'Medium', 'High', 'Good Time', 'vegetable', 'Trellised vegetable'),
          _c('Brinjal', '3-4 months', 'Medium', 'High', 'Good Time', 'vegetable', 'Market garden crop'),
          _c('Watermelon', '2-3 months', 'Medium', 'High', 'Good Time', 'vegetable', 'Sandy loam soils'),
        ] : [
          _c('Rice (Maha Paddy)', '4 months', 'High', 'High', 'Prime Time', 'rice', 'Main season in $location'),
          _c('Green Gram', '2-3 months', 'Low', 'Medium', 'Good Time', 'leaf', 'Post-paddy pulse crop'),
          _c('Black Gram', '2-3 months', 'Low', 'High', 'Prime Time', 'leaf', 'Maha season pulse'),
          _c('Soya Bean', '3 months', 'Medium', 'High', 'Prime Time', 'leaf', 'Protein-rich oilseed'),
          _c('Onion', '4-5 months', 'Medium', 'Very High', 'Prime Time', 'vegetable', 'High-value vegetable'),
          _c('Banana', '10-12 months', 'Medium', 'High', 'Good Time', 'vegetable', 'Year-round fruit'),
          _c('Sugarcane', '12-14 months', 'High', 'Medium', 'Good Time', 'leaf', 'Eastern zone specialty'),
          _c('Vegetables (Mixed)', '2-3 months', 'Medium', 'High', 'Good Time', 'vegetable', 'Market garden crops'),
        ];
      default:
        return isYala ? [
          _c('Rice (Yala)', '3-4 months', 'Medium', 'High', 'Prime Time', 'rice', 'General paddy in $location'),
          _c('Maize', '3 months', 'Low', 'Medium', 'Good Time', 'maize', 'Upland fields'),
          _c('Chili', '3-4 months', 'Medium', 'High', 'Prime Time', 'vegetable', 'High-value crop'),
          _c('Cowpea', '2-3 months', 'Low', 'High', 'Prime Time', 'leaf', 'Drought-tolerant pulse'),
          _c('Groundnut', '3-4 months', 'Low', 'High', 'Good Time', 'leaf', 'Sandy soils'),
          _c('Sesame', '3 months', 'Low', 'High', 'Prime Time', 'leaf', 'Dry season oilseed'),
        ] : [
          _c('Rice (Maha)', '4 months', 'High', 'High', 'Prime Time', 'rice', 'Main paddy in $location'),
          _c('Green Gram', '2-3 months', 'Low', 'Medium', 'Good Time', 'leaf', 'Pulse crop'),
          _c('Black Gram', '2-3 months', 'Low', 'High', 'Good Time', 'leaf', 'Post-paddy rotation'),
          _c('Vegetables (Mixed)', '2-3 months', 'High', 'High', 'Prime Time', 'vegetable', 'Garden cultivation'),
          _c('Coconut', 'Perennial', 'Medium', 'High', 'Prime Time', 'leaf', 'Year-round'),
          _c('Banana', '10-12 months', 'Medium', 'High', 'Good Time', 'vegetable', 'Fruit crop'),
        ];
    }
  }

  static List<Map<String, dynamic>> getCalendar(String zone, bool isYala) {
    if (isYala) {
      return [
        {'month': 'Mar-Apr', 'crops': 'Land preparation, start Yala planting', 'label': 'Planting', 'icon_name': 'tractor'},
        {'month': 'May-Jun', 'crops': 'Weeding, fertilizer, pest monitoring', 'label': 'Field Care', 'icon_name': 'leaf'},
        {'month': 'Jul-Sep', 'crops': 'Harvest Yala crops, prepare for Maha', 'label': 'Harvesting', 'icon_name': 'basket'},
      ];
    } else {
      return [
        {'month': 'Sep-Oct', 'crops': 'Land prep, plant Maha season crops', 'label': 'Planting', 'icon_name': 'tractor'},
        {'month': 'Nov-Dec', 'crops': 'Maintenance, nutrient top-dressing', 'label': 'Field Care', 'icon_name': 'leaf'},
        {'month': 'Jan-Mar', 'crops': 'Main harvest, post-harvest processing', 'label': 'Harvesting', 'icon_name': 'basket'},
      ];
    }
  }

  static List<Map<String, dynamic>> getPrices(String zone, bool isYala) {
    switch (zone) {
      case 'dry':
        return isYala ? [
          _p('Sesame', 'Rs. 650-850/kg', '↑ High Demand', 'high'),
          _p('Groundnut', 'Rs. 240-330/kg', '↑ High Demand', 'high'),
          _p('Chili (Dried)', 'Rs. 1200-1800/kg', '↑ High Demand', 'high'),
        ] : [
          _p('Rice', 'Rs. 200-250/kg', '→ Medium Demand', 'medium'),
          _p('Big Onion', 'Rs. 180-350/kg', '↑ High Demand', 'high'),
          _p('Soya Bean', 'Rs. 280-380/kg', '↑ High Demand', 'high'),
        ];
      case 'wet':
        return isYala ? [
          _p('Cinnamon', 'Rs. 2500-3500/kg', '↑ High Demand', 'high'),
          _p('Brinjal', 'Rs. 120-220/kg', '→ Medium Demand', 'medium'),
          _p('Tomato', 'Rs. 190-320/kg', '↑ High Demand', 'high'),
        ] : [
          _p('Rice', 'Rs. 190-240/kg', '→ Medium Demand', 'medium'),
          _p('Ginger', 'Rs. 450-700/kg', '↑ High Demand', 'high'),
          _p('Tea', 'Rs. 120-180/kg', '→ Medium Demand', 'medium'),
        ];
      case 'up':
        return isYala ? [
          _p('Potato', 'Rs. 210-300/kg', '↑ High Demand', 'high'),
          _p('Leeks', 'Rs. 200-320/kg', '↑ High Demand', 'high'),
          _p('Strawberry', 'Rs. 800-1500/kg', '↑ High Demand', 'high'),
        ] : [
          _p('Potato', 'Rs. 180-260/kg', '→ Medium Demand', 'medium'),
          _p('Cabbage', 'Rs. 140-220/kg', '→ Medium Demand', 'medium'),
          _p('Carrot', 'Rs. 180-260/kg', '→ Medium Demand', 'medium'),
        ];
      case 'coconut':
        return isYala ? [
          _p('Coconut', 'Rs. 80-120/nut', '↑ High Demand', 'high'),
          _p('Cashew', 'Rs. 1800-2500/kg', '↑ High Demand', 'high'),
          _p('Pineapple', 'Rs. 150-250/kg', '→ Medium Demand', 'medium'),
        ] : [
          _p('Rice', 'Rs. 200-250/kg', '→ Medium Demand', 'medium'),
          _p('Coconut', 'Rs. 70-100/nut', '→ Medium Demand', 'medium'),
          _p('Groundnut', 'Rs. 240-330/kg', '↑ High Demand', 'high'),
        ];
      case 'north':
        return isYala ? [
          _p('Red Onion', 'Rs. 250-450/kg', '↑ High Demand', 'high'),
          _p('Chili', 'Rs. 350-550/kg', '↑ High Demand', 'high'),
          _p('Grapes', 'Rs. 600-1000/kg', '↑ High Demand', 'high'),
        ] : [
          _p('Rice', 'Rs. 200-250/kg', '→ Medium Demand', 'medium'),
          _p('Big Onion', 'Rs. 180-350/kg', '↑ High Demand', 'high'),
          _p('Potato', 'Rs. 210-300/kg', '↑ High Demand', 'high'),
        ];
      case 'east':
        return isYala ? [
          _p('Rice', 'Rs. 220-270/kg', '↑ High Demand', 'high'),
          _p('Chili', 'Rs. 350-550/kg', '↑ High Demand', 'high'),
          _p('Cowpea', 'Rs. 260-340/kg', '→ Medium Demand', 'medium'),
        ] : [
          _p('Rice', 'Rs. 190-240/kg', '→ Medium Demand', 'medium'),
          _p('Onion', 'Rs. 180-350/kg', '↑ High Demand', 'high'),
          _p('Banana', 'Rs. 100-180/kg', '→ Medium Demand', 'medium'),
        ];
      default:
        return [
          _p('Rice', isYala ? 'Rs. 220-270/kg' : 'Rs. 190-240/kg', isYala ? '↑ High Demand' : '→ Medium Demand', isYala ? 'high' : 'medium'),
          _p('Vegetables', 'Rs. 150-300/kg', '↑ High Demand', 'high'),
          _p('Coconut', 'Rs. 70-120/nut', '→ Medium Demand', 'medium'),
        ];
    }
  }

  static List<Map<String, dynamic>> getTips(String zone, bool isYala, String location, String season) {
    return [
      {
        'title': zone == 'dry' ? 'Water Saving for $location' : zone == 'up' ? 'Cool-Climate Care in $location' : 'Moisture Management in $location',
        'description': zone == 'dry'
            ? 'Use drip or interval irrigation and mulch during ${isYala ? "Yala" : "Maha"} to reduce evaporation.'
            : zone == 'up'
                ? 'Monitor for late blight in cool mornings, especially in potato and cabbage blocks.'
                : 'Check field moisture before irrigation and avoid overwatering in low-lying fields.',
        'type': 'water',
      },
      {
        'title': isYala ? 'Yala Nutrient Split Plan' : 'Maha Nutrient Base Plan',
        'description': isYala
            ? 'Split nitrogen into 2-3 doses for short-duration crops and apply potassium before flowering.'
            : 'Apply basal compost and phosphorus before planting, then top-dress nitrogen after establishment.',
        'type': 'soil',
      },
      {
        'title': 'Pest Monitoring for $season',
        'description': isYala
            ? 'Scout fields twice weekly during dry spells. Watch for thrips, mites, and stem borers.'
            : 'Monitor for fungal diseases during wet weather. Apply preventive fungicides early.',
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
  }

  // Helper to create crop map
  static Map<String, dynamic> _c(String name, String dur, String water, String profit, String tag, String icon, String suited) {
    return {'crop_name': name, 'duration': dur, 'water': water, 'profit': profit, 'tag': tag, 'icon_name': icon, 'suited': suited};
  }

  // Helper to create price map
  static Map<String, dynamic> _p(String crop, String price, String demand, String demandType) {
    return {'crop': crop, 'price': price, 'demand': demand, 'demand_type': demandType};
  }
}
