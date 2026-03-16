import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrisense/presentation/profile/state/profile_state.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_farm.dart';
import '../widgets/profile_setting.dart';
import '../widgets/profile_logout.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileState(),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          child: Column(
            children: const [
              ProfileHeader(),
              SizedBox(height: 150),
              ProfileFarm(),
              SizedBox(height: 20),
              ProfileSetting(),
              SizedBox(height: 20),
              ProfileLogout(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
