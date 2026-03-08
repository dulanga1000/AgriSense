class FertilizerModel {
  final String cropType;
  final double landSize;
  final String fertilizerName;
  final double quantity;
  final String npkRatio;
  final double estimatedCost;

  FertilizerModel({
    required this.cropType,
    required this.landSize,
    required this.fertilizerName,
    required this.quantity,
    required this.npkRatio,
    required this.estimatedCost,
  });
}
