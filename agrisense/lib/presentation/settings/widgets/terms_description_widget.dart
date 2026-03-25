import 'package:flutter/material.dart';

class TermsDescriptionWidget extends StatelessWidget {
  const TermsDescriptionWidget({super.key});

  Widget _buildServiceItem({
    required IconData icon,
    required Color color,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 📱 Icon Box
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.purple.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.phone_android, color: Colors.purple),
          ),

          const SizedBox(width: 12),

          // 📄 Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Description of Service",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 6),

                const Text(
                  "AgriSense is a smart farming assistant application that provides:",
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),

                _buildServiceItem(
                  icon: Icons.eco,
                  color: Colors.green,
                  title: "Disease Detection",
                  description:
                      "AI-powered plant disease identification and treatment recommendations",
                ),

                _buildServiceItem(
                  icon: Icons.wb_sunny,
                  color: Colors.orange,
                  title: "Weather Insights",
                  description:
                      "Real-time weather data and crop-specific advice",
                ),

                _buildServiceItem(
                  icon: Icons.water_drop,
                  color: Colors.blue,
                  title: "Fertilizer Recommendations",
                  description:
                      "Customized fertilizer suggestions based on crop and land size",
                ),

                _buildServiceItem(
                  icon: Icons.bar_chart,
                  color: Colors.purple,
                  title: "Farming Analytics",
                  description:
                      "Insights and notifications to optimize your farming practices",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
