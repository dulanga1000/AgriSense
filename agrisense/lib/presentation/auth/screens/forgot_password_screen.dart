import 'package:flutter/material.dart';
import '../widgets/forgot_password_email_step.dart';
import '../widgets/forgot_password_verify_step.dart';
import '../widgets/forgot_password_reset_step.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  int currentStep = 1;

  void goToVerify() {
    setState(() {
      currentStep = 2;
    });
  }

  void goToReset() {
    setState(() {
      currentStep = 3;
    });
  }

  Widget getStepWidget() {
    switch (currentStep) {
      case 1:
        return ForgotPasswordEmailStep(onNext: goToVerify);
      case 2:
        return ForgotPasswordVerifyStep(onNext: goToReset);
      case 3:
        return const ForgotPasswordResetStep();
      default:
        return ForgotPasswordEmailStep(onNext: goToVerify);
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),

              // Current Step UI
              getStepWidget(),
            ],
          ),
        ),
      ),
    );
  }
}