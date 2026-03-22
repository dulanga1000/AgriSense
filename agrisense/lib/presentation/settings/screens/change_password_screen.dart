import 'package:agrisense/core/constants/tips_constants.dart';
import 'package:flutter/material.dart';
import '../../common/widgets/app_back_button.dart';
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

  void _onUpdatePassword() {
    if (!_formKey.currentState!.validate()) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password updated successfully'),
        backgroundColor: Colors.green,
      ),
    );
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

      appBar: AppBar(
        elevation: 0,
        leading: const AppBackButton(fallbackIndex: 0),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Change Password',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            Text(
              'Update your account password',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF155DFC), Color(0xFF1447E6)],
            ),
          ),
        ),
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
                tips: TipsConstants.SecurityTips,
                icon: Icons.security_outlined,
              ),

              const SizedBox(height: 20),

              Opacity(
                opacity: canSubmit ? 1 : 0.45,
                child: IgnorePointer(
                  ignoring: !canSubmit,
                  child: CustomButton(
                    text: 'Update Password',
                    icon: Icons.lock_outline,
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
