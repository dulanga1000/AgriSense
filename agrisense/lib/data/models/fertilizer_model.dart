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

  factory FertilizerModel.fromJson(Map<String, dynamic> json) {
    return FertilizerModel(
      cropType: json['crop_type'],
      fertilizerName: json['fertilizer_name'],
      npkRatio: json['npk_ratio'],
      totalQuantity: json['total_quantity'].toDouble(),
      estimatedCost: json['estimated_cost'].toDouble(),
      usageSteps: List<String>.from(json['usage_steps']),
      applicationTiming: json['application_timing'],
    );
  }
}
