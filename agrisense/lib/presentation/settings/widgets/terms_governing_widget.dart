import 'package:flutter/material.dart';

class TermsGoverningWidget extends StatelessWidget {
  const TermsGoverningWidget({super.key});

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
            "Governing Law",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 6),

          Text(
            "These Terms of Service shall be governed by and construed in accordance with the laws of Sri Lanka, without regard to its conflict of law provisions. Any disputes arising from these Terms shall be resolved in the courts of Sri Lanka.",
            style: TextStyle(fontSize: 13, color: Colors.black54, height: 1.5),
          ),
        ],
      ),
    );
  }
}
