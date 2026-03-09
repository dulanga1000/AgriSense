import 'package:flutter/material.dart';
import '../../presentation/splash/splash_screen.dart';
import '../../presentation/auth/screens/login_screen.dart';
import '../../presentation/main/screens/main_screen.dart';
import '../../presentation/home/screens/home_screen.dart';
import '../../presentation/disease/disease_scan_screen.dart';
import '../../presentation/weather/screens/weather_screen.dart';
import '../../presentation/profile/screens/profile_screen.dart';
import '../../presentation/fertilizer/screens/fertilizer_screen.dart';
import '../../presentation/crop/screens/crop_advisory_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String main = '/main_screen';
  static const String home = '/home_screen';
  static const String diseaseScan = '/disease_scan_screen';
  static const String weather = '/weather_screen';
  static const String profile = '/profile_screen';
  static const String fertilizer = '/fertilizer_screen';
  static const String cropAdvisory = '/crop_advisory_screen';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    login: (context) => LoginScreen(),
    main: (context) => const MainScreen(),
    home: (context) => const HomeScreen(),
    diseaseScan: (context) => const DiseaseScanScreen(),
    weather: (context) => const WeatherScreen(),
    profile: (context) => const ProfileScreen(),
    fertilizer: (context) => const FertilizerScreen(),
    cropAdvisory: (context) => const CropAdvisoryScreen(),
  };
}
