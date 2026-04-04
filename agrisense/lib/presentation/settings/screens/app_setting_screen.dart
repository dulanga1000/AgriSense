import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrisense/presentation/settings/state/setting_state.dart';
import 'package:agrisense/presentation/common/widgets/app_back_button.dart';

import '../widgets/general_setting.dart';
import '../../common/widgets/notification_setting.dart';
import '../widgets/storage_setting.dart';
import '../widgets/privacy_setting.dart';
import '../widgets/about_setting.dart';

class AppSettingScreen extends StatelessWidget {
  const AppSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,

        // 🔥 Gradient Background
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2D6CDF), Color(0xFF214EBF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        // 🔥 Custom Content
        titleSpacing: 0,
        title: Row(
          children: const [
            SizedBox(width: 8),
            AppBackButton(fallbackIndex: 0),
            SizedBox(width: 12),
            Text(
              "App Settings",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),

      body: Consumer<SettingState>(
        builder: (context, state, _) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),

                GeneralSetting(settingState: state),
                const NotificationSetting(),
                StorageSetting(settingState: state),

                const PrivacySetting(),
                const AboutSetting(),

                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}
