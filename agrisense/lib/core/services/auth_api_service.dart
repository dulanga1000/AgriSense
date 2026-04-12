import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthApiService {
  static const String baseUrl = "http://192.168.8.180:3000/api/auth";

  // ==========================
  // 📩 SEND OTP
  // ==========================
  static Future<void> sendOtp(String email) async {
    try {
      final url = Uri.parse("$baseUrl/send-otp");

      print("➡️ Sending OTP request to: $url");
      print("📧 Email: $email");

      final response = await http
          .post(
            url,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"email": email}),
          )
          .timeout(const Duration(seconds: 10));

      print("✅ STATUS: ${response.statusCode}");
      print("📦 BODY: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw Exception(data["error"] ?? "Failed to send OTP");
      }
    } catch (e) {
      print("❌ SEND OTP ERROR: $e");
      rethrow;
    }
  }

  // ==========================
  // 🔐 VERIFY OTP
  // ==========================
  static Future<void> verifyOtp(String email, String otp) async {
    try {
      final url = Uri.parse("$baseUrl/verify-otp");

      print("➡️ Verifying OTP for: $email");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "otp": otp}),
      );

      print("✅ STATUS: ${response.statusCode}");
      print("📦 BODY: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw Exception(data["error"] ?? "Invalid OTP");
      }
    } catch (e) {
      print("❌ VERIFY OTP ERROR: $e");
      rethrow;
    }
  }

  // ==========================
  // 🔄 RESET PASSWORD
  // ==========================
  static Future<void> resetPassword(String email, String newPassword) async {
    try {
      final url = Uri.parse("$baseUrl/reset-password");

      print("➡️ Resetting password for: $email");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "newPassword": newPassword}),
      );

      print("✅ STATUS: ${response.statusCode}");
      print("📦 BODY: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw Exception(data["error"] ?? "Password reset failed");
      }
    } catch (e) {
      print("❌ RESET ERROR: $e");
      rethrow;
    }
  }
}
