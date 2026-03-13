import 'package:flutter/material.dart';
import 'step_indicator.dart';
import 'auth_snackbar.dart';

class ForgotPasswordResetStep extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmController;
  final VoidCallback onReset;

  const ForgotPasswordResetStep({
    super.key,
    required this.passwordController,
    required this.confirmController,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

          /// Step Indicator
          const StepIndicator(currentStep: 3),

          const SizedBox(height: 20),

          /// Card
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(24),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 15,
                    offset: Offset(0, 6),
                  ),
                ],
              ),

              child: Column(
                children: [

                  /// Icon Circle
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0E8F3E).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.lock_outline,
                      color: Color(0xFF0E8F3E),
                      size: 32,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Title
                  const Text(
                    "Create New Password",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Choose a strong password for your account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// New Password Label
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "New Password",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// New Password Field
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enter new password",
                      prefixIcon: const Icon(Icons.lock_outline),

                      filled: true,
                      fillColor: Colors.grey.shade100,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFF0E8F3E),
                          width: 2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Confirm Password Label
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Confirm Password",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// Confirm Password Field
                  TextField(
                    controller: confirmController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Re-enter new password",
                      prefixIcon: const Icon(Icons.lock_outline),

                      filled: true,
                      fillColor: Colors.grey.shade100,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFF0E8F3E),
                          width: 2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// Reset Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {

                        final password = passwordController.text.trim();
                        final confirm = confirmController.text.trim();

                        if (password.isEmpty || confirm.isEmpty) {
                          AuthSnackBar.showError(
                            context,
                            "Please fill all fields",
                          );
                          return;
                        }

                        if (password.length < 6) {
                          AuthSnackBar.showError(
                            context,
                            "Password must be at least 6 characters",
                          );
                          return;
                        }

                        if (password != confirm) {
                          AuthSnackBar.showError(
                            context,
                            "Passwords do not match",
                          );
                          return;
                        }

                        AuthSnackBar.showSuccess(
                          context,
                          "Password reset successfully!",
                        );

                        onReset();
                      },
                      icon: const Icon(Icons.lock_reset),
                      label: const Text(
                        "Reset Password",
                        style: TextStyle(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0E8F3E),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}