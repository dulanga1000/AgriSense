import 'package:flutter/material.dart';

import 'package:agrisense/presentation/common/widgets/bottom_nav_bar.dart';
import 'package:agrisense/presentation/home/screens/home_screen.dart';
import 'package:agrisense/presentation/disease/disease_scan_screen.dart';
import 'package:agrisense/presentation/weather/screens/weather_screen.dart';
import 'package:agrisense/presentation/profile/screens/profile_screen.dart';

import 'package:agrisense/presentation/fertilizer/widgets/application_timing_card.dart';
import 'package:agrisense/presentation/fertilizer/widgets/cost_card.dart';
import 'package:agrisense/presentation/fertilizer/widgets/fertilizer_form.dart';
import 'package:agrisense/presentation/fertilizer/widgets/fertilizer_result_card.dart';
import 'package:agrisense/presentation/fertilizer/widgets/important_notes_card.dart';
import 'package:agrisense/presentation/fertilizer/widgets/usage_instruction_card.dart';

import 'package:agrisense/data/models/fertilizer_model.dart';
import 'package:agrisense/data/repositories/fertilizer_repository.dart';

class FertilizerScreen extends StatefulWidget {
  const FertilizerScreen({super.key});

  @override
  State<FertilizerScreen> createState() => _FertilizerScreenState();
}

class _FertilizerScreenState extends State<FertilizerScreen> {
  FertilizerModel? recommendation;
  final FertilizerRepository repository = FertilizerRepository();

  /// Bottom nav selected index
  int currentIndex = 0;

  void showRecommendation(String cropType, double landSize) {
    setState(() {
      recommendation = repository.getRecommendation(cropType, landSize);
    });
  }

  void onNavTap(int index) {
    setState(() {
      currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DiseaseScanScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const WeatherScreen()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ProfileScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Fertilizer Guide"),
            Text(
              "Smart recommendations",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            FertilizerForm(onSubmit: showRecommendation),
            const SizedBox(height: 16),
            if (recommendation != null) ...[
              FertilizerResultCard(model: recommendation!),
              const SizedBox(height: 16),
              const UsageInstructionCard(),
              const SizedBox(height: 16),
              const ApplicationTimingCard(),
              const SizedBox(height: 16),
              CostCard(estimatedCost: recommendation!.estimatedCost),
              const SizedBox(height: 16),
              const ImportantNotesCard(),
            ],
          ],
        ),
      ),

      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: 0, // Set Fertilizer as selected (if index 0 is home, adjust accordingly)
        onTap: onNavTap,
      ),
    );
  }
}