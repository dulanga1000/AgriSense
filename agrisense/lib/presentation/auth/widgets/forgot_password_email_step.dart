import 'package:flutter/material.dart';
import 'package:agrisense/presentation/auth/widgets/step_indicator.dart';
import 'package:agrisense/presentation/common/widgets/auth_card.dart';
import 'package:agrisense/presentation/common/widgets/auth_snackbar.dart';
import 'package:agrisense/presentation/common/widgets/custom_button.dart';
import 'package:agrisense/presentation/common/widgets/email_textfield.dart';

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
    final formKey = GlobalKey<FormState>();

    void onSend() {
      if (!formKey.currentState!.validate()) return;

      AuthSnackBar.showSuccess(
        context,
        'Verification code sent to your email!',
      );
      onNext();
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          const StepIndicator(currentStep: 1),
          const SizedBox(height: 20),

          AuthCard(
            child: Form(
              key: formKey,
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
                    'Enter Your Email',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  const Text(
                    "We'll send you a verification code to reset your password",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 25),

                  EmailTextField(
                    controller: emailController,
                    label: 'Email Address',
                  ),

                  const SizedBox(height: 25),

                  CustomButton(
                    text: 'Send Verification Code',
                    icon: Icons.mail_outline,
                    onPressed: onSend,
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
