import 'package:flutter/material.dart';
import '../constants/terms_constants.dart';

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
          Text(
            TermsConstants.terminationTitle,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),

          Text(
            TermsConstants.terminationDescription,
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),

          const SizedBox(height: 10),

          ...TermsConstants.terminationItems.map((e) => _buildItem(e)).toList(),

          const SizedBox(height: 10),

          Text(
            TermsConstants.terminationFooter,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black54,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
