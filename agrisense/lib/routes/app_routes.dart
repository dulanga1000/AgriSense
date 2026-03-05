import 'package:flutter/material.dart';
import '../presentation/screens/splash/splash_screen.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/main/main_screen.dart';
import '../presentation/screens/home/home_screen.dart';
import '../presentation/screens/disease/disease_scan_screen.dart';
import '../presentation/screens/weather/weather_screen.dart';
import '../presentation/screens/profile/profile_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String main = '/main_screen';
  static const String home = '/home_screen';
  static const String diseaseScan = '/disease_scan_screen';
  static const String weather = '/weather_screen';
  static const String profile = '/profile_screen';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    main: (context) => const MainScreen(),
    home: (context) => const HomeScreen(),
    diseaseScan: (context) => const DiseaseScanScreen(),
    weather: (context) => const WeatherScreen(),
    profile: (context) => const ProfileScreen(),
  };
}
