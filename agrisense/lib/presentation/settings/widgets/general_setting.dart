import 'package:flutter/material.dart';
import '../state/setting_state.dart'; 

class GeneralSetting extends StatelessWidget {
  final SettingState settingState;

  const GeneralSetting({super.key, required this.settingState});

  @override
  Widget build(BuildContext context) {
    
    return ListenableBuilder(
      listenable: settingState,
      builder: (context, child) {
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
              
              const Text(
                "General",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

             
              _buildSwitchTile(
                icon: Icons.notifications_none,
                title: "Notifications",
                subtitle: "Enable push notifications",
                value: settingState.notifications, // Read from state
                onChanged: (val) {
                  settingState.toggleNotifications(val); // Update via state
                },
              ),

              const SizedBox(height: 16),

            
              _buildSwitchTile(
                icon: Icons.dark_mode_outlined,
                title: "Dark Mode",
                subtitle: "Switch to dark theme",
                value: settingState.darkMode,
                onChanged: (val) {
                  settingState.toggleDarkMode(val);
                },
              ),

              const SizedBox(height: 16),

              
              _buildSwitchTile(
                icon: Icons.volume_up_outlined,
                title: "Sound",
                subtitle: "Enable sound effects",
                value: settingState.sound,
                onChanged: (val) {
                  settingState.toggleSound(val);
                },
              ),

              const SizedBox(height: 16),

            
              InkWell(
                onTap: () {},
                child: Row(
                  children: const [
                    Icon(Icons.language, size: 22),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Language",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "English",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        Icon(icon, size: 22),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
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