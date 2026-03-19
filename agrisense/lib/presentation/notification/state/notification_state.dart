import 'package:flutter/material.dart';
import 'package:agrisense/data/models/notification_model.dart';
import 'package:agrisense/data/repositories/notification_repository.dart';

class NotificationState extends ChangeNotifier {
  final NotificationRepository _repository;

  NotificationState(this._repository);

  List<NotificationModel> _notifications = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<NotificationModel> get notifications => _notifications;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null && _errorMessage!.isNotEmpty;

  Future<void> loadNotifications({bool forceRefresh = false}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _notifications = await _repository.fetchNotifications(
        forceRefresh: forceRefresh,
      );
    } catch (e, st) {
      _errorMessage = 'Failed to load notifications. Please try again.';
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: e,
          stack: st,
          library: 'notification_state',
          context: ErrorDescription('while loading notifications'),
        ),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> markAsRead(String notificationId) async {
    final index = _notifications.indexWhere((n) => n.id == notificationId);
    if (index == -1) return;

    // ✅ Optimistic update
    _notifications[index] = _notifications[index].copyWith(isUnread: false);
    notifyListeners();

    await _repository.markAsRead(notificationId);
  }

  Future<void> markAllAsRead() async {
    final hasUnread = _notifications.any((n) => n.isUnread);
    if (!hasUnread) return;

    // ✅ Optimistic update
    _notifications = _notifications
        .map((n) => n.copyWith(isUnread: false))
        .toList();
    notifyListeners();

    await _repository.markAllAsRead();
  }
}
