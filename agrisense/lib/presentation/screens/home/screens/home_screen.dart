import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:agrisense/presentation/screens/home/widgets/home_header.dart';
import 'package:agrisense/presentation/screens/home/widgets/plant_disease_scanner_card.dart';
import 'package:agrisense/presentation/screens/home/widgets/feature_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            HomeHeader(),
            SizedBox(height: 16),
            PlantDiseaseScannerCard(),
            SizedBox(height: 16),
            FeatureGrid(),
          ],
        ),
      ),
    );
  }
}
