import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String hintText;

  const PasswordTextField({
    super.key,
    required this.controller,
    this.onChanged,
    this.hintText = "Enter your password",
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: obscurePassword,

      /// This enables LIVE validation in the reset screen
      onChanged: widget.onChanged,

      decoration: InputDecoration(
        hintText: widget.hintText,

        prefixIcon: const Icon(Icons.lock_outline),

        suffixIcon: IconButton(
          icon: Icon(
            obscurePassword
                ? Icons.visibility_off
                : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              obscurePassword = !obscurePassword;
            });
          },
        ),

        filled: true,
        fillColor: Colors.grey.shade100,

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
            color: Color(0xFF0E8F3E),
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