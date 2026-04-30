import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agrisense/data/models/notification_model.dart';

class AuthNotificationRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Save login notification to Firestore
  Future<void> saveLoginNotification({
    required String userId,
    required String email,
  }) async {
    try {
      final notification = NotificationModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: 'Welcome Back!',
        description: 'You have successfully logged in to AgriSense',
        time: DateTime.now(),
        type: 'login',
        isUnread: true,
      );

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('notifications')
          .doc(notification.id)
          .set(notification.toJson());
    } catch (e) {
      debugPrint('Error saving login notification: $e');
      rethrow;
    }
  }

  /// Save registration notification to Firestore
  Future<void> saveRegistrationNotification({
    required String userId,
    required String email,
  }) async {
    try {
      final notification = NotificationModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: 'Account Created!',
        description:
            'Welcome to AgriSense! Your account ($email) has been registered successfully.',
        time: DateTime.now(),
        type: 'registration',
        isUnread: true,
      );

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('notifications')
          .doc(notification.id)
          .set(notification.toJson());
    } catch (e) {
      debugPrint('Error saving registration notification: $e');
      rethrow;
    }
  }

  /// Save forgot password notification to Firestore
  Future<void> saveForgotPasswordNotification({
    required String userId,
    required String email,
  }) async {
    try {
      final notification = NotificationModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: 'Password Reset Request',
        description:
            'A password reset link has been sent to $email. Check your email to reset your password.',
        time: DateTime.now(),
        type: 'password_reset',
        isUnread: true,
      );

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('notifications')
          .doc(notification.id)
          .set(notification.toJson());
    } catch (e) {
      debugPrint('Error saving forgot password notification: $e');
      rethrow;
    }
  }

  /// Save password change notification to Firestore
  Future<void> savePasswordChangeNotification({required String userId}) async {
    try {
      final notification = NotificationModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: 'Password Changed',
        description:
            'Your password has been successfully changed. If you did not change your password, please contact support.',
        time: DateTime.now(),
        type: 'password_changed',
        isUnread: true,
      );

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('notifications')
          .doc(notification.id)
          .set(notification.toJson());
    } catch (e) {
      debugPrint('Error saving password change notification: $e');
      rethrow;
    }
  }

  /// Save logout notification to Firestore
  Future<void> saveLogoutNotification({required String userId}) async {
    try {
      final notification = NotificationModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: 'Logged Out',
        description: 'You have been logged out from AgriSense',
        time: DateTime.now(),
        type: 'logout',
        isUnread: true,
      );

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('notifications')
          .doc(notification.id)
          .set(notification.toJson());
    } catch (e) {
      debugPrint('Error saving logout notification: $e');
      rethrow;
    }
  }

  /// Get all auth notifications for a user
  Future<List<NotificationModel>> getAuthNotifications(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('notifications')
          .where(
            'type',
            whereIn: ['login', 'registration', 'password_reset', 'password_changed', 'logout'],
          )
          .orderBy('time', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => NotificationModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      debugPrint('Error fetching auth notifications: $e');
      rethrow;
    }
  }
}
