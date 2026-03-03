import 'package:agrisense/routes/app_routes.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Login Screen", style: TextStyle(fontSize: 20)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.home);
              },
              child: const Text("Login", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
