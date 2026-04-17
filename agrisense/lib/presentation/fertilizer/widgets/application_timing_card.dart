import 'package:flutter/material.dart';
import 'package:agrisense/data/models/fertilizer_model.dart';

class ApplicationTimingCard extends StatelessWidget {
  final FertilizerModel model;

  const ApplicationTimingCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.schedule, size: 30, color: Colors.green),
            const SizedBox(width: 10),

            Expanded(
              child: Text(
                "Application Timing\n${model.applicationTiming}",
                style: const TextStyle(fontWeight: FontWeight.bold),
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
