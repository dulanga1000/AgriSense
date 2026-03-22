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