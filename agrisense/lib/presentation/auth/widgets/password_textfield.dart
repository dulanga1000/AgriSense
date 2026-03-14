import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget {
  final TextEditingController controller;

  const PasswordTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: true,

      decoration: InputDecoration(
        hintText: "Enter your password",
        prefixIcon: const Icon(Icons.lock_outline),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF0E8F3E), // green border
            width: 2,
          ),
        ),
      ),

      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Password is required";
        }

        if (value.length < 6) {
          return "Password must be at least 6 characters";
        }

        return null;
      },
    );
  }
}