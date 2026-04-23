import 'package:agrisense/data/models/calendar_entry_model.dart';
import 'package:agrisense/data/models/crop_model.dart';
import 'package:agrisense/data/models/expert_tip_model.dart';
import 'package:agrisense/data/models/market_price_model.dart';

class CropAdvisoryRepository {
  Future<List<CropModel>> getRecommendedCrops() async {
    return const [
      CropModel(
        cropName: 'Rice (Paddy)',
        duration: '3-4 months',
        water: 'High',
        profit: 'High',
        tag: 'Prime Time',
        imagePath: 'assets/images/rice.png',
        suited: 'Western, Central, North Central Province',
      ),
      CropModel(
        cropName: 'Vegetables',
        duration: '2-3 months',
        water: 'Medium',
        profit: 'Very High',
        tag: 'Prime Time',
        imagePath: 'assets/images/vegetables.png',
        suited: 'Uva, Central, Sabaragamuwa Province',
      ),
      CropModel(
        cropName: 'Maize (Corn)',
        duration: '3 months',
        water: 'Medium',
        profit: 'Medium',
        tag: 'Good Time',
        imagePath: 'assets/images/maize.png',
        suited: 'North Central, Eastern, Northern Province',
      ),
      CropModel(
        cropName: 'Cowpea (Me)',
        duration: '2-3 months',
        water: 'Low',
        profit: 'Medium',
        tag: 'Good Time',
        imagePath: 'assets/images/cowpea.png',
        suited: 'Dry Zone Areas',
      ),
    ];
  }

  Future<List<CalendarEntryModel>> getCalendarEntries() async {
    return const [
      CalendarEntryModel(
        month: 'February',
        crops: 'Rice (Yala)',
        label: 'Land Preparation',
        imagePath: 'assets/images/tractor.png',
      ),
      CalendarEntryModel(
        month: 'March-April',
        crops: 'Rice, Vegetables, Maize',
        label: 'Planting',
        imagePath: 'assets/images/plant.png',
      ),
      CalendarEntryModel(
        month: 'June-July',
        crops: 'Vegetables, Cowpea',
        label: 'Harvesting',
        imagePath: 'assets/images/basket.png',
      ),
      CalendarEntryModel(
        month: 'July-August',
        crops: 'Rice (Yala Season)',
        label: 'Harvesting',
        imagePath: 'assets/images/rice.png',
      ),
    ];
  }

  Future<List<MarketPriceModel>> getMarketPrices() async {
    return const [
      MarketPriceModel(
        crop: 'Tomato',
        price: 'Rs. 150-200/kg',
        demand: '↑ High Demand',
        demandType: 'high',
      ),
      MarketPriceModel(
        crop: 'Cabbage',
        price: 'Rs. 80-120/kg',
        demand: '→ Medium Demand',
        demandType: 'medium',
      ),
      MarketPriceModel(
        crop: 'Green Chili',
        price: 'Rs. 300-400/kg',
        demand: '↑ Very High Demand',
        demandType: 'very_high',
      ),
    ];
  }

  Future<List<ExpertTipModel>> getExpertTips() async {
    return const [
      ExpertTipModel(
        title: 'Water Management',
        description:
            'Monitor rainfall patterns and adjust irrigation schedules accordingly',
        type: 'water',
      ),
      ExpertTipModel(
        title: 'Soil Preparation',
        description: 'Test soil pH and add organic matter before planting',
        type: 'soil',
      ),
      ExpertTipModel(
        title: 'Pest Control',
        description:
            'Regular monitoring helps prevent major outbreaks during this season',
        type: 'pest',
      ),
    ];
  }
}
