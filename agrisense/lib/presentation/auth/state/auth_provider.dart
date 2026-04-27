import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:agrisense/data/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _repo = AuthRepository();

  User? user;
  bool isLoading = false;
  String? error;

  Future<void> register(String email, String password) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      user = await _repo.register(email, password);

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

    } catch (e) {
      error = e.toString().replaceAll("Exception: ", "");
      user = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ✅ ADDED THIS METHOD TO CHANGE PASSWORD
  Future<bool> changePassword(String currentPassword, String newPassword) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      await _repo.changePassword(currentPassword, newPassword);
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
    } catch (e) {
      error = e.toString().replaceAll("Exception: ", "");
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _repo.logout();
    user = null;
    notifyListeners();
  }
}