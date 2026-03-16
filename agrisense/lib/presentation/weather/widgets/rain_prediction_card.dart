import 'package:flutter/material.dart';
import 'package:agrisense/data/models/weather_model.dart';

class RainPredictionCard extends StatelessWidget {
  final RainPredictionModel rainData;

  const RainPredictionCard({super.key, required this.rainData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.cloud_queue, color: Colors.blue),
              const SizedBox(width: 8),
              Text(
                rainData.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(rainData.todayPrediction, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: rainData.rainChance,
            backgroundColor: Colors.blue.shade100,
            color: Colors.blue,
            minHeight: 6,
          ),
          const SizedBox(height: 12),
          Text(rainData.description, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
