import 'package:flutter/material.dart';

class FertilizerScreen extends StatelessWidget {
  const FertilizerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fertilizer Recommendations')),
      body: const Center(child: Text('Fertilizer Screen')),
    );
  }
}
