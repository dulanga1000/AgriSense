import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:agrisense/core/routes/app_routes.dart';
import 'package:agrisense/presentation/common/widgets/app_back_button.dart';
import 'package:agrisense/presentation/common/widgets/auth_card.dart';
import 'package:agrisense/presentation/common/widgets/auth_snackbar.dart';
import 'package:agrisense/presentation/auth/widgets/forgot_password_email_step.dart';
import 'package:agrisense/presentation/auth/widgets/forgot_password_reset_step.dart';
import 'package:agrisense/presentation/auth/widgets/step_indicator.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  int currentStep = 1;

  final TextEditingController emailController = TextEditingController();

  bool isLoading = false;

  bool isEmailSent = false;
  String sentEmail = "";

  /// 🔥 BACKEND CALL (FIREBASE)
  Future<void> sendResetEmail() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      AuthSnackBar.showError(context, "Please enter your email");
      return;
    }

    setState(() => isLoading = true);

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      if (!mounted) return;

      setState(() {
        isEmailSent = true;
        sentEmail = email;
      });

      AuthSnackBar.showSuccess(
        context,
        "Reset link sent to $email",
      );

    } on FirebaseAuthException catch (e) {

      if (!mounted) return;

      String message = "Something went wrong";

      if (e.code == 'user-not-found') {
        message = "No user found with this email";
      } else if (e.code == 'invalid-email') {
        message = "Invalid email address";
      }

      AuthSnackBar.showError(context, message);

    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  /// 🔹 STEP BUILDER
  Widget buildStepContent() {
    if (currentStep == 1) {
      return ForgotPasswordEmailStep(
        emailController: emailController,
        onNext: sendResetEmail,
        isLoading: isLoading,
        isEmailSent: isEmailSent,
        sentEmail: sentEmail,
        onBack: () {
          setState(() {
            isEmailSent = false;
          });
        },
      );
    } else {
      return ForgotPasswordResetStep(
        onResetSuccess: () {
          Navigator.pop(context);
        },
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9F5E1),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0E8F3E),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: const AppBackButton(fallbackRoute: AppRoutes.login),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Forgot Password",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Reset your account password",
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          StepIndicator(currentStep: currentStep),

          Expanded(
            child: Center(
              child: AuthCard(
                child: buildStepContent(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}