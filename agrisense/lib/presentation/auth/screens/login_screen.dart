import 'package:flutter/material.dart';
import 'package:agrisense/presentation/auth/widgets/auth_form_header.dart';
import 'package:agrisense/presentation/auth/widgets/login_form_card.dart';

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

              const AuthFormHeader(),

              const SizedBox(height: 30),

              LoginFormCard(
                emailController: emailController,
                passwordController: passwordController,
              ),

              const SizedBox(height: 30),

            ],
          ),
        ),
      ),
    );
  }
}