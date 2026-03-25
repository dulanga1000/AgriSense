import 'dart:async';
import 'package:agrisense/data/models/farming_tip_model.dart';

class FarmingTipRepository {
  
  Future<List<FarmingTip>> getTips() async {
    
    await Future.delayed(const Duration(milliseconds: 800));

    
    return const [
      FarmingTip(
        id: 1,
        description: "Water crops early morning to reduce evaporation.",
        type: "sun",
      ),
      FarmingTip(
        id: 2,
        description: "Use compost to improve soil fertility.",
        type: "plant",
      ),
      FarmingTip(
        id: 3,
        description: "Check rain forecast before irrigation.",
        type: "rain",
      ),
      FarmingTip(
        id: 4,
        description: "Watch for pests in humid conditions.",
        type: "warning",
      ),
    ];
  }
}
