import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrisense/presentation/settings/state/setting_state.dart';
import '../widgets/setting_header.dart';
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
        body: Column(
          children: [
            const SettingHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Consumer<SettingState>(
                  builder: (context, state, _) {
                    return Column(
                      children: [
                        const SizedBox(height: 20),
                        // ✅ widget names only
                        GeneralSetting(settingState: state),
                        NotificationSetting(settingState: state),
                        StorageSetting(settingState: state),
                        const PrivacySetting(),
                        const AboutSetting(),
                        const SizedBox(height: 40),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
