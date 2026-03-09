import 'package:flutter/material.dart';
import 'package:agrisense/core/routes/app_routes.dart';

import 'package:agrisense/presentation/auth/widgets/auth_form_header.dart';
import 'package:agrisense/presentation/auth/widgets/email_textfield.dart';
import 'package:agrisense/presentation/auth/widgets/password_textfield.dart';
import 'package:agrisense/presentation/auth/widgets/auth_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9F5E1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              /// Header
              const AuthFormHeader(),

              const SizedBox(height: 30),

              /// Login Card
              Container(
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
                    /// Welcome Text
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

                    /// Email Label
                    const Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// Email Field
                    EmailTextField(controller: emailController),

                    const SizedBox(height: 20),

                    /// Password Label
                    const Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// Password Field
                    PasswordTextField(controller: passwordController),

                    const SizedBox(height: 10),

                    /// Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// Login Button (Reusable)
                    AuthButton(
                      text: "Login",
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, AppRoutes.main);
                      },
                    ),

                    const SizedBox(height: 25),

                    /// Divider
                    Row(
                      children: const [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text("Or continue with"),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// Google Sign In Button (same widget)
                    AuthButton(
                      text: "Sign in with Google",
                      icon: Icons.g_mobiledata,
                      outlined: true,
                      onPressed: () {},
                    ),

                    const SizedBox(height: 20),

                    /// Register
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
                      text: "Continue as Guest",
                      outlined: true,
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, AppRoutes.main);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
