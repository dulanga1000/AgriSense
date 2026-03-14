import 'package:flutter/material.dart';
import 'package:agrisense/core/routes/app_routes.dart';
import 'package:agrisense/presentation/main/screens/main_screen.dart';

class AppBackButton extends StatelessWidget {
  final int fallbackIndex;
  final bool fallbackToSplash;

  const AppBackButton({
    super.key,
    this.fallbackIndex = 0,
    this.fallbackToSplash = false,
  });

  void _handleBack(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
      return;
    }

    if (fallbackToSplash) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.splash,
        (route) => false,
      );
      return;
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => MainScreen(initialIndex: fallbackIndex),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () => _handleBack(context),
    );
  }
}
