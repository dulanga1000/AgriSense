class CropModel {
  final String cropName;
  final String duration;
  final String water;
  final String profit;
  final String tag;
  final String iconName;
  final String suited;

  const CropModel({
    required this.cropName,
    required this.duration,
    required this.water,
    required this.profit,
    required this.tag,
    required this.iconName,
    required this.suited,
  });

  factory CropModel.fromJson(Map<String, dynamic> json) {
    return CropModel(
      cropName: json['crop_name']?.toString() ?? "Unknown Crop",
      duration: json['duration']?.toString() ?? "N/A",
      water: json['water']?.toString() ?? "Medium",
      profit: json['profit']?.toString() ?? "Medium",
      tag: json['tag']?.toString() ?? "Good Time",
      iconName: json['icon_name']?.toString() ?? "leaf", // ✅ Fallback to leaf
      suited: json['suited']?.toString() ?? "All Areas",
    );
  }
}
