import 'package:flutter/material.dart';
import 'package:agrisense/presentation/main/screens/main_screen.dart';

class MainTabNavigator {
  const MainTabNavigator._();

  static void goToTab(BuildContext context, int index) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => MainScreen(initialIndex: index)),
      (route) => false,
    );
  }
}
