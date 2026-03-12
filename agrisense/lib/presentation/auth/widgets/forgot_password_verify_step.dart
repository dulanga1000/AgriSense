import 'package:flutter/material.dart';
import 'otp_input_box.dart';
import 'step_indicator.dart';

class ForgotPasswordVerifyStep extends StatelessWidget {
  final VoidCallback onNext;
  final String email;

  final TextEditingController c1;
  final TextEditingController c2;
  final TextEditingController c3;
  final TextEditingController c4;
  final TextEditingController c5;
  final TextEditingController c6;

  const ForgotPasswordVerifyStep({
    super.key,
    required this.onNext,
    required this.email,
    required this.c1,
    required this.c2,
    required this.c3,
    required this.c4,
    required this.c5,
    required this.c6,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

          /// Step Indicator
          const StepIndicator(currentStep: 2),

          const SizedBox(height: 20),

          /// Card
          Center(
            child: Container(
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

                  /// Icon Circle
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0E8F3E).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.key,
                      color: Color(0xFF0E8F3E),
                      size: 32,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Title
                  const Text(
                    "Enter Verification Code",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// Description (Dynamic Email)
                  Text(
                    "We sent a 6-digit code to $email",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// OTP Boxes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OtpInputBox(controller: c1),
                      OtpInputBox(controller: c2),
                      OtpInputBox(controller: c3),
                      OtpInputBox(controller: c4),
                      OtpInputBox(controller: c5),
                      OtpInputBox(controller: c6),
                    ],
                  ),

                  const SizedBox(height: 30),

                  /// Verify Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: onNext,
                      icon: const Icon(Icons.verified),
                      label: const Text(
                        "Verify Code",
                        style: TextStyle(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0E8F3E),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  /// Resend timer
                  const Text(
                    "Resend code in 58s",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}