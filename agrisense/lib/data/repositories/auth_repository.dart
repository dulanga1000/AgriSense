import 'package:firebase_auth/firebase_auth.dart';
import 'package:agrisense/core/services/firebase_auth_service.dart';

class AuthRepository {
  final FirebaseAuthService _service = FirebaseAuthService();

  Future<User?> register(String email, String password) async {
    return await _service.registerWithEmail(
      email: email,
      password: password,
    );
  }

  Future<User?> login(String email, String password) async {
    return await _service.loginWithEmail(
      email: email,
      password: password,
    );
  }

  Future<User?> googleSignIn() async {
    return await _service.signInWithGoogle();
  }

  Future<void> forgotPassword(String email) async {
    await _service.sendPasswordResetEmail(email);
  }

  Future<void> logout() async {
    await _service.logout();
  }
}