import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthApiService {
  static const String baseUrl = "https://agrisense-qnpv.onrender.com/api/auth";

  // ==========================
  // 📩 SEND OTP
  // ==========================
  static Future<void> sendOtp(String email) async {
    try {
      final url = Uri.parse("$baseUrl/send-otp");

      final response = await http
          .post(
            url,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"email": email}),
          )
          .timeout(const Duration(seconds: 10));

      final data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw Exception(data["error"] ?? "Failed to send OTP");
      }
    } catch (e) {
      rethrow;
    }
  }

  // ==========================
  // 🔐 VERIFY OTP
  // ==========================
  static Future<void> verifyOtp(String email, String otp) async {
    try {
      final url = Uri.parse("$baseUrl/verify-otp");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "otp": otp}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw Exception(data["error"] ?? "Invalid OTP");
      }
    } catch (e) {
      rethrow;
    }
  }

  // ==========================
  // 🔄 RESET PASSWORD
  // ==========================
  static Future<void> resetPassword(String email, String newPassword) async {
    try {
      final url = Uri.parse("$baseUrl/reset-password");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "newPassword": newPassword}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw Exception(data["error"] ?? "Password reset failed");
      }
    } catch (e) {
      rethrow;
    }
  }
}
