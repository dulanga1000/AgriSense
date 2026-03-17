import 'package:flutter/material.dart';
import '../state/setting_state.dart';
import '../widgets/setting_header.dart';
import '../widgets/general_setting.dart';
import '../widgets/notification_setting.dart';
import '../widgets/storage_setting.dart';
import '../widgets/privacy_setting.dart';
import '../widgets/about_setting.dart'; 

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

                  const NotificationSetting(), 

                  StorageSetting(settingState: settingState),

                  const PrivacySetting(),

                  const AboutSetting(), 
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