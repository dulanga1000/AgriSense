import 'package:agrisense/presentation/common/widgets/gradient_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrisense/presentation/settings/state/setting_state.dart';

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

      appBar: const GradientAppBar(
        title: "App Settings",
        colors: [Color(0xFF2D6CDF), Color(0xFF214EBF)],
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
                AboutSetting(settingState: state), 

                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}