import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:agrisense/core/constants/feature_constants.dart';
import 'package:agrisense/presentation/common/widgets/gradient_app_bar.dart';
import 'package:agrisense/presentation/common/widgets/tips_card.dart';

import 'package:agrisense/presentation/disease/state/disease_state.dart';
import 'package:agrisense/presentation/disease/widgets/upload_plant_image_card.dart';
import 'package:agrisense/presentation/disease/widgets/image_preview_card.dart';
import 'package:agrisense/presentation/disease/widgets/analyzing_card.dart';
import 'package:agrisense/presentation/disease/widgets/detection_result_card.dart';
import 'package:agrisense/presentation/disease/widgets/symptoms_card.dart';
import 'package:agrisense/presentation/disease/widgets/treatment_card.dart';
import 'package:agrisense/presentation/disease/widgets/prevention_card.dart';
import 'package:agrisense/presentation/disease/widgets/scan_another_button.dart';

class DiseaseScanScreen extends StatelessWidget {
  const DiseaseScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // This Consumer listens to the real AI model's state
    return Consumer<DiseaseState>(
      builder: (context, state, child) {
        return Scaffold(
          appBar: const GradientAppBar(
            title: "Disease Detection",
            subtitle: "AI-Powered Plant Analysis",
            colors: [Color(0xFFFB2C36), Color(0xFFFF6900)],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Error Message Display
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red),
                      ),
                      child: Text(
                        state.errorMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                // 1. Initial State (No Image Selected)
                if (!state.hasImage) ...[
                  UploadPlantImageCard(onImageSelected: state.onImageSelected),
                  const SizedBox(height: 16),
                  const TipsCard(
                    title: 'Photography Tips',
                    icon: Icons.camera_alt,
                    tips: [
                      'Ensure good lighting conditions',
                      'Focus on the affected area clearly',
                      'Avoid blurry images',
                      'Capture close-up details of symptoms',
                    ],
                  ),
                ],

                // 2. Image Selected State
                if (state.hasImage) ...[
                  ImagePreviewCard(
                    image: state.selectedImage!,
                    isAnalyzing: state.isAnalyzing,
                    onChangeImage: state.onChangeImage,
                    onDetectDisease: state
                        .detectDisease, // This now triggers the actual TFLite scan!
                  ),
                  const SizedBox(height: 16),
                ],

                // 3. Loading State
                if (state.isAnalyzing) const AnalyzingCard(),

                // 4. Result State
                if (state.hasResult) ...[
                  DetectionResultCard(result: state.result!),
                  const SizedBox(height: 16),
                  SymptomsCard(symptoms: state.result!.symptoms),
                  const SizedBox(height: 16),
                  TreatmentCard(treatments: state.result!.treatments),
                  const SizedBox(height: 16),
                  PreventionCard(preventions: state.result!.preventions),
                  const SizedBox(height: 30),
                  ScanAnotherButton(onTap: state.reset),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
