import 'package:flutter/material.dart';
import '../widgets/setting_header.dart';
import '../widgets/general_setting.dart';
import '../state/setting_state.dart';


final settingState = SettingState();

class AppSettingScreen extends StatelessWidget {
  const AppSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      body: Column(
        children: [
          
        
          const SettingHeader(),

         
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                
                children: [
                  const SizedBox(height: 20),

                  
                  GeneralSetting(settingState: settingState),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}