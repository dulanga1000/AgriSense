import 'package:flutter/material.dart';
import 'package:agrisense/presentation/auth/widgets/step_indicator.dart';
import 'package:agrisense/presentation/common/widgets/auth_card.dart';
import 'package:agrisense/presentation/common/widgets/auth_snackbar.dart';
import 'package:agrisense/presentation/common/widgets/custom_button.dart';
import 'package:agrisense/presentation/common/widgets/email_textfield.dart';
import 'package:agrisense/core/services/auth_api_service.dart';

class ForgotPasswordEmailStep extends StatelessWidget {
  final VoidCallback onNext;
  final TextEditingController emailController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ForgotPasswordEmailStep({
    super.key,
    required this.onNext,
    required this.emailController,
  });

  void onSend(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    try {
      await AuthApiService.sendOtp(emailController.text);

      AuthSnackBar.showSuccess(context, 'OTP sent to your email!');
      onNext();
    } catch (e) {
      AuthSnackBar.showError(context, 'Email not registered');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const StepIndicator(currentStep: 0),
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
                    onPressed: () => onSend(context), // ✅ FIX
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
