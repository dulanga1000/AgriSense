import 'package:flutter/material.dart';
import 'package:agrisense/presentation/common/widgets/app_back_button.dart';
import 'package:agrisense/presentation/disease/widgets/upload_plant_image_card.dart';

class DiseaseScanScreen extends StatelessWidget {
  const DiseaseScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        leading: const AppBackButton(fallbackIndex: 0),
        title: const Column(
          children: [
            Text(
              "Disease Detection",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 2),
            Text(
              "AI-Powered Plant Analysis",
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFB2C36), Color(0xFFFF6900)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: const Column(children: [UploadPlantImageCard()]),
      ),
    );
  }
}
