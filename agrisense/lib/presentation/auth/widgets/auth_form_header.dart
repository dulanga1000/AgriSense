import 'package:flutter/material.dart';

class AuthFormHeader extends StatelessWidget {
  const AuthFormHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/icons/app_icon.png",
          height: 100,
        ),
        const SizedBox(height: 10),

        const Text(
          "AgriSense",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

        const SizedBox(height: 6),

        const Text(
          "Smart Farming Assistant",
          style: TextStyle(
            fontSize: 16,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }
}