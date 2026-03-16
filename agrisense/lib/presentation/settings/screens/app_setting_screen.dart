import 'package:flutter/material.dart';
import '../widgets/setting_header.dart';

class AppSettingScreen extends StatelessWidget {
  const AppSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: const Column(
        children: [
         
          SettingHeader(),
          

              
        ],
      ),
    );
  }
}
