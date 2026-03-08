import 'package:flutter/material.dart';

class ApplicationTimingCard extends StatelessWidget {
  const ApplicationTimingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [

            Image.asset(
              'assets/images/timer.png',
              width: 30,
              height: 30,
            ),

            const SizedBox(width: 10),

            const Text(
              "Application Timing\nSplit application in 3 stages",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        ),
      ),
    );
  }
}