import 'package:flutter/material.dart';

class TermsLiabilityWidget extends StatelessWidget {
  const TermsLiabilityWidget({super.key});

  Widget _buildItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• "),
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
          // ⚖️ Icon Box
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.balance, color: Colors.red),
          ),

          const SizedBox(width: 12),

          // 📄 Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Limitation of Liability",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 6),

                const Text(
                  "To the fullest extent permitted by law, AgriSense shall not be liable for:",
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),

                const SizedBox(height: 10),

                _buildItem(
                  "Any indirect, incidental, special, or consequential damages",
                ),
                _buildItem(
                  "Loss of profits, revenue, data, or agricultural yields",
                ),
                _buildItem("Crop failures or pest infestations"),
                _buildItem(
                  "Damages resulting from reliance on app recommendations",
                ),
                _buildItem("Service interruptions or technical errors"),
                _buildItem("Actions taken by third-party service providers"),

                const SizedBox(height: 10),

                const Text(
                  "Your use of AgriSense is at your sole risk. The service is provided \"as is\" and \"as available\" without warranties of any kind.",
                  style: TextStyle(
                    fontSize: 13,
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
}
