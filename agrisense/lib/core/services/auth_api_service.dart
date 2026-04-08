import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthApiService {
  static const String baseUrl =
      "https://observant-balance-production.up.railway.app:8080/api/auth"; // CHANGE IP

  static Future<void> sendOtp(String email) async {
    final response = await http.post(
      Uri.parse("$baseUrl/send-otp"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email}),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to send OTP");
    }
  }

  static Future<void> verifyOtp(String email, String otp) async {
    final response = await http.post(
      Uri.parse("$baseUrl/verify-otp"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "otp": otp}),
    );

    if (response.statusCode != 200) {
      throw Exception("Invalid OTP");
    }
  }

  static Future<void> resetPassword(String email, String newPassword) async {
    final response = await http.post(
      Uri.parse("$baseUrl/reset-password"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "newPassword": newPassword}),
    );

    if (response.statusCode != 200) {
      throw Exception("Password reset failed");
    }
  }
}
