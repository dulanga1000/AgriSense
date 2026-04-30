import 'dart:async';
import 'package:flutter/material.dart';
import 'package:agrisense/data/models/notification_model.dart';
import 'package:agrisense/data/repositories/notification_repository.dart';

class NotificationState extends ChangeNotifier {
  final NotificationRepository _repository;

  NotificationState(this._repository) {
    _initializePolling();
  }

  List<NotificationModel> _notifications = [];
  bool _isLoading = false;
  String? _errorMessage;
  Timer? _pollingTimer;
  static const Duration _pollingInterval = Duration(seconds: 10);

  bool _notificationsEnabled = true;
  bool _diseaseAlertsEnabled = true;
  bool _weatherUpdatesEnabled = true;
  bool _farmingTipsEnabled = true;
  bool _authAlertsEnabled = true;

  List<NotificationModel> get notifications => _getFilteredNotifications();
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null && _errorMessage!.isNotEmpty;

  void updateNotificationSettings({
    bool? notificationsEnabled,
    bool? diseaseAlertsEnabled,
    bool? weatherUpdatesEnabled,
    bool? farmingTipsEnabled,
    bool? authAlertsEnabled,
  }) {
    _notificationsEnabled = notificationsEnabled ?? _notificationsEnabled;
    _diseaseAlertsEnabled = diseaseAlertsEnabled ?? _diseaseAlertsEnabled;
    _weatherUpdatesEnabled = weatherUpdatesEnabled ?? _weatherUpdatesEnabled;
    _farmingTipsEnabled = farmingTipsEnabled ?? _farmingTipsEnabled;
    _authAlertsEnabled = authAlertsEnabled ?? _authAlertsEnabled;
    notifyListeners();
  }

  List<NotificationModel> _getFilteredNotifications() {
    if (!_notificationsEnabled) {
      return [];
    }

    return _notifications.where((notification) {
      switch (notification.type.toLowerCase()) {
        case 'weather':
          return _weatherUpdatesEnabled;
        case 'alert':
        case 'disease':
          return _diseaseAlertsEnabled;
        case 'recommendation':
        case 'farming tip':
          return _farmingTipsEnabled;
        case 'login':
        case 'logout':
        case 'registration':
        case 'password_reset':
        case 'password_changed':
          return _authAlertsEnabled;
        default:
          return true;
      }
    }).toList();
  }

  Future<void> loadNotifications({bool forceRefresh = false}) async {
    if (_isLoading) return;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _notifications = await _repository.fetchNotifications(
        forceRefresh: forceRefresh,
      );
      _errorMessage = null;
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

  void _initializePolling() {
    loadNotifications();

    _pollingTimer = Timer.periodic(_pollingInterval, (_) {
      _pollForUpdates();
    });
  }

  Future<void> _pollForUpdates() async {
    if (_isLoading) return;

    try {
      final newNotifications = await _repository.fetchNotifications(
        forceRefresh: true,
      );

      _notifications = newNotifications;
      notifyListeners();
    } catch (e) {
      debugPrint('Notification polling failed: $e');
    }
  }

  void stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  void startPolling() {
    stopPolling();
    _initializePolling();
  }

  Future<void> markAsRead(String notificationId) async {
    final index = _notifications.indexWhere((n) => n.id == notificationId);
    if (index == -1) return;

    _notifications[index] = _notifications[index].copyWith(isUnread: false);
    notifyListeners();

    await _repository.markAsRead(notificationId);
  }

  Future<void> markAllAsRead() async {
    final hasUnread = _notifications.any((n) => n.isUnread);
    if (!hasUnread) return;

    _notifications = _notifications
        .map((n) => n.copyWith(isUnread: false))
        .toList();
    notifyListeners();

    await _repository.markAllAsRead();
  }

  void resetForLogout() {
    _notifications = [];
    _isLoading = false;
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
    super.dispose();
  }
}
