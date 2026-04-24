import 'package:flutter/material.dart';
import 'package:agrisense/data/models/fertilizer_model.dart';

class UsageInstructionCard extends StatelessWidget {
  final FertilizerModel model;

  const UsageInstructionCard({super.key, required this.model});

  Widget _step(String number, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.green,
            child: Text(number, style: const TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.menu_book_outlined, color: Colors.green),
                const SizedBox(width: 8),
                const Text(
                  "Usage Instructions",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),

            ...model.usageSteps.asMap().entries.map(
              (e) => _step("${e.key + 1}", e.value),
            ),
          ],
        ),
      ),
    );
  }
}
