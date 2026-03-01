import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(DevicePreview(enabled: true, builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,

      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}
