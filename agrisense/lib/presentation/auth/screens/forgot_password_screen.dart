import 'package:flutter/material.dart';
import 'package:agrisense/presentation/common/widgets/app_back_button.dart';
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

  void goToStep(int step) {
    setState(() {
      currentStep = step;
    });
  }

  /// Prevent step overflow using switch
  Widget buildStep() {
    switch (currentStep) {
      case 1:
        return ForgotPasswordEmailStep(
          emailController: emailController,
          onNext: () => goToStep(2),
        );

      case 2:
        return ForgotPasswordVerifyStep(
          email: emailController.text,
          onNext: () => goToStep(3),
          c1: c1,
          c2: c2,
          c3: c3,
          c4: c4,
          c5: c5,
          c6: c6,
        );

      case 3:
      default:
        return ForgotPasswordResetStep(
          onResetSuccess: () {
            Navigator.pop(context);
          },
        );
    }
  }

  /// Dispose controllers (IMPORTANT)
  @override
  void dispose() {
    emailController.dispose();

    c1.dispose();
    c2.dispose();
    c3.dispose();
    c4.dispose();
    c5.dispose();
    c6.dispose();

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
        leading: const AppBackButton(fallbackIndex: 0),

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

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: buildStep(),
          ),
        ),
      ),
    );
  }
}
