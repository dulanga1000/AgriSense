import 'package:flutter/material.dart';
import '../screens/change_password_screen.dart'; 

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
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          const Text(
            "Privacy & Security",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          
          const SizedBox(height: 20),

          /// CHANGE PASSWORD
          _buildNavigationTile(
            icon: Icons.lock_outline,
            title: "Change Password",
            onTap: () {
              // ADDED NAVIGATION HERE
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChangePasswordScreen(),
                ),
              );
            },
          ),
          
          const SizedBox(height: 16),

          /// PRIVACY POLICY
          _buildNavigationTile(
            icon: Icons.lock_outline, 
            title: "Privacy Policy",
            onTap: () {
            },
          ),
          
          const SizedBox(height: 16),

          /// TERMS OF SERVICE
          _buildNavigationTile(
            icon: Icons.info_outline,
            title: "Terms of Service",
            onTap: () {
            },
          ),
        ],
      ),
    );
  }

  /// REUSABLE NAVIGATION ROW WIDGET
  Widget _buildNavigationTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(icon, size: 22, color: Colors.black),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}