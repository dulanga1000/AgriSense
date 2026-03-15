import 'package:flutter/material.dart';
import 'package:agrisense/data/models/farming_tip_model.dart';
import 'package:agrisense/presentation/home/widgets/home_header.dart';
import 'package:agrisense/presentation/home/widgets/plant_disease_scanner_card.dart';
import 'package:agrisense/presentation/home/widgets/feature_grid.dart';
import 'package:agrisense/presentation/home/widgets/farming_tips_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<FarmingTip> _dummyTips = [
    FarmingTip(
      id: 1,
      description: "Good day for rice cultivation - high humidity detected",
      type: "plant",
    ),
    FarmingTip(
      id: 2,
      description:
          "Light rain expected tomorrow - postpone pesticide application",
      type: "rain",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HomeHeader(),
            const SizedBox(height: 16),
            const PlantDiseaseScannerCard(),
            const SizedBox(height: 16),
            const FeatureGrid(),
            const SizedBox(height: 16),
            const FarmingTipsSection(tips: _dummyTips),
          ],
        ),
      ),
    );
  }
}
