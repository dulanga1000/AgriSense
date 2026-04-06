import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:agrisense/core/routes/app_routes.dart';
import 'package:agrisense/presentation/auth/state/auth_provider.dart';

import 'package:agrisense/presentation/common/widgets/auth_card.dart';
import 'package:agrisense/presentation/common/widgets/custom_button.dart';
import 'package:agrisense/presentation/common/widgets/email_textfield.dart';
import 'package:agrisense/presentation/common/widgets/google_auth_button.dart';
import 'package:agrisense/presentation/common/widgets/password_textfield.dart';
import 'package:agrisense/presentation/common/widgets/auth_snackbar.dart';

class LoginFormCard extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginFormCard({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<LoginFormCard> createState() => _LoginFormCardState();
}

class _LoginFormCardState extends State<LoginFormCard> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _onLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final auth = context.read<AuthProvider>();
    final email = widget.emailController.text.trim();
    final password = widget.passwordController.text.trim();

    await auth.login(email, password);

    if (!mounted) return;

    if (auth.user != null) {
      AuthSnackBar.showSuccess(context, "Login successful!");
      Navigator.pushReplacementNamed(context, AppRoutes.main);
    } else {
      AuthSnackBar.showError(
        context,
        auth.error ?? "Login failed",
      );
    }
  }

  Future<void> _onGoogleLogin() async {
    final auth = context.read<AuthProvider>();

    await auth.googleSignIn();

    if (!mounted) return;

    if (auth.user != null) {
      AuthSnackBar.showSuccess(context, "Google login successful!");
      Navigator.pushReplacementNamed(context, AppRoutes.main);
    } else {
      AuthSnackBar.showError(
        context,
        auth.error ?? "Google sign-in failed",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return AuthCard(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Welcome Back',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 25),

            EmailTextField(controller: widget.emailController),

            const SizedBox(height: 20),

            PasswordTextField(
              label: 'Password',
              controller: widget.passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                return null;
              },
            ),

            const SizedBox(height: 10),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.forgotPassword,
                ),
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),

            const SizedBox(height: 10),

            CustomButton(
              text: auth.isLoading ? 'Logging in...' : 'Login',
              onPressed: auth.isLoading ? () {} : _onLogin,
            ),

            const SizedBox(height: 25),

            const Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text('Or continue with'),
                ),
                Expanded(child: Divider()),
              ],
            ),

            const SizedBox(height: 20),

            GoogleAuthButton(
              text: 'Sign in with Google',
              onSuccess: _onGoogleLogin, // ✅ CLEAN
            ),

            const SizedBox(height: 20),

            Center(
              child: TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, AppRoutes.register),
                child: const Text(
                  "Don't have an account? Register",
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),

            const SizedBox(height: 15),

            CustomButton(
              text: 'Continue as Guest',
              outlined: true,
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, AppRoutes.main),
            ),
          ],
        ),
      ),
    );
  }
}