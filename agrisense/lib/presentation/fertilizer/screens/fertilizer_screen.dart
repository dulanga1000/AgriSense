import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrisense/presentation/common/widgets/app_back_button.dart';
import 'package:agrisense/presentation/common/widgets/bottom_nav_bar.dart';
import 'package:agrisense/presentation/common/navigation/main_tab_navigator.dart';
import 'package:agrisense/presentation/fertilizer/state/fertilizer_state.dart';
import 'package:agrisense/presentation/fertilizer/widgets/application_timing_card.dart';
import 'package:agrisense/presentation/fertilizer/widgets/cost_card.dart';
import 'package:agrisense/presentation/fertilizer/widgets/fertilizer_form.dart';
import 'package:agrisense/presentation/fertilizer/widgets/fertilizer_result_card.dart';
import 'package:agrisense/presentation/fertilizer/widgets/important_notes_card.dart';
import 'package:agrisense/presentation/fertilizer/widgets/usage_instruction_card.dart';

class FertilizerScreen extends StatelessWidget {
  const FertilizerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FertilizerState(),
      child: Scaffold(
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
        body: Consumer<FertilizerState>(
          builder: (context, state, _) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  FertilizerForm(
                    onSubmit: (cropType, landSize) =>
                        state.getRecommendation(cropType, landSize),
                  ),
                  const SizedBox(height: 16),

                  // Loading
                  if (state.isLoading)
                    const Center(child: CircularProgressIndicator()),

                  // Results
                  if (!state.isLoading && state.recommendation != null) ...[
                    FertilizerResultCard(model: state.recommendation!),
                    const SizedBox(height: 16),
                    UsageInstructionCard(model: state.recommendation!),
                    const SizedBox(height: 16),
                    ApplicationTimingCard(model: state.recommendation!),
                    const SizedBox(height: 16),
                    CostCard(
                      estimatedCost: state.recommendation!.estimatedCost,
                    ),
                    const SizedBox(height: 16),
                    const ImportantNotesCard(),
                  ],
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: Builder(
          builder: (context) => BottomNavBarWidget(
            currentIndex: 0,
            highlightSelected: false,
            onTap: (index) => MainTabNavigator.goToTab(context, index),
          ),
        ),
      ),
    );
  }
}
