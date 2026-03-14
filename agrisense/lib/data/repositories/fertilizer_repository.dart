import '../models/fertilizer_model.dart';

class FertilizerRepository {
  FertilizerModel getRecommendation(String cropType, double landSize) {
    // Dummy logic — replace with API call if needed
    String fertilizerName = "Balanced Fertilizer Mix";
    String npkRatio = "15:15:15";
    double totalQuantity = landSize * 90;
    double estimatedCost = totalQuantity * 80; // example LKR per kg

    if (cropType == "Rice") {
      fertilizerName = "NPK Complex Fertilizer + Urea";
      npkRatio = "20:10:10";
      totalQuantity = landSize * 120;
      estimatedCost = totalQuantity * 85;
    } else if (cropType == "Corn") {
      fertilizerName = "Urea + Potassium Mix";
      npkRatio = "18:12:8";
      totalQuantity = landSize * 100;
      estimatedCost = totalQuantity * 75;
    }

    return FertilizerModel(
      cropType: cropType,
      fertilizerName: fertilizerName,
      npkRatio: npkRatio,
      totalQuantity: totalQuantity,
      estimatedCost: estimatedCost,
    );
  }
}