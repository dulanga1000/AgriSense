import 'package:flutter/material.dart';

class CropAdvisoryScreen extends StatelessWidget {
  const CropAdvisoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crop Advisory')),
      body: const Center(
        child: Text(
          'Crop Advisory Content Goes Here',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
