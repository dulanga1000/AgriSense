import 'package:flutter/material.dart';
import '../widgets/setting_header.dart';
import '../widgets/general_setting.dart';
import '../widgets/notification_setting.dart'; // Make sure this is imported!
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
          /// HEADER
          const SettingHeader(),

          /// SETTINGS CONTENT
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  /// GENERAL SETTINGS CARD
                  GeneralSetting(settingState: settingState),

                  /// ADD YOUR NEW WIDGET HERE:
                  const NotificationSetting(), 

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