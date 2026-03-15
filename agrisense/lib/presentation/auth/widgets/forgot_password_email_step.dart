import 'package:flutter/material.dart';
import 'package:agrisense/presentation/auth/widgets/step_indicator.dart';
import 'package:agrisense/presentation/common/widgets/auth_snackbar.dart';
import 'package:agrisense/presentation/common/widgets/auth_button.dart';
import 'package:agrisense/presentation/common/widgets/auth_card.dart';

class ForgotPasswordEmailStep extends StatelessWidget {
  final VoidCallback onNext;
  final TextEditingController emailController;

  const ForgotPasswordEmailStep({
    super.key,
    required this.onNext,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const StepIndicator(currentStep: 1),
          const SizedBox(height: 20),

          AuthCard(
            child: Column(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0E8F3E).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.email_outlined,
                    color: Color(0xFF0E8F3E),
                    size: 32,
                  ),
                ),
                const SizedBox(height: 20),

                const Text(
                  "Enter Your Email",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                const Text(
                  "We'll send you a verification code to reset your password",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 25),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Email Address",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 8),

                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    prefixIcon: const Icon(Icons.email_outlined),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFF0E8F3E),
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                AuthButton(
                  text: "Send Verification Code",
                  icon: Icons.mail_outline,
                  onPressed: () {
                    final email = emailController.text.trim();

                    if (email.isEmpty) {
                      AuthSnackBar.showError(
                        context,
                        "Please enter your email",
                      );
                      return;
                    }

                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(email)) {
                      AuthSnackBar.showError(
                        context,
                        "Enter a valid email address",
                      );
                      return;
                    }

                    AuthSnackBar.showSuccess(
                      context,
                      "Verification code sent to your email!",
                    );
                    onNext();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
