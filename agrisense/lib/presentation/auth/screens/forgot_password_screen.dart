import 'package:flutter/material.dart';
import 'package:agrisense/core/routes/app_routes.dart';
import 'package:agrisense/presentation/auth/widgets/forgot_password_email_step.dart';
import 'package:agrisense/presentation/auth/widgets/forgot_password_reset_step.dart';
import 'package:agrisense/presentation/auth/widgets/forgot_password_verify_step.dart';
import 'package:agrisense/presentation/common/widgets/gradient_app_bar.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  int currentStep = 1;

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
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
          },
        );
    }
  }

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
      appBar: GradientAppBar(
        title: "Forgot Password",
        subtitle: "Reset your account password",
        colors: const [Color(0xFF0E8F3E), Color(0xFF087F35)],
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
            },
          ),
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
