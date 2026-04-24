import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final List<String> steps;

  const StepIndicator({
    super.key,
    required this.currentStep,
    this.steps = const ["Email", "Verify", "Reset"],
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20), // ✅ EDGE GAP FIX
      child: Row(
        children: List.generate(steps.length * 2 - 1, (i) {
          // EVEN = STEP, ODD = LINE
          if (i.isEven) {
            final index = i ~/ 2;

            return Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildCircle(index),
                  const SizedBox(height: 8),
                  Text(
                    steps[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: _getTextColor(index),
                    ),
                  ),
                ],
              ),
            );
          } else {
            final lineIndex = (i - 1) ~/ 2;

            return Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 18),
                height: 3,
                color: lineIndex < currentStep
                    ? const Color(0xFF0E8F3E)
                    : Colors.grey.shade300,
              ),
            );
          }
        }),
      ),
    );
  }

  Widget _buildCircle(int index) {
    bool isActive = index == currentStep;
    bool isCompleted = index < currentStep;

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCompleted || isActive
            ? const Color(0xFF0E8F3E)
            : Colors.grey.shade300,
      ),
      child: Center(
        child: isCompleted
            ? const Icon(Icons.check, size: 18, color: Colors.white)
            : Text(
                '${index + 1}',
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Color _getTextColor(int index) {
    if (index == currentStep) return const Color(0xFF0E8F3E);
    if (index < currentStep) return Colors.black;
    return Colors.grey;
  }
}
