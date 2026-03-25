import 'package:flutter/material.dart';

class TermsNoticeWidget extends StatelessWidget {
  const TermsNoticeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: Colors.green.shade700, width: 4),
        ),
      ),
      child: const Text(
        "By using AgriSense, you acknowledge that you have read, understood, and agree to be bound by these Terms of Service.",
        style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.4),
      ),
    );
  }
}
