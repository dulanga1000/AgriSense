import 'package:agrisense/data/models/notification_model.dart';

class NotificationRepository {
  static List<NotificationModel>? _store;

  static final Map<String, bool> _unreadById = <String, bool>{};

  static bool _initialSeedDone = false;

  List<NotificationModel> _hardcodedNotifications() => [
    NotificationModel(
      id: "1",
      title: "Weather Alert: Heavy Rain Expected",
      description:
          "Heavy rain is expected in your area tomorrow. Please take necessary precautions to protect your crops.",
      time: DateTime.now().subtract(const Duration(minutes: 30)),
      type: "Weather",
      isUnread: true,
    ),
    NotificationModel(
      id: "2",
      title: "New Fertilizer Recommendation Available",
      description:
          "Based on your recent soil analysis, a new fertilizer recommendation is available for your crops.",
      time: DateTime.now().subtract(const Duration(hours: 2)),
      type: "Recommendation",
      isUnread: true,
    ),
    NotificationModel(
      id: "3",
      title: "Disease Detected in Nearby Area",
      description:
          "A disease outbreak has been detected in a nearby area. Monitor your crops closely.",
      time: DateTime.now().subtract(const Duration(days: 1)),
      type: "Alert",
      isUnread: true,
    ),
    NotificationModel(
      id: "4",
      title: "Soil Moisture Low",
      description:
          "Soil moisture levels are critically low. Consider irrigation soon.",
      time: DateTime.now().subtract(const Duration(days: 1)),
      type: "Alert",
      isUnread: true,
    ),
    NotificationModel(
      id: "5",
      title: "Harvest Time Approaching",
      description:
          "Based on your crop schedule, harvest time is approaching in 3 days.",
      time: DateTime.now().subtract(const Duration(days: 2)),
      type: "Recommendation",
      isUnread: false,
    ),
  ];

  void _seedStore({bool forceRefresh = false}) {
    final raw = _hardcodedNotifications();

    if (!_initialSeedDone) {
      for (final n in raw) {
        _unreadById[n.id] = n.isUnread;
      }
      _initialSeedDone = true;
    }

    if (_store == null || forceRefresh) {
      _store = raw.map((n) {
        final isUnread = _unreadById[n.id] ?? n.isUnread;
        return n.copyWith(isUnread: isUnread);
      }).toList();
    }
  }

  Future<List<NotificationModel>> fetchNotifications({
    bool forceRefresh = false,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    _seedStore(forceRefresh: forceRefresh);
    return _store!.map((n) => n.copyWith()).toList();
  }

  Future<bool> markAsRead(String notificationId) async {
    _seedStore();

    final index = _store!.indexWhere((n) => n.id == notificationId);
    if (index == -1) return false;

    if (_store![index].isUnread) {
      _store![index] = _store![index].copyWith(isUnread: false);
      _unreadById[notificationId] = false;
    }

    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Future<int> markAllAsRead() async {
    _seedStore();

    var updatedCount = 0;
    for (var i = 0; i < _store!.length; i++) {
      final n = _store![i];
      if (n.isUnread) {
        _store![i] = n.copyWith(isUnread: false);
        _unreadById[n.id] = false;
        updatedCount++;
      }
    }

    await Future.delayed(const Duration(milliseconds: 200));
    return updatedCount;
  }

  void reset() {
    _store = null;
    _unreadById.clear();
    _initialSeedDone = false;
  }
}
