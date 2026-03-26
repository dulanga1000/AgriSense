import 'package:flutter/material.dart';

class TermsTerminationWidget extends StatelessWidget {
  const TermsTerminationWidget({super.key});

  Widget _buildItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.close, color: Colors.red, size: 18),
          const SizedBox(width: 6),
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
            "Account Termination",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),

          const Text(
            "We reserve the right to suspend or terminate your account at any time if:",
            style: TextStyle(fontSize: 13, color: Colors.black54),
          ),

          const SizedBox(height: 10),

          _buildItem("You violate these Terms of Service"),
          _buildItem("You engage in fraudulent or illegal activities"),
          _buildItem("Your account has been inactive for an extended period"),
          _buildItem("We are required to do so by law"),

          const SizedBox(height: 10),

          const Text(
            "You may also delete your account at any time through the app settings.",
            style: TextStyle(fontSize: 13, color: Colors.black54, height: 1.4),
          ),
        ],
      ),
    );
  }
}
