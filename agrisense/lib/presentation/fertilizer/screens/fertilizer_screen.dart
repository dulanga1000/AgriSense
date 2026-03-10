import 'package:flutter/material.dart';
import 'package:agrisense/presentation/fertilizer/widgets/application_timing_card.dart';
import 'package:agrisense/presentation/fertilizer/widgets/cost_card.dart';
import 'package:agrisense/presentation/fertilizer/widgets/fertilizer_form.dart';
import 'package:agrisense/presentation/fertilizer/widgets/fertilizer_result_card.dart';
import 'package:agrisense/presentation/fertilizer/widgets/important_notes_card.dart';
import 'package:agrisense/presentation/fertilizer/widgets/usage_instruction_card.dart';

class FertilizerScreen extends StatefulWidget {
  const FertilizerScreen({super.key});

  @override
  State<FertilizerScreen> createState() => _FertilizerScreenState();
}

class _FertilizerScreenState extends State<FertilizerScreen> {
  bool showResult = false;

  void showRecommendation() {
    setState(() {
      showResult = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white, // makes back arrow white

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Fertilizer Guide", style: TextStyle(color: Colors.white)),
            Text(
              "Smart recommendations",
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            /// FORM
            FertilizerForm(onSubmit: showRecommendation),

            const SizedBox(height: 16),

            /// SHOW RESULTS ONLY AFTER BUTTON CLICK
            if (showResult) ...[
              const FertilizerResultCard(),
              const SizedBox(height: 16),

              const UsageInstructionCard(),
              const SizedBox(height: 16),

              const ApplicationTimingCard(),
              const SizedBox(height: 16),

              const CostCard(),
              const SizedBox(height: 16),

              const ImportantNotesCard(),
            ],
          ],
        ),
      ),
    );
  }
}
