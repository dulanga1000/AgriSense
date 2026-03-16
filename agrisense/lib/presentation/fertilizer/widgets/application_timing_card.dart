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
          children: [
            Image.asset("assets/images/timer.png", width: 30, height: 30),
            const SizedBox(width: 10),

            Text(
              "Application Timing\n${model.applicationTiming}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
