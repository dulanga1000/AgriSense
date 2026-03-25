class CropModel {
  final String cropName;
  final String duration;
  final String water;
  final String profit;
  final String tag;
  final String imagePath;
  final String suited;

  const CropModel({
    required this.cropName,
    required this.duration,
    required this.water,
    required this.profit,
    required this.tag,
    required this.imagePath,
    required this.suited,
  });

  factory CropModel.fromJson(Map<String, dynamic> json) {
  return CropModel(
    cropName: (json['crop_name'] ?? json['cropName'] ?? "Unknown Crop").toString(),
    duration: (json['duration'] ?? "N/A").toString(),
    water: (json['water'] ?? "Medium").toString(),
    profit: (json['profit'] ?? "Medium").toString(),
    tag: (json['tag'] ?? "Recommended").toString(),
    imagePath: (json['image_path'] ?? json['imagePath'] ?? "assets/images/rice.png").toString(),
    suited: (json['suited'] ?? "Various regions").toString(),
  );
}
}

