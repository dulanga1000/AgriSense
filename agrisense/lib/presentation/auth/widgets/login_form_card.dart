import 'package:flutter/material.dart';
import 'package:agrisense/core/routes/app_routes.dart';
import 'package:agrisense/presentation/auth/widgets/email_textfield.dart';
import 'package:agrisense/presentation/auth/widgets/password_textfield.dart';
import 'package:agrisense/presentation/auth/widgets/auth_button.dart';
import 'package:agrisense/data/models/auth_button_model.dart';
import 'package:agrisense/presentation/auth/screens/forgot_password_screen.dart';

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

  /// Form Key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final loginButton = AuthButtonModel(text: "Login");

    final googleButton = AuthButtonModel(
      text: "Sign in with Google",
      icon: Icons.g_mobiledata,
      outlined: true,
    );

    final guestButton = AuthButtonModel(
      text: "Continue as Guest",
      outlined: true,
    );

    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Center(
              child: Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 25),

            /// Email
            const Text("Email"),
            const SizedBox(height: 8),

            EmailTextField(
              controller: widget.emailController,
            ),

            const SizedBox(height: 20),

            /// Password
            const Text("Password"),
            const SizedBox(height: 8),

            PasswordTextField(
              controller: widget.passwordController,
            ),

            const SizedBox(height: 10),

            /// Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPasswordScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),

            const SizedBox(height: 10),

            /// Login Button with Validation
            AuthButton(
              button: loginButton,
              onPressed: () {

                if (_formKey.currentState!.validate()) {
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.main,
                  );
                }

              },
            ),

            const SizedBox(height: 25),

            /// Divider
            const Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Or continue with"),
                ),
                Expanded(child: Divider()),
              ],
            ),

            const SizedBox(height: 20),

            /// Google Login
            AuthButton(
              button: googleButton,
              onPressed: () {},
            ),

            const SizedBox(height: 20),

            /// Register Navigation
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.register,
                  );
                },
                child: const Text(
                  "Don't have an account? Register",
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),

            const SizedBox(height: 15),

            /// Guest Login
            AuthButton(
              button: guestButton,
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.main,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}