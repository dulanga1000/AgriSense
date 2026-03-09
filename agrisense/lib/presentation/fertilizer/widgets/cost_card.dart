import 'package:flutter/material.dart';

class CostCard extends StatelessWidget {
  const CostCard({super.key});

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

                Image.asset(
                  'assets/images/money.png',
                  width: 24,
                  height: 24,
                ),

                const SizedBox(width: 8),

                const Text(
                  "Estimated Cost",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

              ],
            ),

            const SizedBox(height: 8),

            const Text(
              "LKR. 9600 (approx.)",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 4),

            const Text(
              "Prices may vary by location",
              style: TextStyle(fontSize: 12),
            )

          ],
        ),
      ),
    );
  }
}