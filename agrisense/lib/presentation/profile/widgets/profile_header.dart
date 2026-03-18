import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrisense/presentation/profile/state/profile_state.dart';
import 'package:agrisense/presentation/common/widgets/app_back_button.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<ProfileState>().user;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // GREEN HEADER
        Container(
          height: 160,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4CAF50), Color(0xFF0D520F)],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28),
            ),
          ),
        ),

        const Positioned(
          top: 0,
          left: 0,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 16, top: 6),
              child: AppBackButton(fallbackIndex: 0),
            ),
          ),
        ),

        // PROFILE CARD
        Positioned(
          top: 95,
          left: 40,
          right: 40,
          child: Container(
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
                // PROFILE IMAGE + NAME
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: const Color(0xFF4CAF50),
                      backgroundImage: user.imagePath != null
                          ? FileImage(File(user.imagePath!))
                          : null,
                      child: user.imagePath == null
                          ? Text(
                              user.avatarLetter,
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          user.role,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                _infoRow(Icons.location_on, user.location),
                const SizedBox(height: 8),
                _infoRow(Icons.phone, user.phone),
                const SizedBox(height: 8),
                _infoRow(Icons.email, user.email),
                const SizedBox(height: 8),
                _infoRow(
                  Icons.calendar_today,
                  "Member since ${user.memberSince}",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF0C8F3E)),
        const SizedBox(width: 8),
        Expanded(child: Text(text)),
      ],
    );
  }
}
