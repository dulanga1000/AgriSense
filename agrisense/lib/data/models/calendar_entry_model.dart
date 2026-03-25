class CalendarEntryModel {
  final String month;
  final String crops;
  final String label;
  final String imagePath;

  const CalendarEntryModel({
    required this.month,
    required this.crops,
    required this.label,
    required this.imagePath,
  });

  factory CalendarEntryModel.fromJson(Map<String, dynamic> json) {
  return CalendarEntryModel(
    month: (json['month'] ?? "").toString(),
    crops: (json['crops'] ?? "").toString(),
    label: (json['label'] ?? "").toString(),
    imagePath: (json['image_path'] ?? json['imagePath'] ?? "assets/images/tractor.png").toString(),
  );
}
}
