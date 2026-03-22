import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:agrisense/core/routes/app_routes.dart';
import 'package:agrisense/presentation/auth/state/auth_provider.dart';

import 'package:agrisense/presentation/common/widgets/auth_card.dart';
import 'package:agrisense/presentation/common/widgets/custom_button.dart';
import 'package:agrisense/presentation/common/widgets/custom_text_field.dart';
import 'package:agrisense/presentation/common/widgets/email_textfield.dart';
import 'package:agrisense/presentation/common/widgets/google_auth_button.dart';
import 'package:agrisense/presentation/common/widgets/password_strength_checker.dart';
import 'package:agrisense/presentation/common/widgets/password_textfield.dart';
import 'package:agrisense/presentation/common/widgets/auth_snackbar.dart';

class RegisterFormCard extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const RegisterFormCard({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  State<RegisterFormCard> createState() => _RegisterFormCardState();
}

class _RegisterFormCardState extends State<RegisterFormCard> {
  final _formKey = GlobalKey<FormState>();

  String _password = '';
  bool _passwordsMatch = true;

  void _checkMatch() {
    setState(() {
      _passwordsMatch =
          widget.passwordController.text ==
          widget.confirmPasswordController.text;
    });
  }

  Future<void> _onRegister() async {
    if (!_formKey.currentState!.validate()) return;

    final auth = context.read<AuthProvider>();

    await auth.register(
      widget.emailController.text.trim(),
      widget.passwordController.text.trim(),
    );

    if (!mounted) return;

    if (auth.user != null) {
      await auth.logout();

      AuthSnackBar.showSuccess(
        context,
        "Registration successful! Please login.",
      );

      Navigator.pushReplacementNamed(context, AppRoutes.login);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(auth.error ?? "Registration failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mismatchError = !_passwordsMatch
        ? const Text(
            'Passwords do not match',
            style: TextStyle(color: Colors.red, fontSize: 12),
          )
        : null;

    return AuthCard(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Create Account',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 25),

            CustomTextField(
              label: 'Name',
              hintText: 'Enter your name',
              prefixIcon: Icons.person_outline,
              controller: widget.nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                if (value.length < 3) {
                  return 'Name must be at least 3 characters';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            EmailTextField(controller: widget.emailController),

            const SizedBox(height: 20),

            PasswordTextField(
              label: 'Password',
              controller: widget.passwordController,
              hintText: 'Enter your password',
              showExtraContentOnFocusAndText: true,
              onChanged: (value) {
                setState(() => _password = value);
                _checkMatch();
              },
              extraContent: PasswordStrengthChecker(password: _password),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                if (value.length < 8) {
                  return 'Password must be at least 8 characters';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            PasswordTextField(
              label: 'Confirm Password',
              controller: widget.confirmPasswordController,
              hintText: 'Re-enter your password',
              onChanged: (_) => _checkMatch(),
              extraContent: mismatchError,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != widget.passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),

            const SizedBox(height: 25),

            CustomButton(
              text: 'Register',
              onPressed: _onRegister,
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
              text: 'Sign up with Google',
              onSuccess: () async {
                final auth = context.read<AuthProvider>();

                await auth.googleSignIn();

                if (!mounted) return;

                if (auth.user != null) {
                  Navigator.pushReplacementNamed(context, AppRoutes.main);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(auth.error ?? "Google sign-in failed")),
                  );
                }
              },
            ),

            const SizedBox(height: 20),

            Center(
              child: TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, AppRoutes.login),
                child: const Text(
                  'Already have an account? Login',
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