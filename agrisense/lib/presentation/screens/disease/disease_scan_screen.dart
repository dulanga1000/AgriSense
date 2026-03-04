import 'package:flutter/material.dart';

class DiseaseScanScreen extends StatelessWidget {
  const DiseaseScanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Disease Scan')),
      body: const Center(child: Text('Disease Scan Screen')),
    );
  }
}
