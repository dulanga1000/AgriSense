import 'package:flutter/material.dart';

class NotificationSetting extends StatefulWidget {
  const NotificationSetting({super.key});

  @override
  State<NotificationSetting> createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  // Local state variables (Ephemeral State)
  bool diseaseAlerts = true;
  bool weatherUpdates = true;
  bool farmingTips = true;

  @override
  Widget build(BuildContext context) {
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
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          /// TITLE
          const Text(
            "Notification Preferences",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF002244), // Deep navy tone from the screenshot
            ),
          ),
          
          const SizedBox(height: 20),

          /// DISEASE ALERTS
          _buildSwitchTile(
            title: "Disease Alerts",
            subtitle: "Get alerts about plant diseases",
            value: diseaseAlerts,
            onChanged: (val) {
              setState(() => diseaseAlerts = val);
            },
          ),
          
          const SizedBox(height: 16),

          /// WEATHER UPDATES
          _buildSwitchTile(
            title: "Weather Updates",
            subtitle: "Get weather forecasts",
            value: weatherUpdates,
            onChanged: (val) {
              setState(() => weatherUpdates = val);
            },
          ),
          
          const SizedBox(height: 16),

          /// FARMING TIPS
          _buildSwitchTile(
            title: "Farming Tips",
            subtitle: "Get daily farming tips",
            value: farmingTips,
            onChanged: (val) {
              setState(() => farmingTips = val);
            },
          ),
        ],
      ),
    );
  }

  /// REUSABLE SWITCH ROW WIDGET
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
                  color: Color(0xFF002244),
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeTrackColor: const Color(0xFF00AA4F),
          activeColor: Colors.white,
          inactiveTrackColor: const Color(0xFFE4E6EB),
          inactiveThumbColor: Colors.white,
          trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
        ),
      ],
    );
  }
}