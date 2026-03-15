import 'package:flutter/material.dart';
import 'package:agrisense/presentation/common/widgets/app_back_button.dart';
import 'package:agrisense/presentation/common/widgets/bottom_nav_bar.dart';
import 'package:agrisense/presentation/common/navigation/main_tab_navigator.dart';
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

  void showRecommendation(String cropType, double landSize) {
    setState(() {
      recommendation = repository.getRecommendation(cropType, landSize);
    });
  }

  void _onNavTap(int index) {
    MainTabNavigator.goToTab(context, index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        leading: const AppBackButton(fallbackIndex: 0),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Fertilizer Guide"),
            Text("Smart recommendations", style: TextStyle(fontSize: 12)),
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
        currentIndex: 0,
        onTap: _onNavTap,
      ),
    );
  }
}
