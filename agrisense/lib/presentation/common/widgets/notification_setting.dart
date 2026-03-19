import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrisense/presentation/settings/state/setting_state.dart';

class NotificationSetting extends StatelessWidget {
  const NotificationSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingState>(
      builder: (context, state, _) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
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
              const Text(
                "Notification Preferences",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              _buildSwitchTile(
                title: "Disease Alerts",
                subtitle: "Get alerts about plant diseases",
                value: state.diseaseAlerts,
                onChanged: state.toggleDiseaseAlerts,
              ),
              const SizedBox(height: 16),
              _buildSwitchTile(
                title: "Weather Updates",
                subtitle: "Get weather forecasts",
                value: state.weatherUpdates,
                onChanged: state.toggleWeatherUpdates,
              ),
              const SizedBox(height: 16),
              _buildSwitchTile(
                title: "Farming Tips",
                subtitle: "Get daily farming tips",
                value: state.farmingTips,
                onChanged: state.toggleFarmingTips,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
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
