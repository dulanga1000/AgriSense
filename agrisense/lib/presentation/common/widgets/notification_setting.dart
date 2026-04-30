import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrisense/presentation/settings/state/setting_state.dart';
import 'package:agrisense/presentation/notification/state/notification_state.dart';

class NotificationSetting extends StatelessWidget {
  const NotificationSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<SettingState, NotificationState>(
      builder: (context, settingState, notificationState, _) {
        final isNotificationsEnabled = settingState.notifications;

        return Opacity(
          opacity: isNotificationsEnabled ? 1.0 : 0.5,
          child: IgnorePointer(
            ignoring: !isNotificationsEnabled,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isNotificationsEnabled ? Colors.white : Colors.grey[200],
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Notification Preferences",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      if (!isNotificationsEnabled)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            "Disabled",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildSwitchTile(
                    title: "Disease Alerts",
                    subtitle: "Get alerts about plant diseases",
                    value: settingState.diseaseAlerts,
                    onChanged: isNotificationsEnabled
                        ? settingState.toggleDiseaseAlerts
                        : null,
                  ),
                  const SizedBox(height: 16),
                  _buildSwitchTile(
                    title: "Weather Updates",
                    subtitle: "Get weather forecasts",
                    value: settingState.weatherUpdates,
                    onChanged: isNotificationsEnabled
                        ? settingState.toggleWeatherUpdates
                        : null,
                  ),
                  const SizedBox(height: 16),
                  _buildSwitchTile(
                    title: "Farming Tips",
                    subtitle: "Get daily farming tips",
                    value: settingState.farmingTips,
                    onChanged: isNotificationsEnabled
                        ? settingState.toggleFarmingTips
                        : null,
                  ),
                  const SizedBox(height: 16),
                  _buildSwitchTile(
                    title: "Auth Notifications",
                    subtitle: "Login, logout & password alerts",
                    value: settingState.authAlerts,
                    onChanged: isNotificationsEnabled
                        ? settingState.toggleAuthAlerts
                        : null,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool>? onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeTrackColor: const Color(0xFF00AA4F),
          activeThumbColor: Colors.white,
          inactiveTrackColor: const Color(0xFFE4E6EB),
          inactiveThumbColor: Colors.white,
          trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
        ),
      ],
    );
  }
}
