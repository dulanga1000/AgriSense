import 'package:flutter/material.dart';

class TermsModificationWidget extends StatelessWidget {
  const TermsModificationWidget({super.key});

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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Modifications to Terms",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 6),

          Text(
            "We reserve the right to modify or replace these Terms of Service at any time. We will provide notice of significant changes via email or in-app notification at least 30 days before the new terms take effect. Your continued use of the app after changes are made constitutes acceptance of the updated Terms.",
            style: TextStyle(fontSize: 13, color: Colors.black54, height: 1.5),
          ),
        ],
      ),
    );
  }
}
