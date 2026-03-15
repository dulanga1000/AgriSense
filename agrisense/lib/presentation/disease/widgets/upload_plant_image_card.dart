import 'package:flutter/material.dart';
import '../widgets/gradient_icon_button.dart';

class UploadPlantImageCard extends StatelessWidget {
  const UploadPlantImageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                color: Color(0xFFFFE5E5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.eco_outlined,
                size: 48,
                color: Color(0xFFFB2C36),
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "Upload Plant Image",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              "Tap to upload an image of your plant for disease diagnosis.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),

            const SizedBox(height: 8),

            ActionButton(
              icon: Icons.camera_alt_outlined,
              text: "Take Photo",
              isPrimary: true,
              onPressed: () {},
            ),

            const SizedBox(height: 16),

            ActionButton(
              icon: Icons.upload_outlined,
              text: "Upload from Gallery",
              isPrimary: false,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
