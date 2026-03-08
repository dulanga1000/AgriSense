import 'package:flutter/material.dart';

class FertilizerResultCard extends StatelessWidget {
  const FertilizerResultCard({super.key});

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
                Image.asset("assets/images/cube.png", height: 20),
                const SizedBox(width: 8),
                const Text(
                  "Recommended Fertilizer",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),

            const SizedBox(height: 12),

            const Text(
              "NPK Complex Fertilizer + Urea",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Total Quantity"),
                    Text(
                      "480 kg",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("NPK Ratio"),
                    Text(
                      "20:10:10",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                )

              ],
            )
          ],
        ),
      ),
    );
  }
}