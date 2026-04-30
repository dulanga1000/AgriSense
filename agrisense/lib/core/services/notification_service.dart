import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  /// Generate a unique notification ID so multiple notifications can coexist
  int _generateId() => Random().nextInt(100000);

  /// Initialize notification service
  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
        );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification tap
      },
    );

    // Request permissions on iOS
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    // Request permissions on Android 13+
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  /// Show notification for successful login
  Future<void> showLoginNotification({required String email}) async {
    await _showNotification(
      title: '✅ Welcome Back!',
      body: 'You have successfully logged in to AgriSense',
      payload: 'login_$email',
    );
  }

  /// Show notification for successful registration
  Future<void> showRegistrationNotification({required String email}) async {
    await _showNotification(
      title: '🎉 Account Created!',
      body: 'Welcome to AgriSense! Your account has been registered successfully.',
      payload: 'registration_$email',
    );
  }

  /// Show notification for password reset request
  Future<void> showForgotPasswordNotification({required String email}) async {
    await _showNotification(
      title: '🔑 Password Reset',
      body: 'A password reset link has been sent to $email',
      payload: 'forgot_password_$email',
    );
  }

  /// Show notification for successful password change
  Future<void> showPasswordChangeNotification() async {
    await _showNotification(
      title: '🔒 Password Changed',
      body: 'Your password has been successfully changed',
      payload: 'password_changed',
    );
  }

  /// Show notification for logout
  Future<void> showLogoutNotification() async {
    await _showNotification(
      title: '👋 Logged Out',
      body: 'You have been logged out from AgriSense',
      payload: 'logout',
    );
  }

  /// Generic notification method
  Future<void> _showNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    try {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
            'auth_channel',
            'Authentication Notifications',
            channelDescription: 'Notifications for authentication events',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: true,
            icon: '@mipmap/ic_launcher',
          );

      const DarwinNotificationDetails iOSPlatformChannelSpecifics =
          DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          );

      const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
      );

      await _flutterLocalNotificationsPlugin.show(
        _generateId(),
        title,
        body,
        platformChannelSpecifics,
        payload: payload,
      );
    } catch (e) {
      debugPrint('Error showing notification: $e');
    }
  }

  /// Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  /// Cancel specific notification
  Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }
}
