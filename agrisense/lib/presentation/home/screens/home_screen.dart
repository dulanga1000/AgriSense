import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:agrisense/presentation/profile/state/profile_state.dart';
import 'package:agrisense/presentation/home/state/farming_tip_state.dart';

import '../widgets/home_header.dart';
import '../widgets/plant_disease_scanner_card.dart';
import '../widgets/feature_grid.dart';
import '../widgets/farming_tips_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<ProfileState>().user;
    final tipState = context.watch<FarmingTipState>();

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

            if (tipState.isLoading)
              const Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(),
              )
            else if (tipState.error != null)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  tipState.error!,
                  style: const TextStyle(color: Colors.red),
                ),
              )
            else
              FarmingTipsSection(tips: tipState.tips),
          ],
        ),
      ),
    );
  }
}
