import 'package:flutter/material.dart';
import 'package:agrisense/presentation/auth/widgets/step_indicator.dart';
import 'package:agrisense/presentation/common/widgets/auth_snackbar.dart';
import 'package:agrisense/presentation/common/widgets/auth_button.dart';
import 'package:agrisense/presentation/common/widgets/auth_card.dart';
import 'package:agrisense/presentation/common/widgets/password_textfield.dart';

class ForgotPasswordResetStep extends StatefulWidget {
  final VoidCallback onResetSuccess;

  const ForgotPasswordResetStep({super.key, required this.onResetSuccess});

  @override
  State<ForgotPasswordResetStep> createState() =>
      _ForgotPasswordResetStepState();
}

class _ForgotPasswordResetStepState extends State<ForgotPasswordResetStep> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool hasUpper = false;
  bool hasLower = false;
  bool hasNumber = false;
  bool hasSpecial = false;
  bool hasLength = false;
  bool passwordsMatch = false;

  void validatePassword() {
    final password = newPasswordController.text;
    final confirm = confirmPasswordController.text;

    setState(() {
      hasLength = password.length >= 8;
      hasUpper = password.contains(RegExp(r'[A-Z]'));
      hasLower = password.contains(RegExp(r'[a-z]'));
      hasNumber = password.contains(RegExp(r'[0-9]'));
      hasSpecial = password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));
      passwordsMatch = password == confirm;
    });
  }

  bool get passwordValid =>
      hasUpper && hasLower && hasNumber && hasSpecial && hasLength;

  @override
  void initState() {
    super.initState();
    newPasswordController.addListener(validatePassword);
    confirmPasswordController.addListener(validatePassword);
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Widget ruleTile(String text, bool valid) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(
            valid ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 16,
            color: valid ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(color: valid ? Colors.green : Colors.grey),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const StepIndicator(currentStep: 3),
        const SizedBox(height: 20),

        AuthCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.purple.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.security,
                    color: Colors.purple,
                    size: 32,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              const Center(
                child: Text(
                  "Create New Password",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),

              const Center(
                child: Text(
                  "Choose a strong password for your account",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              const SizedBox(height: 25),

              const Text("New Password"),
              const SizedBox(height: 8),
              PasswordTextField(
                controller: newPasswordController,
                hintText: "Enter new password",
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Password must contain:",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    ruleTile("At least 8 characters", hasLength),
                    ruleTile("One uppercase letter", hasUpper),
                    ruleTile("One lowercase letter", hasLower),
                    ruleTile("One number", hasNumber),
                    ruleTile("One special character", hasSpecial),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const Text("Confirm Password"),
              const SizedBox(height: 8),
              PasswordTextField(
                controller: confirmPasswordController,
                hintText: "Confirm password",
              ),
              const SizedBox(height: 8),

              if (!passwordsMatch && confirmPasswordController.text.isNotEmpty)
                const Text(
                  "Passwords do not match",
                  style: TextStyle(color: Colors.red),
                ),

              if (passwordsMatch && confirmPasswordController.text.isNotEmpty)
                const Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 16),
                    SizedBox(width: 5),
                    Text(
                      "Passwords match",
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),

              const SizedBox(height: 20),

              AuthButton(
                text: "Reset Password",
                icon: Icons.lock,
                onPressed: () async {
                  if (!passwordValid) {
                    AuthSnackBar.showError(
                      context,
                      "Password does not meet requirements",
                    );
                    return;
                  }

                  if (!passwordsMatch) {
                    AuthSnackBar.showError(context, "Passwords do not match");
                    return;
                  }

                  AuthSnackBar.showSuccess(
                    context,
                    "Password reset successfully!",
                  );

                  await Future.delayed(const Duration(seconds: 1));
                  widget.onResetSuccess();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
