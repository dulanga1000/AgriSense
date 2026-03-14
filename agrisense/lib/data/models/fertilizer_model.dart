class FertilizerModel {
  final String cropType;
  final String fertilizerName;
  final String npkRatio;
  final double totalQuantity; // in kg
  final double estimatedCost; // in LKR

  FertilizerModel({
    required this.cropType,
    required this.fertilizerName,
    required this.npkRatio,
    required this.totalQuantity,
    required this.estimatedCost,
  });
}