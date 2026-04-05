import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:agrisense/presentation/common/widgets/custom_button.dart';
import 'package:agrisense/presentation/common/widgets/password_textfield.dart';
import 'package:agrisense/presentation/common/widgets/auth_snackbar.dart';

class ForgotPasswordResetStep extends StatefulWidget {
  final VoidCallback onResetSuccess;

  final String? oobCode;

  const ForgotPasswordResetStep({
    super.key,
    required this.onResetSuccess,
    this.oobCode,
  });

  @override
  State<ForgotPasswordResetStep> createState() =>
      _ForgotPasswordResetStepState();
}

class _ForgotPasswordResetStepState
    extends State<ForgotPasswordResetStep> {

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  bool isLoading = false;

  Future<void> resetPassword() async {
    final password = passwordController.text;
    final confirm = confirmController.text;

    if (password != confirm) {
      AuthSnackBar.showError(context, "Passwords do not match");
      return;
    }

    if (widget.oobCode == null) {
      AuthSnackBar.showError(
        context,
        "Please use the email link to reset password",
      );
      return;
    }

    try {
      setState(() => isLoading = true);

      await FirebaseAuth.instance.confirmPasswordReset(
        code: widget.oobCode!,
        newPassword: password,
      );

      if (!mounted) return;

      AuthSnackBar.showSuccess(context, "Password reset successful");

      widget.onResetSuccess();

    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      AuthSnackBar.showError(
        context,
        e.message ?? "Reset failed",
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),

        const Text(
          "Reset Password",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 10),

        PasswordTextField(
          controller: passwordController,
          hintText: "New Password",
        ),

        const SizedBox(height: 10),

        PasswordTextField(
          controller: confirmController,
          hintText: "Confirm Password",
        ),

        const SizedBox(height: 20),

        isLoading
            ? const CircularProgressIndicator()
            : CustomButton(
                text: "Reset Password",
                onPressed: resetPassword,
              ),
      ],
    );
  }
}