import 'package:flutter/material.dart';

class TermsResponsibilityWidget extends StatelessWidget {
  const TermsResponsibilityWidget({super.key});

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
          // 👥 Icon Box
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.people_outline, color: Colors.orange),
          ),

          const SizedBox(width: 12),

          // 📄 Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "User Responsibilities",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 6),

                const Text(
                  "As a user of AgriSense, you agree to:",
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),

                const SizedBox(height: 10),

                _buildItem(
                  "Provide accurate and truthful information when registering and using the app",
                ),
                _buildItem(
                  "Maintain the security and confidentiality of your account credentials",
                ),
                _buildItem(
                  "Use the app only for lawful purposes and in accordance with these Terms",
                ),
                _buildItem(
                  "Not attempt to gain unauthorized access to any part of the app",
                ),
                _buildItem(
                  "Not use the app to transmit viruses, malware, or harmful code",
                ),
                _buildItem(
                  "Not interfere with or disrupt the service or servers",
                ),
                _buildItem(
                  "Respect the intellectual property rights of AgriSense and third parties",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
