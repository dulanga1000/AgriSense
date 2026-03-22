import 'package:flutter/material.dart';

class HelloGirlsScreen extends StatelessWidget {
  const HelloGirlsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Simple Screen")),
      body: const Center(
        child: Text(
          "Hello Girls 👋",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
