import 'package:flutter/material.dart';

class PolicyRightsWidget extends StatelessWidget {
  const PolicyRightsWidget({super.key});

  Widget _buildItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(color: Colors.blue)),
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
          // 📄 Icon Box
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.yellow.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.description_outlined, color: Colors.orange),
          ),

          const SizedBox(width: 12),

          // 📄 Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Your Rights",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 6),

                const Text(
                  "You have the right to:",
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),

                const SizedBox(height: 10),

                _buildItem("Access your personal data stored in the app"),
                _buildItem("Request correction of inaccurate data"),
                _buildItem("Delete your account and associated data"),
                _buildItem("Opt-out of marketing communications"),
                _buildItem("Export your data in a portable format"),
                _buildItem("Withdraw consent for data processing"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
