import 'package:flutter/material.dart';
import 'package:agrisense/presentation/widgets/home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const HomeHeader());
  }
}
