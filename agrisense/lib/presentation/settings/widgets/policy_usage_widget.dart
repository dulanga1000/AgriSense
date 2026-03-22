import 'package:flutter/material.dart';

class PolicyUsageWidget extends StatelessWidget {
  const PolicyUsageWidget({super.key});

  Widget _buildItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check, color: Colors.green, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black54,
                height: 1.4,
              ),
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
          // 👁️ Icon Box
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.purple.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.remove_red_eye_outlined,
              color: Colors.purple,
            ),
          ),

          const SizedBox(width: 12),

          // 📄 Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "How We Use Your Information",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                _buildItem(
                  "Provide personalized farming recommendations and crop advice",
                ),
                _buildItem(
                  "Detect and identify plant diseases using AI technology",
                ),
                _buildItem(
                  "Deliver weather updates and farming alerts specific to your location",
                ),
                _buildItem("Improve our services and develop new features"),
                _buildItem(
                  "Send you important notifications about your crops and farm",
                ),
                _buildItem(
                  "Ensure app security and prevent fraudulent activity",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
