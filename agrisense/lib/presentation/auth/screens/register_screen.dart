import 'package:flutter/material.dart';
import 'package:agrisense/presentation/auth/widgets/auth_form_header.dart';
import 'package:agrisense/presentation/auth/widgets/register_form_card.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9F5E1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const AuthFormHeader(),
              const SizedBox(height: 30),
              RegisterFormCard(
                nameController: nameController,
                emailController: emailController,
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
