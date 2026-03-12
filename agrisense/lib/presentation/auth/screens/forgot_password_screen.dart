import 'package:flutter/material.dart';
import 'package:agrisense/presentation/auth/widgets/forgot_password_email_step.dart';
import 'package:agrisense/presentation/auth/widgets/forgot_password_verify_step.dart';
import 'package:agrisense/presentation/auth/widgets/forgot_password_reset_step.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  int currentStep = 1;

  /// Controllers
  final TextEditingController emailController = TextEditingController();

  final TextEditingController c1 = TextEditingController();
  final TextEditingController c2 = TextEditingController();
  final TextEditingController c3 = TextEditingController();
  final TextEditingController c4 = TextEditingController();
  final TextEditingController c5 = TextEditingController();
  final TextEditingController c6 = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  /// Go to Verify Step
  void goToVerify() {
    setState(() {
      currentStep = 2;
    });
  }

  /// Go to Reset Step
  void goToReset() {
    setState(() {
      currentStep = 3;
    });
  }

  /// Return correct step widget
  Widget getStepWidget() {
    switch (currentStep) {

      /// STEP 1 — EMAIL
      case 1:
        return ForgotPasswordEmailStep(
          emailController: emailController,
          onNext: goToVerify,
        );

      /// STEP 2 — VERIFY
      case 2:
        return ForgotPasswordVerifyStep(
          email: emailController.text,   // ✅ pass entered email
          onNext: goToReset,
          c1: c1,
          c2: c2,
          c3: c3,
          c4: c4,
          c5: c5,
          c6: c6,
        );

      /// STEP 3 — RESET
      case 3:
        return ForgotPasswordResetStep(
          passwordController: passwordController,
          confirmController: confirmController,
          onReset: () {
            Navigator.pop(context);
          },
        );

      default:
        return ForgotPasswordEmailStep(
          emailController: emailController,
          onNext: goToVerify,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9F5E1),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0E8F3E),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),

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
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),

            Expanded(
              child: SingleChildScrollView(
                child: getStepWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}