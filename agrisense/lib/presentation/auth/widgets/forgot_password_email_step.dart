import 'package:flutter/material.dart';
import 'package:agrisense/presentation/common/widgets/custom_button.dart';
import 'package:agrisense/presentation/common/widgets/email_textfield.dart';
import 'package:agrisense/presentation/auth/widgets/reset_link_sent_widget.dart';

class ForgotPasswordEmailStep extends StatelessWidget {
  final TextEditingController emailController;
  final VoidCallback onNext;
  final bool isLoading;

  /// ✅ NEW
  final bool isEmailSent;
  final String sentEmail;
  final VoidCallback onBack;

  const ForgotPasswordEmailStep({
    super.key,
    required this.emailController,
    required this.onNext,
    required this.isLoading,
    required this.isEmailSent,
    required this.sentEmail,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {

    /// ✅ SHOW SUCCESS UI
    if (isEmailSent) {
      return ResetLinkSentWidget(
        email: sentEmail,
        onBack: onBack,
      );
    }

    /// ✅ DEFAULT EMAIL FORM
    return Column(
      children: [
        const SizedBox(height: 20),

        const Text(
          "Enter your email",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 10),

        EmailTextField(controller: emailController),

        const SizedBox(height: 20),

        isLoading
            ? const CircularProgressIndicator()
            : CustomButton(
                text: "Send Reset Link",
                onPressed: onNext,
              ),
      ],
    );
  }
}