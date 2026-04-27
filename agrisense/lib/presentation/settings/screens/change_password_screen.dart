import 'package:agrisense/core/constants/tips_constants.dart';
import 'package:agrisense/presentation/common/widgets/gradient_app_bar.dart';
import 'package:agrisense/core/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import '../../common/widgets/custom_button.dart';
import '../../common/widgets/password_strength_checker.dart';
import '../../common/widgets/password_textfield.dart';
import '../../common/widgets/tips_card.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authService = FirebaseAuthService();

  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  String _newPassword = '';
  bool _passwordsMatch = true;
  bool _confirmTouched = false;
  bool _isLoading = false;

  bool get _canEditNewPasswordFields =>
      _currentController.text.trim().isNotEmpty;

  bool get _canSubmitUpdate =>
      _canEditNewPasswordFields &&
      _newController.text.isNotEmpty &&
      _confirmController.text.isNotEmpty &&
      _newController.text == _confirmController.text;

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _checkMatch() {
    setState(() {
      final confirm = _confirmController.text;
      _passwordsMatch = confirm.isEmpty ? true : _newController.text == confirm;
    });
  }

  void _onUpdatePassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await _authService.changePassword(
        currentPassword: _currentController.text,
        newPassword: _newController.text,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password updated successfully'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      // Clear all fields
      _currentController.clear();
      _newController.clear();
      _confirmController.clear();
      setState(() {
        _newPassword = '';
        _passwordsMatch = true;
        _confirmTouched = false;
      });

      // Return to previous screen after 1 second
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) Navigator.pop(context);
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString().replaceAll('Exception: ', '')}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final canEdit = _canEditNewPasswordFields;
    final canSubmit = _canSubmitUpdate;

    final mismatchError = _confirmTouched && !_passwordsMatch
        ? const Text(
            'Passwords do not match',
            style: TextStyle(color: Colors.red, fontSize: 12),
          )
        : null;

    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: const GradientAppBar(
        title: "Change Password",
        subtitle: "Update your account password",
        colors: [Color(0xFF155DFC), Color(0xFF1447E6)],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              PasswordTextField(
                label: 'Current Password',
                hintText: 'Enter current password',
                controller: _currentController,
                style: PasswordFieldStyle.card,
                onChanged: (_) => setState(() {}),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Current password is required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 12),

              Opacity(
                opacity: canEdit ? 1 : 0.45,
                child: IgnorePointer(
                  ignoring: !canEdit,
                  child: PasswordTextField(
                    label: 'New Password',
                    hintText: 'Enter new password',
                    controller: _newController,
                    style: PasswordFieldStyle.card,
                    showExtraContentOnFocusAndText: true,
                    onChanged: (value) {
                      setState(() => _newPassword = value);
                      _checkMatch();
                    },
                    extraContent: PasswordStrengthChecker(
                      password: _newPassword,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'New password is required';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      if (!value.contains(RegExp(r'[A-Z]'))) {
                        return 'Must contain an uppercase letter';
                      }
                      if (!value.contains(RegExp(r'[0-9]'))) {
                        return 'Must contain a number';
                      }
                      return null;
                    },
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Opacity(
                opacity: canEdit ? 1 : 0.45,
                child: IgnorePointer(
                  ignoring: !canEdit,
                  child: PasswordTextField(
                    label: 'Confirm New Password',
                    hintText: 'Re-enter new password',
                    controller: _confirmController,
                    style: PasswordFieldStyle.card,
                    onChanged: (_) {
                      if (!_confirmTouched) {
                        setState(() => _confirmTouched = true);
                      }
                      _checkMatch();
                    },
                    extraContent: mismatchError,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _newController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const TipsCard(
                title: 'Password Tips',
                tips: TipsConstants.securityTips,
                icon: Icons.security_outlined,
              ),

              const SizedBox(height: 20),

              Opacity(
                opacity: (canSubmit && !_isLoading) ? 1 : 0.45,
                child: IgnorePointer(
                  ignoring: !canSubmit || _isLoading,
                  child: CustomButton(
                    text: _isLoading ? 'Updating...' : 'Update Password',
                    icon: _isLoading
                        ? Icons.hourglass_empty
                        : Icons.lock_outline,
                    onPressed: _onUpdatePassword,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
