import 'package:flutter/material.dart';

class TermsDisclaimerWidget extends StatelessWidget {
  const TermsDisclaimerWidget({super.key});

  Widget _buildSection(String title, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black54,
              height: 1.4,
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
          // ⚠️ Icon Box
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.yellow.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.warning_amber_rounded,
              color: Colors.orange,
            ),
          ),

          const SizedBox(width: 12),

          // 📄 Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Important Disclaimer",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                // 🔶 Highlight Box
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(color: Colors.orange, width: 3),
                    ),
                  ),
                  child: const Text(
                    "AgriSense provides informational and educational content only. The recommendations and advice provided by the app should not be considered as professional agricultural advice.",
                    style: TextStyle(fontSize: 13, height: 1.4),
                  ),
                ),

                _buildSection(
                  "Professional Consultation:",
                  "Always consult with qualified agricultural professionals, agronomists, or local farming experts before making significant farming decisions.",
                ),

                _buildSection(
                  "AI Limitations:",
                  "While our disease detection uses advanced AI, it may not be 100% accurate. Verify findings with laboratory testing when necessary.",
                ),

                _buildSection(
                  "Weather Data:",
                  "Weather forecasts are provided by third-party services and may not always be accurate. Use them as guidance only.",
                ),

                _buildSection(
                  "No Guarantees:",
                  "We do not guarantee crop yields, harvest success, or financial outcomes from using our recommendations.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
