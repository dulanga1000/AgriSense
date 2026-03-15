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
      cropName: json['crop_name'],
      duration: json['duration'],
      water: json['water'],
      profit: json['profit'],
      tag: json['tag'],
      imagePath: json['image_path'],
      suited: json['suited'],
    );
  }
}
