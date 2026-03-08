import 'package:flutter/material.dart';

class CropItemCardWidget extends StatelessWidget {
  final String cropName;
  final String duration;
  final String water;
  final String profit;
  final String tag;
  final String image;

  const CropItemCardWidget({
    super.key,
    required this.cropName,
    required this.duration,
    required this.water,
    required this.profit,
    required this.tag,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Image.asset(image, height: 40),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cropName, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text("Duration: $duration", style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 6),
                Text("Water Need: $water"),
                Text("Profitability: $profit"),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(tag),
          )
        ],
      ),
    );
  }
}