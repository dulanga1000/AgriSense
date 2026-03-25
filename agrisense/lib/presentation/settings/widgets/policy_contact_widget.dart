import 'package:flutter/material.dart';

class PolicyContactWidget extends StatelessWidget {
  const PolicyContactWidget({super.key});

  Widget _buildItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade700,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔔 Title
          const Row(
            children: [
              Icon(Icons.notifications_none, color: Colors.white),
              SizedBox(width: 8),
              Text(
                "Contact Us",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          const Text(
            "If you have any questions or concerns about this Privacy Policy or your data, please contact us:",
            style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
          ),

          const SizedBox(height: 10),

          _buildItem(Icons.email_outlined, "Email: privacy@agrisense.com"),
          _buildItem(Icons.phone_outlined, "Phone: +94 11 234 5678"),
          _buildItem(
            Icons.location_on_outlined,
            "Address: AgriSense HQ, Colombo, Sri Lanka",
          ),
        ],
      ),
    );
  }
}
