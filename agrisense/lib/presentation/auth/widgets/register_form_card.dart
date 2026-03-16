import 'package:flutter/material.dart';
import 'package:agrisense/core/routes/app_routes.dart';
import 'package:agrisense/presentation/common/widgets/email_textfield.dart';
import 'package:agrisense/presentation/common/widgets/password_textfield.dart';
import 'package:agrisense/presentation/common/widgets/auth_button.dart';
import 'package:agrisense/presentation/common/widgets/auth_card.dart';

class RegisterFormCard extends StatefulWidget {
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
  State<RegisterFormCard> createState() => _RegisterFormCardState();
}

class _RegisterFormCardState extends State<RegisterFormCard> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AuthCard(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Create Account",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 25),

            const Text("Name"),
            const SizedBox(height: 8),

            TextFormField(
              controller: widget.nameController,
              decoration: InputDecoration(
                hintText: "Enter your name",
                prefixIcon: const Icon(Icons.person_outline),
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your name";
                }
                if (value.length < 3) {
                  return "Name must be at least 3 characters";
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            const Text("Email"),
            const SizedBox(height: 8),
            EmailTextField(controller: widget.emailController),

            const SizedBox(height: 20),

            const Text("Password"),
            const SizedBox(height: 8),
            PasswordTextField(controller: widget.passwordController),

            const SizedBox(height: 25),

            AuthButton(
              text: "Register",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pushReplacementNamed(context, AppRoutes.main);
                }
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

            /// GOOGLE BUTTON WITH PNG ICON
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                side: const BorderSide(color: Colors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/google_logo.png",
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Sign up with Google",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, AppRoutes.login),
                child: const Text(
                  "Already have an account? Login",
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),

            const SizedBox(height: 15),

            /// CONTINUE AS GUEST BUTTON WITH BLACK TEXT
            Theme(
              data: Theme.of(context).copyWith(
                outlinedButtonTheme: OutlinedButtonThemeData(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              child: AuthButton(
                text: "Continue as Guest",
                outlined: true,
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, AppRoutes.main),
              ),
            ),
          ],
        ),
      ),
    );
  }
}