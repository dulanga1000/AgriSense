import 'package:flutter/material.dart';
import '../presentation/screens/splash/splash_screen.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/home/home_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home_screen';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    home: (context) => const HomeScreen(),
  };
}
