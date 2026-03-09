import 'package:flutter/material.dart';

class ExpertTipsCard extends StatelessWidget {
  const ExpertTipsCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Reduced width to 90% of screen width
    final double cardWidth = MediaQuery.of(context).size.width * 0.9;

    return Center(
      child: Container(
        width: cardWidth,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              children: [
                Image.asset(
                  "assets/images/bulb.png",
                  width: 22,
                  height: 22,
                ),
                const SizedBox(width: 8),
                const Text(
                  "Expert Tips for Yala Season",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Tips
            _tipItem(
              color: Colors.green.shade100,
              title: "Water Management",
              description:
                  "Monitor rainfall patterns and adjust irrigation schedules accordingly",
            ),

            const SizedBox(height: 10),

            _tipItem(
              color: Colors.blue.shade100,
              title: "Soil Preparation",
              description:
                  "Test soil pH and add organic matter before planting",
            ),

            const SizedBox(height: 10),

            _tipItem(
              color: Colors.orange.shade100,
              title: "Pest Control",
              description:
                  "Regular monitoring helps prevent major outbreaks during this season",
            ),
          ],
        ),
      ),
    );
  }

  // Tip item widget
  static Widget _tipItem({
    required Color color,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            "assets/images/check.png",
            width: 20,
            height: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black, fontSize: 13),
                children: [
                  TextSpan(
                    text: "$title: ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}