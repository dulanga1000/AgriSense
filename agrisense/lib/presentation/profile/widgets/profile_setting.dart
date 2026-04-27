import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrisense/presentation/profile/state/profile_state.dart';
import '../screens/edit_profile_screen.dart';
import '../../settings/screens/app_setting_screen.dart';
import '../../settings/screens/location_change_screen.dart';
import '../../settings/screens/change_password_screen.dart';

class ProfileSetting extends StatelessWidget {
  const ProfileSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
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
          const Row(
            children: [
              Icon(Icons.settings, size: 20, color: Colors.black87),
              SizedBox(width: 8),
              Text(
                "Settings",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(height: 16),

          _buildSettingTile(
            context,
            icon: Icons.person_outline,
            title: "Edit Profile",
            onTap: () {
              final profileState = context.read<ProfileState>();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChangeNotifierProvider.value(
                    value: profileState,
                    child: const EditProfileScreen(),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 12),

          _buildSettingTile(
            context,
            icon: Icons.settings_outlined,
            title: "App Settings",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AppSettingScreen()),
              );
            },
          ),

          const SizedBox(height: 12),

          _buildSettingTile(
            context,
            icon: Icons.location_on_outlined,
            title: "Change Location",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LocationChangeScreen()),
              );
            },
          ),

          const SizedBox(height: 12),

          _buildSettingTile(
            context,
            icon: Icons.lock_outlined,
            title: "Change Password",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChangePasswordScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey[700], size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
