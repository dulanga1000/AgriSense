import 'package:flutter/material.dart';

class ForgotPasswordResetStep extends StatelessWidget {

  const ForgotPasswordResetStep({super.key});

  @override
  Widget build(BuildContext context) {

    final passwordController = TextEditingController();
    final confirmController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [

          const SizedBox(height: 40),

          const Text(
            "Create New Password",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: "New password",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          TextField(
            controller: confirmController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: "Confirm password",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 30),

          ElevatedButton(
            onPressed: () {},
            child: const Text("Reset Password"),
          )
        ],
      ),
    );
  }
}