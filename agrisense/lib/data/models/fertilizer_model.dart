class FertilizerModel {
  final String cropType;
  final String fertilizerName;
  final String npkRatio;
  final double totalQuantity;
  final double estimatedCost;

  FertilizerModel({
    required this.cropType,
    required this.fertilizerName,
    required this.npkRatio,
    required this.totalQuantity,
    required this.estimatedCost,
  });
}
