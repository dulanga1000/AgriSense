import 'package:flutter/material.dart';
import '../constants/terms_constants.dart';

class TermsDisclaimerWidget extends StatelessWidget {
  const TermsDisclaimerWidget({super.key});

  Widget _buildSection(DisclaimerSection section) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(height: 4),
          Text(
            section.description,
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
          // ⚠️ Icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: TermsConstants.disclaimerColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              TermsConstants.disclaimerIcon,
              color: TermsConstants.disclaimerColor,
            ),
          ),

          const SizedBox(width: 12),

          // 📄 Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TermsConstants.disclaimerTitle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                // 🔶 Highlight Box
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: const Border(
                      left: BorderSide(color: Colors.orange, width: 3),
                    ),
                  ),
                  child: Text(
                    TermsConstants.disclaimerHighlight,
                    style: const TextStyle(fontSize: 13, height: 1.4),
                  ),
                ),

                // 🔁 Sections
                ...TermsConstants.disclaimerSections
                    .map((e) => _buildSection(e))
                    .toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
