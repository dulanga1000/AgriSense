import 'package:flutter/material.dart';
import 'package:agrisense/core/routes/app_routes.dart';

class PlantDiseaseScannerCard extends StatelessWidget {
  const PlantDiseaseScannerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.camera_alt, size: 48, color: Colors.green),
            const SizedBox(height: 12),
            const Text(
              'Plant Disease Scanner',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Identify plant diseases by taking a photo of your plant.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to disease scanner screen
                Navigator.pushNamed(context, AppRoutes.diseaseScan);
              },
              child: const Text('Scan Now'),
            ),
          ],
        ),
      ),
    );
  }
}
