import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:agrisense/data/repositories/auth_repository.dart';
import 'package:agrisense/data/repositories/auth_notification_repository.dart';
import 'package:agrisense/core/services/notification_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _repo = AuthRepository();
  final AuthNotificationRepository _notificationRepo =
      AuthNotificationRepository();
  final NotificationService _notificationService = NotificationService();

  User? user;
  bool isLoading = false;
  String? error;

  Future<void> register(String email, String password) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      user = await _repo.register(email, password);

      // ✅ Show local notification on registration
      if (user != null) {
        await _notificationService.showRegistrationNotification(email: email);

        // ✅ Save notification to Firestore
        try {
          await _notificationRepo.saveRegistrationNotification(
            userId: user!.uid,
            email: email,
          );
        } catch (notifError) {
          debugPrint('Failed to save registration notification: $notifError');
          // Don't fail the registration if notification save fails
        }
      }
    } catch (e) {
      error = e.toString().replaceAll("Exception: ", "");
      user = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      user = await _repo.login(email, password);

      // ✅ Show local notification on login
      if (user != null) {
        await _notificationService.showLoginNotification(email: email);

        // ✅ Save notification to Firestore
        try {
          await _notificationRepo.saveLoginNotification(
            userId: user!.uid,
            email: email,
          );
        } catch (notifError) {
          debugPrint('Failed to save login notification: $notifError');
          // Don't fail the login if notification save fails
        }
      }
    } catch (e) {
      error = e.toString().replaceAll("Exception: ", "");
      user = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> googleSignIn() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      user = await _repo.googleSignIn();

      // ✅ Show local notification on Google sign-in
      if (user != null) {
        await _notificationService.showLoginNotification(
          email: user!.email ?? 'Google User',
        );

        // ✅ Save notification to Firestore
        try {
          await _notificationRepo.saveLoginNotification(
            userId: user!.uid,
            email: user!.email ?? 'Google User',
          );
        } catch (notifError) {
          debugPrint('Failed to save login notification: $notifError');
          // Don't fail the login if notification save fails
        }
      }
    } catch (e) {
      error = e.toString().replaceAll("Exception: ", "");
      user = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ✅ ADDED THIS METHOD TO CHANGE PASSWORD
  Future<bool> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      await _repo.changePassword(currentPassword, newPassword);

      // ✅ Show local notification on password change
      if (user != null) {
        await _notificationService.showPasswordChangeNotification();

        // ✅ Save notification to Firestore
        try {
          await _notificationRepo.savePasswordChangeNotification(
            userId: user!.uid,
          );
        } catch (notifError) {
          debugPrint(
            'Failed to save password change notification: $notifError',
          );
          // Don't fail the password change if notification save fails
        }
      }

      return true; // Success
    } catch (e) {
      error = e.toString().replaceAll("Exception: ", "");
      return false; // Failed
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      error = null;
      await _repo.forgotPassword(email);

      // ✅ Show local notification for forgot password
      await _notificationService.showForgotPasswordNotification(email: email);

      // ✅ Save notification to Firestore if user exists
      try {
        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          await _notificationRepo.saveForgotPasswordNotification(
            userId: currentUser.uid,
            email: email,
          );
        }
      } catch (notifError) {
        debugPrint('Failed to save forgot password notification: $notifError');
        // Don't fail the password reset if notification save fails
      }

      notifyListeners();
    } catch (e) {
      error = e.toString().replaceAll("Exception: ", "");
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      if (user != null) {
        // ✅ Save logout notification to Firestore
        try {
          await _notificationRepo.saveLogoutNotification(userId: user!.uid);
        } catch (notifError) {
          debugPrint('Failed to save logout notification: $notifError');
          // Don't fail the logout if notification save fails
        }

        // ✅ Show logout notification
        await _notificationService.showLogoutNotification();
      }
    } catch (notifError) {
      debugPrint('Error showing logout notification: $notifError');
    } finally {
      await _repo.logout();
      user = null;
      notifyListeners();
    }
  }
}
