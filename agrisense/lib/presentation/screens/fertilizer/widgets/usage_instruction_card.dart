import 'package:flutter/material.dart';

class UsageInstructionCard extends StatelessWidget {
  const UsageInstructionCard({super.key});

  Widget step(String number, String text) {
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
            child: Text(number),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text))
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
                Image.asset("assets/images/document.png", height: 20),
                const SizedBox(width: 8),
                const Text(
                  "Usage Instructions",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),

            const SizedBox(height: 12),

            step("1", "Apply 40% as basal dose during land preparation"),
            step("2", "Apply 30% at tillering stage (20–25 days after planting)"),
            step("3", "Apply 30% at panicle initiation stage (40–45 days)"),
            step("4", "Mix thoroughly with soil and irrigate immediately"),

          ],
        ),
      ),
    );
  }
}