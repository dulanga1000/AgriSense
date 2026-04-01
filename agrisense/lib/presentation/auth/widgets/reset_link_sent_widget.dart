import 'package:flutter/material.dart';

class ResetLinkSentWidget extends StatelessWidget {
  final String email;
  final VoidCallback onBack;

  const ResetLinkSentWidget({
    super.key,
    required this.email,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),

        const Icon(Icons.mark_email_read_rounded,
            color: Colors.green, size: 80),

        const SizedBox(height: 20),

        const Text(
          "Check your email",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 10),

        const Text(
          "Password reset link sent to",
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 5),

        Text(
          email,
          style: const TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 25),

        TextButton(
          onPressed: onBack,
          child: const Text("Back"),
        ),
      ],
    );
  }
}