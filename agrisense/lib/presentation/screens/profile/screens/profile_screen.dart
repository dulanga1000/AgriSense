import 'package:flutter/material.dart';
import 'widgets/profile_header.dart';
import '../../../data/models/user_model.dart';

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
            
            // This spacer prevents content from hiding behind the overlapping card
            const SizedBox(height: 150), 
            
            // Further profile items (Settings, Log Out, etc.) will go here
          ],
        ),
      ),
    );
  }
}