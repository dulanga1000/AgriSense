import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrisense/core/di/service_locator.dart';
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
      create: (_) => sl<FertilizerState>(),
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
            return Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Form
                      FertilizerForm(
                        onSubmit: (cropType, landSize) {
                          FocusScope.of(context).unfocus(); // close keyboard
                          state.getRecommendation(cropType, landSize);
                        },
                      ),
                      const SizedBox(height: 16),

                      // ❌ Error UI
                      if (state.error != null)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.red[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            state.error!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),

                      // ✅ Results
                      if (state.recommendation != null) ...[
                        FertilizerResultCard(model: state.recommendation!),
                        const SizedBox(height: 16),
                        UsageInstructionCard(model: state.recommendation!),
                        const SizedBox(height: 16),
                        ApplicationTimingCard(model: state.recommendation!),
                        const SizedBox(height: 16),
                        CostCard(
                          estimatedCost:
                              state.recommendation!.estimatedCost,
                        ),
                        const SizedBox(height: 16),
                        const ImportantNotesCard(),
                      ],
                    ],
                  ),
                ),

                // 🔄 Loading Overlay (better UX)
                if (state.isLoading)
                  Container(
                    color: Colors.black.withValues(alpha: 0.3),
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
              ],
            );
          },
        ),
        bottomNavigationBar: Builder(
          builder: (context) => BottomNavBarWidget(
            currentIndex: 0,
            highlightSelected: false,
            onTap: (index) =>
                MainTabNavigator.goToTab(context, index),
          ),
        ),
      ),
    );
  }
}
