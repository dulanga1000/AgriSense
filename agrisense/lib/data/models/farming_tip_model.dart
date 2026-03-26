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
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      description: json['description']?.toString() ?? '',
      type: json['type']?.toString() ?? 'default',
    );
  }
}
