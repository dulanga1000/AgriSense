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

class FertilizerScreen extends StatefulWidget {
  const FertilizerScreen({super.key});

  @override
  State<FertilizerScreen> createState() => _FertilizerScreenState();
}

class _FertilizerScreenState extends State<FertilizerScreen> {
  bool showResult = false;

  void showRecommendation() {
    setState(() {
      showResult = true;
    });
  }

  void _onNavTap(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;

      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DiseaseScanScreen()),
        );
        break;

      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const WeatherScreen()),
        );
        break;

      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
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
            Text(
              "Fertilizer Guide",
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "Smart recommendations",
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// FORM
            FertilizerForm(onSubmit: showRecommendation),

            const SizedBox(height: 16),

            /// SHOW RESULTS ONLY AFTER BUTTON CLICK
            if (showResult) ...[
              const FertilizerResultCard(),
              const SizedBox(height: 16),

              const UsageInstructionCard(),
              const SizedBox(height: 16),

              const ApplicationTimingCard(),
              const SizedBox(height: 16),

              const CostCard(),
              const SizedBox(height: 16),

              const ImportantNotesCard(),
            ],
          ],
        ),
      ),

      /// BOTTOM NAVIGATION BAR
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: 1,
        onTap: _onNavTap,
      ),
    );
  }
}