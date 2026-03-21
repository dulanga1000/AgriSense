import 'package:flutter/material.dart';
import 'package:agrisense/presentation/auth/widgets/step_indicator.dart';
import 'package:agrisense/presentation/common/widgets/auth_card.dart';
import 'package:agrisense/presentation/common/widgets/auth_snackbar.dart';
import 'package:agrisense/presentation/common/widgets/custom_button.dart';
import 'package:agrisense/presentation/common/widgets/password_strength_checker.dart';
import 'package:agrisense/presentation/common/widgets/password_textfield.dart';

class ForgotPasswordResetStep extends StatefulWidget {
  final VoidCallback onResetSuccess;

  const ForgotPasswordResetStep({super.key, required this.onResetSuccess});

  @override
  State<ForgotPasswordResetStep> createState() =>
      _ForgotPasswordResetStepState();
}

class _ForgotPasswordResetStepState extends State<ForgotPasswordResetStep> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _password = '';
  bool _passwordsMatch = true;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool get _passwordValid =>
      _password.length >= 8 &&
      _password.contains(RegExp(r'[A-Z]')) &&
      _password.contains(RegExp(r'[a-z]')) &&
      _password.contains(RegExp(r'[0-9]')) &&
      _password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));

  void _checkMatch() {
    setState(() {
      _passwordsMatch =
          _newPasswordController.text == _confirmPasswordController.text;
    });
  }

  Future<void> _onReset() async {
    if (!_passwordValid) {
      AuthSnackBar.showError(context, 'Password does not meet requirements');
      return;
    }

    if (!_passwordsMatch || _confirmPasswordController.text.isEmpty) {
      AuthSnackBar.showError(context, 'Passwords do not match');
      return;
    }

    AuthSnackBar.showSuccess(context, 'Password reset successfully!');
    await Future.delayed(const Duration(seconds: 1));
    widget.onResetSuccess();
  }

  @override
  Widget build(BuildContext context) {
    final matchFeedback = _confirmPasswordController.text.isNotEmpty
        ? Row(
            children: [
              Icon(
                _passwordsMatch ? Icons.check_circle : Icons.cancel,
                color: _passwordsMatch ? Colors.green : Colors.red,
                size: 16,
              ),
              const SizedBox(width: 5),
              Text(
                _passwordsMatch ? 'Passwords match' : 'Passwords do not match',
                style: TextStyle(
                  color: _passwordsMatch ? Colors.green : Colors.red,
                  fontSize: 12,
                ),
              ),
            ],
          )
        : null;

    return Column(
      children: [
        const StepIndicator(currentStep: 3),
        const SizedBox(height: 20),

        AuthCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.purple.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.security,
                    color: Colors.purple,
                    size: 32,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              const Center(
                child: Text(
                  'Create New Password',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),

              const Center(
                child: Text(
                  'Choose a strong password for your account',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              const SizedBox(height: 25),

              const Text('New Password'),
              const SizedBox(height: 8),
              PasswordTextField(
                controller: _newPasswordController,
                hintText: 'Enter new password',
                showExtraContentOnFocusAndText: true,
                onChanged: (value) {
                  setState(() => _password = value);
                  _checkMatch();
                },
                extraContent: PasswordStrengthChecker(password: _password),
              ),

              const SizedBox(height: 20),

              const Text('Confirm Password'),
              const SizedBox(height: 8),
              PasswordTextField(
                controller: _confirmPasswordController,
                hintText: 'Confirm password',
                onChanged: (_) => _checkMatch(),
                extraContent: matchFeedback,
              ),

              const SizedBox(height: 20),

              CustomButton(
                text: 'Reset Password',
                icon: Icons.lock,
                onPressed: _onReset,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
