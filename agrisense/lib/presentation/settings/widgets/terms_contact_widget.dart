import 'package:flutter/material.dart';

class TermsContactWidget extends StatelessWidget {
  const TermsContactWidget({super.key});

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
        gradient: const LinearGradient(
          colors: [Color(0xFF2E6CF6), Color(0xFF1C3FDB)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 📄 Title
          const Row(
            children: [
              Icon(Icons.description, color: Colors.white),
              SizedBox(width: 8),
              Text(
                "Questions About Terms?",
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
            "If you have any questions about these Terms of Service, please contact our legal team:",
            style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
          ),

          const SizedBox(height: 10),

          _buildItem(Icons.email_outlined, "Email: legal@agrisense.com"),
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
