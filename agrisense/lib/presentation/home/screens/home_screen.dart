import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrisense/presentation/profile/state/profile_state.dart';

import 'package:agrisense/data/models/farming_tip_model.dart';
import '../widgets/home_header.dart';
import '../widgets/plant_disease_scanner_card.dart';
import '../widgets/feature_grid.dart';
import '../widgets/farming_tips_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<FarmingTip> _dummyTips = [
    FarmingTip(
      id: 1,
      description: "Good day for rice cultivation",
      type: "plant",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final user = context.watch<ProfileState>().user;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeHeader(user: user),
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
