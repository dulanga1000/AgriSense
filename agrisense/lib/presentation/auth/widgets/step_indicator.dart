import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;

  const StepIndicator({super.key, required this.currentStep});

  Color _getStepColor(int step) {
    return currentStep >= step ? Colors.green : Colors.grey.shade400;
  }

  Widget _buildStep(int step, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: _getStepColor(step),
          child: currentStep > step
              ? const Icon(Icons.check, color: Colors.white, size: 18)
              : Text(
                  step.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildLine(bool active) {
    return Expanded(
      child: Container(
        height: 2,
        color: active ? Colors.green : Colors.grey.shade300,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          _buildStep(1, "Email"),
          _buildLine(currentStep >= 2),
          _buildStep(2, "Reset"),
        ],
      ),
    );
  }
}