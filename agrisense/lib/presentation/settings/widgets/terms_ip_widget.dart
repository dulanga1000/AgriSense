import 'package:flutter/material.dart';

class TermsIPWidget extends StatelessWidget {
  const TermsIPWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Intellectual Property Rights",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 8),

          Text(
            "All content, features, and functionality of AgriSense, including but not limited to text, graphics, logos, icons, images, audio clips, and software, are the exclusive property of AgriSense and are protected by international copyright, trademark, and other intellectual property laws.",
            style: TextStyle(fontSize: 13, color: Colors.black54, height: 1.5),
          ),

          SizedBox(height: 10),

          Text(
            "You may not reproduce, distribute, modify, create derivative works, publicly display, or exploit any part of the app without our prior written permission.",
            style: TextStyle(fontSize: 13, color: Colors.black54, height: 1.5),
          ),
        ],
      ),
    );
  }
}
