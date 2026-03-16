class FarmingTip {
  final int id;
  final String description;
  final String type;

  const FarmingTip({
    required this.id,
    required this.description,
    required this.type,
  });

  factory FarmingTip.fromJson(Map<String, dynamic> json) {
    return FarmingTip(
      id: json['id'],
      description: json['description'],
      type: json['type'],
    );
  }
}
