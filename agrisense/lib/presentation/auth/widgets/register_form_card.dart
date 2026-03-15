import 'package:flutter/material.dart';
import 'package:agrisense/core/routes/app_routes.dart';
import 'package:agrisense/presentation/auth/widgets/email_textfield.dart';
import 'package:agrisense/presentation/auth/widgets/password_textfield.dart';
import 'package:agrisense/presentation/auth/widgets/auth_button.dart';
import 'package:agrisense/data/models/auth_button_model.dart';

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

    final registerButton = AuthButtonModel(text: "Register");

    final googleButton = AuthButtonModel(
      text: "Sign in with Google",
      icon: Icons.g_mobiledata,
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
                "Create Account",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 25),

            /// NAME
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

            /// EMAIL
            const Text("Email"),
            const SizedBox(height: 8),

            EmailTextField(
              controller: widget.emailController,
            ),

            const SizedBox(height: 20),

            /// PASSWORD
            const Text("Password"),
            const SizedBox(height: 8),

            PasswordTextField(
              controller: widget.passwordController,
            ),

            const SizedBox(height: 25),

            /// REGISTER BUTTON
            AuthButton(
              button: registerButton,
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

            /// Google Sign In
            AuthButton(
              button: googleButton,
              onPressed: () {},
            ),

            const SizedBox(height: 20),

            /// Login Link
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.login,
                  );
                },
                child: const Text(
                  "Already have an account? Login",
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}