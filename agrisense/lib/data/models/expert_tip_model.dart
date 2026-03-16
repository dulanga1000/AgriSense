class ExpertTipModel {
  final String title;
  final String description;
  final String type;

  const ExpertTipModel({
    required this.title,
    required this.description,
    required this.type,
  });

  factory ExpertTipModel.fromJson(Map<String, dynamic> json) {
    return ExpertTipModel(
      title: json['title'],
      description: json['description'],
      type: json['type'],
    );
  }
}
