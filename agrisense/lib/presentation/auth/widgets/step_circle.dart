import 'package:flutter/material.dart';

class StepCircle extends StatelessWidget {
  final int step;
  final int currentStep;
  final String label;

  const StepCircle({
    super.key,
    required this.step,
    required this.currentStep,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    bool isActive = step == currentStep;
    bool isCompleted = step < currentStep;

    Color backgroundColor;
    Widget child;

    if (isCompleted) {
      backgroundColor = const Color(0xFF0E8F3E);
      child = const Icon(Icons.check, color: Colors.white, size: 18);
    } 
    else if (isActive) {
      backgroundColor = const Color(0xFF0E8F3E);
      child = Text(
        step.toString(),
        style: const TextStyle(color: Colors.white),
      );
    } 
    else {
      backgroundColor = Colors.grey.shade300;
      child = Text(
        step.toString(),
        style: const TextStyle(color: Colors.black54),
      );
    }

    return Column(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: backgroundColor,
          child: child,
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}