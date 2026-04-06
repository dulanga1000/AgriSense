import 'package:flutter/material.dart';
import 'package:agrisense/presentation/auth/widgets/forgot_password_email_step.dart';
import 'package:agrisense/presentation/auth/widgets/forgot_password_verify_step.dart';
import 'package:agrisense/presentation/auth/widgets/forgot_password_reset_step.dart';
import 'package:agrisense/presentation/common/widgets/gradient_app_bar.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  int step = 1;
  final emailController = TextEditingController();
  final c1 = TextEditingController();
  final c2 = TextEditingController();
  final c3 = TextEditingController();
  final c4 = TextEditingController();
  final c5 = TextEditingController();
  final c6 = TextEditingController();

  Widget buildStep() {
    switch (step) {
      case 1:
        return ForgotPasswordEmailStep(
          emailController: emailController,
          onNext: () => setState(() => step = 2),
        );

      case 2:
        return ForgotPasswordVerifyStep(
          email: emailController.text,
          onNext: () => setState(() => step = 3),
          c1: c1,
          c2: c2,
          c3: c3,
          c4: c4,
          c5: c5,
          c6: c6,
        );

      default:
        return ForgotPasswordResetStep(
          email: emailController.text,
          onResetSuccess: () => Navigator.pop(context),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(
        title: 'Forgot Password',
        subtitle: 'Reset your account password',
        colors: [Color(0xFF1DB954), Color(0xFF1ED760)],
      ),
      body: Center(child: buildStep()),
    );
  }
}
