import 'package:flutter/material.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_farm.dart';
import '../widgets/profile_setting.dart';
import '../widgets/profile_logout.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ProfileScreenBody();
  }
}

class _ProfileScreenBody extends StatelessWidget {
  const _ProfileScreenBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: const [
            ProfileHeader(),
            SizedBox(height: 200),
            ProfileFarm(),
            SizedBox(height: 20),
            ProfileSetting(),
            SizedBox(height: 20),
            ProfileLogout(),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
