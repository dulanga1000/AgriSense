import 'package:flutter/material.dart';
import 'package:agrisense/presentation/home/widgets/home_header.dart';
import 'package:agrisense/presentation/home/widgets/plant_disease_scanner_card.dart';
import 'package:agrisense/presentation/home/widgets/feature_grid.dart';
import 'package:agrisense/presentation/home/widgets/farming_tips_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            const FarmingTipsSection(),
          ],
        ),
      ),
    );
  }
}
