import 'package:flutter/material.dart';

class RainPredictionCard extends StatelessWidget {
  const RainPredictionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16), // same spacing as other cards
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12), // same radius
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.cloud_queue, color: Colors.blue),

              SizedBox(width: 8),

              Text(
                "Rain Prediction",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),

          const SizedBox(height: 12),

          const Text(
            "Today - 20% chance of rain",
            style: TextStyle(fontSize: 14),
          ),

          const SizedBox(height: 10),

          LinearProgressIndicator(
            value: 0.2,
            backgroundColor: Colors.blue.shade100,
            color: Colors.blue,
            minHeight: 6,
          ),

          const SizedBox(height: 12),

          const Text(
            "Low rain probability - good day for outdoor farming activities",
            style: TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
