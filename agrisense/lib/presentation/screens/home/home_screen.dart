import 'package:flutter/material.dart';
import 'package:agrisense/presentation/screens/home/widgets/home_header.dart';
import 'package:agrisense/presentation/screens/home/widgets/plant_disease_scanner_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [const HomeHeader(), const PlantDiseaseScannerCard()],
      ),
    );
  }
}
