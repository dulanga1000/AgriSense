class CalendarEntryModel {
  final String month;
  final String crops;
  final String label;
  final String iconName;

  const CalendarEntryModel({
    required this.month,
    required this.crops,
    required this.label,
    required this.iconName,
  });

  factory CalendarEntryModel.fromJson(Map<String, dynamic> json) {
    return CalendarEntryModel(
      month: json['month']?.toString() ?? 'N/A',
      crops: json['crops']?.toString() ?? 'N/A',
      label: json['label']?.toString() ?? 'Task',
      iconName:
          json['icon_name']?.toString() ??
          json['image_path']?.toString() ??
          'leaf',
    );
  }
}
