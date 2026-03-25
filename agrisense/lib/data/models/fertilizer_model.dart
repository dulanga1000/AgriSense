// lib/data/models/fertilizer_model.dart
class FertilizerModel {
  final String cropType;
  final String fertilizerName;
  final String npkRatio;
  final double totalQuantity;
  final double estimatedCost;
  final List<String> usageSteps;
  final String applicationTiming;

  const FertilizerModel({
    required this.cropType,
    required this.fertilizerName,
    required this.npkRatio,
    required this.totalQuantity,
    required this.estimatedCost,
    required this.usageSteps,
    required this.applicationTiming,
  });

  // JSON Map එකක් Model එකකට හරවන ආකාරය
  factory FertilizerModel.fromMap(Map<String, dynamic> map, String crop) {
    return FertilizerModel(
      cropType: crop,
      fertilizerName: map['fertilizerName'] ?? "AI Fertilizer",
      npkRatio: map['npkRatio'] ?? "N/A",
      totalQuantity: (map['totalQuantity'] as num?)?.toDouble() ?? 0,
      estimatedCost: (map['estimatedCost'] as num?)?.toDouble() ?? 0,
      usageSteps: List<String>.from(map['usageSteps'] ?? []),
      applicationTiming: map['applicationTiming'] ?? "Follow standard guidelines",
    );
  }
}