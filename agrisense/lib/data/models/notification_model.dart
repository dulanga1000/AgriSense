class NotificationModel {
  final String id;
  final String title;
  final String description;
  final DateTime time;
  final String type;
  final bool isUnread;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.type,
    this.isUnread = false,
  });

  NotificationModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? time,
    String? type,
    bool? isUnread,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time,
      type: type ?? this.type,
      isUnread: isUnread ?? this.isUnread,
    );
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      time: DateTime.parse(json['time'] as String),
      type: json['type'] as String,
      isUnread: json['isUnread'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'time': time.toIso8601String(),
      'type': type,
      'isUnread': isUnread,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is NotificationModel && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'NotificationModel(id: $id, title: $title, type: $type, isUnread: $isUnread)';
}
