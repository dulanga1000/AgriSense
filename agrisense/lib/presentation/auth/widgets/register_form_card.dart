import 'package:flutter/material.dart';
import 'package:agrisense/core/routes/app_routes.dart';
import 'package:agrisense/presentation/auth/widgets/email_textfield.dart';
import 'package:agrisense/presentation/auth/widgets/password_textfield.dart';
import 'package:agrisense/presentation/auth/widgets/auth_button.dart';
import 'package:agrisense/data/models/auth_button_model.dart';

class RegisterFormCard extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const RegisterFormCard({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {

    final registerButton = AuthButtonModel(
      text: "Register",
    );

    final googleButton = AuthButtonModel(
      text: "Sign in with Google",
      icon: Icons.g_mobiledata,
      outlined: true,
    );

    return Container(
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
              "Create Account",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 25),

          const Text("Name"),
          const SizedBox(height: 8),

          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: "Enter your name",
              prefixIcon: const Icon(Icons.person_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text("Email"),
          const SizedBox(height: 8),

          EmailTextField(controller: emailController),

          const SizedBox(height: 20),

          const Text("Password"),
          const SizedBox(height: 8),

          PasswordTextField(controller: passwordController),

          const SizedBox(height: 25),

          AuthButton(
            button: registerButton,
            onPressed: () {
              Navigator.pushReplacementNamed(context, AppRoutes.main);
            },
          ),

          const SizedBox(height: 25),

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

          AuthButton(
            button: googleButton,
            onPressed: () {},
          ),

          const SizedBox(height: 20),

          Center(
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              },
              child: const Text(
                "Already have an account? Login",
                style: TextStyle(color: Colors.green),
              ),
            ),
          ),
        ],
      ),
    );
  }
}