import 'package:flutter/material.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_farm.dart';
import '../widgets/profile_setting.dart';
import '../widgets/profile_logout.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(),
            const SizedBox(height: 150),

            
            const ProfileFarm(),
            const SizedBox(height: 20),

            
            const ProfileSetting(),
            const SizedBox(height: 20),

            
            const ProfileLogout(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
