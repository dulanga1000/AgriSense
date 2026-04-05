import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:agrisense/core/routes/app_routes.dart';
import 'package:agrisense/presentation/common/widgets/app_back_button.dart';
import 'package:agrisense/presentation/common/widgets/auth_card.dart';
import 'package:agrisense/presentation/common/widgets/auth_snackbar.dart';
import 'package:agrisense/presentation/auth/widgets/forgot_password_email_step.dart';
import 'package:agrisense/presentation/auth/widgets/forgot_password_reset_step.dart';
import 'package:agrisense/presentation/auth/widgets/forgot_password_verify_step.dart';
import 'package:agrisense/presentation/common/widgets/gradient_app_bar.dart';

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
        ],
      ),
    );
  }
}