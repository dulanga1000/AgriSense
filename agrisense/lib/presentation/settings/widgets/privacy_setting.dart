import 'package:flutter/material.dart';
import '../screens/change_password_screen.dart';
import '../screens/policy_screen.dart';
import '../screens/terms_screen.dart'; // ✅ IMPORTANT

class PrivacySetting extends StatelessWidget {
  const PrivacySetting({super.key});

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
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Privacy & Security",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          // 🔐 Change Password
          _buildNavigationTile(
            context: context,
            icon: Icons.lock_outline,
            title: "Change Password",
            screen: const ChangePasswordScreen(),
          ),

          const SizedBox(height: 16),

          // 🔒 Privacy Policy
          _buildNavigationTile(
            context: context,
            icon: Icons.privacy_tip_outlined,
            title: "Privacy Policy",
            screen: const PolicyScreen(),
          ),

          const SizedBox(height: 16),

          // 📄 Terms of Service ✅ FIXED
          _buildNavigationTile(
            context: context,
            icon: Icons.description_outlined,
            title: "Terms of Service",
            screen: const TermsScreen(),
          ),
        ],
      ),
    );
  }

  // 🔁 Reusable Navigation Tile
  Widget _buildNavigationTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Widget screen,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
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
