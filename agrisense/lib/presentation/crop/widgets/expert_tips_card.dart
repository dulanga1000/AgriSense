import 'package:flutter/material.dart';

class ExpertTipsCard extends StatelessWidget {
  const ExpertTipsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.purple[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Expert Tips",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            "Get practical advice and recommendations from agricultural experts to maximize yield.",
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}