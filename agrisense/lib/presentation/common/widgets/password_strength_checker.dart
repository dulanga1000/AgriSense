import 'package:flutter/material.dart';

class PasswordStrengthChecker extends StatelessWidget {
  final String password;

  const PasswordStrengthChecker({super.key, required this.password});

  bool get _hasMinLength => password.length >= 8;
  bool get _hasUppercase => password.contains(RegExp(r'[A-Z]'));
  bool get _hasLowercase => password.contains(RegExp(r'[a-z]'));
  bool get _hasNumber => password.contains(RegExp(r'[0-9]'));
  bool get _hasSpecialChar =>
      password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password must contain:',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        _buildRule('At least 8 characters', _hasMinLength),
        _buildRule('One uppercase letter', _hasUppercase),
        _buildRule('One lowercase letter', _hasLowercase),
        _buildRule('One number', _hasNumber),
        _buildRule('One special character', _hasSpecialChar),
      ],
    );
  }

  Widget _buildRule(String text, bool passed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            passed ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 16,
            color: passed ? const Color(0xFF0E8F3E) : Colors.grey,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: passed ? const Color(0xFF0E8F3E) : Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
