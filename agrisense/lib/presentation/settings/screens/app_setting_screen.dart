import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrisense/presentation/settings/state/setting_state.dart';
import 'package:agrisense/presentation/common/widgets/app_back_button.dart';
import '../widgets/general_setting.dart';
import '../widgets/notification_setting.dart';
import '../widgets/storage_setting.dart';
import '../widgets/privacy_setting.dart';
import '../widgets/about_setting.dart';

class AppSettingScreen extends StatelessWidget {
  const AppSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingState(),
      child: Scaffold(
        backgroundColor: Colors.grey[100],

        appBar: AppBar(
          backgroundColor: const Color(0xFF2D6CDF),
          elevation: 0,

          leading: const AppBackButton(fallbackIndex: 0),

          title: const Text(
            "App Settings",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        ),

        body: Consumer<SettingState>(
          builder: (context, state, _) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  GeneralSetting(settingState: state),
                  NotificationSetting(settingState: state),
                  StorageSetting(settingState: state),

                  const PrivacySetting(),
                  const AboutSetting(),

                  const SizedBox(height: 40),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
