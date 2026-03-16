import 'package:agrisense/data/models/fertilizer_model.dart';

class FertilizerRepository {
  Future<FertilizerModel> getRecommendation(
    String cropType,
    double landSize,
  ) async {
    return _getDummyRecommendation(cropType, landSize);
  }

  FertilizerModel _getDummyRecommendation(String cropType, double landSize) {
    switch (cropType) {
      case "Rice":
        return FertilizerModel(
          cropType: cropType,
          fertilizerName: "NPK Complex Fertilizer + Urea",
          npkRatio: "20:10:10",
          totalQuantity: landSize * 120,
          estimatedCost: landSize * 120 * 85,
          usageSteps: const [
            "Apply 40% as basal dose during land preparation",
            "Apply 30% at tillering stage (20–25 days after planting)",
            "Apply 30% at panicle initiation stage (40–45 days)",
            "Mix thoroughly with soil and irrigate immediately",
          ],
          applicationTiming: "Split application in 3 stages",
        );
      case "Corn":
        return FertilizerModel(
          cropType: cropType,
          fertilizerName: "Urea + Potassium Mix",
          npkRatio: "18:12:8",
          totalQuantity: landSize * 100,
          estimatedCost: landSize * 100 * 75,
          usageSteps: const [
            "Apply 50% as basal dose before planting",
            "Apply 25% at knee-high stage (30 days after planting)",
            "Apply 25% at tasseling stage (50–55 days)",
            "Ensure adequate moisture after each application",
          ],
          applicationTiming: "Split application in 3 stages",
        );
      default:
        return FertilizerModel(
          cropType: cropType,
          fertilizerName: "Balanced Fertilizer Mix",
          npkRatio: "15:15:15",
          totalQuantity: landSize * 90,
          estimatedCost: landSize * 90 * 80,
          usageSteps: const [
            "Apply 40% as basal dose during land preparation",
            "Apply 30% at early growth stage",
            "Apply 30% at flowering stage",
            "Mix thoroughly with soil and irrigate immediately",
          ],
          applicationTiming: "Split application in 3 stages",
        );
    }
  }
}
