import 'package:flutter/material.dart';

class PolicySecurityWidget extends StatelessWidget {
  const PolicySecurityWidget({super.key});

  Widget _buildSecurityItem({
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
          // 🔒 Icon box
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.lock_outline, color: Colors.red),
          ),

          const SizedBox(width: 12),

          // 📄 Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Data Security",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 6),

                const Text(
                  "We implement industry-standard security measures to protect your personal information:",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),

                _buildSecurityItem(
                  icon: Icons.lock,
                  color: Colors.orange,
                  title: "Encryption",
                  description:
                      "All data is encrypted in transit and at rest using AES-256 encryption",
                ),

                _buildSecurityItem(
                  icon: Icons.shield,
                  color: Colors.blue,
                  title: "Secure Servers",
                  description:
                      "Data stored on secure, protected servers with regular backups",
                ),

                _buildSecurityItem(
                  icon: Icons.person,
                  color: Colors.purple,
                  title: "Access Control",
                  description:
                      "Limited access to personal data on a need-to-know basis",
                ),

                _buildSecurityItem(
                  icon: Icons.search,
                  color: Colors.teal,
                  title: "Regular Audits",
                  description:
                      "Periodic security audits and vulnerability assessments",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
