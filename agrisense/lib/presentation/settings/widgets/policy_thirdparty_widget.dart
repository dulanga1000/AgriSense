import 'package:flutter/material.dart';

class PolicyThirdPartyWidget extends StatelessWidget {
  const PolicyThirdPartyWidget({super.key});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Third-Party Services",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),

          const Text(
            "AgriSense may use third-party services for:",
            style: TextStyle(fontSize: 13, color: Colors.black54),
          ),

          const SizedBox(height: 10),

          _buildItem("Weather data and forecasts"),
          _buildItem("AI-powered disease detection"),
          _buildItem("Cloud storage and analytics"),
          _buildItem("Payment processing (if applicable)"),

          const SizedBox(height: 10),

          const Text(
            "These services have their own privacy policies and we ensure they meet our security standards.",
            style: TextStyle(fontSize: 13, color: Colors.black54, height: 1.4),
          ),
        ],
      ),
    );
  }
}
