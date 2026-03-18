import 'package:flutter/material.dart';

class AnalyzingCard extends StatelessWidget {
  const AnalyzingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              strokeWidth: 6,
              valueColor: AlwaysStoppedAnimation<Color>(
                const Color(0xFFFB2C36),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Analyzing plant health...",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          const Text(
            "This may take a few seconds.",
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
