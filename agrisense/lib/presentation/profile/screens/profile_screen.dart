import 'package:flutter/material.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_farm.dart';
import '../widgets/profile_setting.dart';
import '../widgets/profile_logout.dart';
import 'package:agrisense/data/models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserModel(
      id: '1',
      name: "Guest",
      role: "Farmer",
      location: "Western Province, Sri Lanka",
      phone: "+91 98765 43210",
      email: "guest@email.com",
      memberSince: "Jan 2024",
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(user: user),

            const SizedBox(height: 150),

            /// FARM DETAILS CARD
            const ProfileFarm(),

            const SizedBox(height: 20),

            /// SETTINGS CARD
            const ProfileSetting(),

            const SizedBox(height: 20),

            /// LOGOUT BUTTON  (ADD THIS)
            const ProfileLogout(),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}