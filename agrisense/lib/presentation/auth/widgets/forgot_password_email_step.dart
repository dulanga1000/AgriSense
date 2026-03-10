import 'package:flutter/material.dart';
import 'step_indicator.dart';

class ForgotPasswordEmailStep extends StatelessWidget {
  final VoidCallback onNext;

  const ForgotPasswordEmailStep({
    super.key,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();

    return SingleChildScrollView(
      child: Column(
        children: [

          // step indicator
          const StepIndicator(currentStep: 1),

          const SizedBox(height: 20),

          // card
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15,
                  offset: Offset(0, 6),
                ),
              ],
            ),

            child: Column(
              children: [

                // icon circle
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.email_outlined,
                    color: Color(0xFF0E8F3E),
                    size: 32,
                  ),
                ),

                const SizedBox(height: 20),

                // title
                const Text(
                  "Enter Your Email",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                // description
                const Text(
                  "We'll send you a verification code to reset your password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 25),

                // label
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Email Address",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // email field
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "your@email.com",
                    prefixIcon: const Icon(Icons.email_outlined),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // send button
                SizedBox(
                width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: onNext,
                    icon: const Icon(Icons.mail_outline),
                    label: const Text(
                      "Send Verification Code",
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0E8F3E),
                      foregroundColor: Colors.white, // sets icon + text color
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}