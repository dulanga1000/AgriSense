import 'package:agrisense/core/constants/tips_constants.dart';
import 'package:agrisense/presentation/common/widgets/gradient_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Ensure this is imported
import '../../common/widgets/custom_button.dart';
import '../../common/widgets/password_strength_checker.dart';
import '../../common/widgets/password_textfield.dart';
import '../../common/widgets/tips_card.dart';
import '../../auth/state/auth_provider.dart'; // Ensure this is imported

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  String _newPassword = '';
  bool _passwordsMatch = true;
  bool _confirmTouched = false;

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

  // ✅ UPDATED THIS METHOD TO CALL FIREBASE
  Future<void> _onUpdatePassword() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AuthProvider>();

    // Call the provider to update the password in Firebase
    final success = await authProvider.changePassword(
      _currentController.text,
      _newController.text,
    );

    if (!mounted) return;

    if (success) {
      // Clear fields on success
      _currentController.clear();
      _newController.clear();
      _confirmController.clear();
      setState(() {
        _newPassword = '';
        _confirmTouched = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
      
      // Optional: Navigate back after success
      Navigator.pop(context); 
    } else {
      // Show Error from Firebase (e.g. Wrong Current Password)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.error ?? 'Failed to update password'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final canEdit = _canEditNewPasswordFields;
    final canSubmit = _canSubmitUpdate;
    final auth = context.watch<AuthProvider>(); // Watch for loading state

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
                opacity: canSubmit && !auth.isLoading ? 1 : 0.45,
                child: IgnorePointer(
                  ignoring: !canSubmit || auth.isLoading,
                  child: CustomButton(
                    // Show loading text if updating
                    text: auth.isLoading ? 'Updating...' : 'Update Password', 
                    icon: auth.isLoading ? Icons.hourglass_empty : Icons.lock_outline,
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

