import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  final TextEditingController controller;

  const EmailTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,

      decoration: InputDecoration(
        hintText: "Enter your email",
        prefixIcon: const Icon(Icons.email_outlined),

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
            color: Color(0xFF0E8F3E), // green border when focused
            width: 2,
          ),
        ),
      ),

      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Email is required";
        }

        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
          return "Enter a valid email";
        }

        return null;
      },
    );
  }
}