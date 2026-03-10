import 'package:flutter/material.dart';

class FertilizerForm extends StatelessWidget {
  final VoidCallback onSubmit;

  const FertilizerForm({super.key, required this.onSubmit});

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
                Image.asset("assets/images/leaf.png", height: 20),
                const SizedBox(width: 8),
                const Text(
                  "Enter Crop Details",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 16),

            const Text("Crop Type"),

            const SizedBox(height: 6),

            DropdownButtonFormField(
              items: const [
                DropdownMenuItem(value: "Corn", child: Text("Corn")),
                DropdownMenuItem(value: "Rice", child: Text("Rice")),
                DropdownMenuItem(value: "Wheat", child: Text("Wheat")),
              ],
              onChanged: (value) {},
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),

            const SizedBox(height: 16),

            const Text("Land Size (Acres)"),

            const SizedBox(height: 6),

            const TextField(
              decoration: InputDecoration(
                hintText: "Enter land size",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: onSubmit,
                child: const Text(
                  "Get Recommendation",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
