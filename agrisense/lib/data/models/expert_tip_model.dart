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
      title: json['title']?.toString() ?? 'Advisory Tip',
      description:
          json['description']?.toString() ??
          'No detailed recommendation available.',
      type: json['type']?.toString() ?? 'soil',
    );
  }
}
