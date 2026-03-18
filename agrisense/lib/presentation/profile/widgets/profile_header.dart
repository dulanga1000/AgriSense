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

        Positioned(
          top: 95,
          left: 20,
          right: 20,
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
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: const Color(0xFF4CAF50),
                      backgroundImage: user.imagePath != null
                          ? FileImage(File(user.imagePath!))
                          : null,
                      child: user.imagePath == null
                          ? Text(
                              user.avatarLetter,
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : null,
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFF4CAF50,
                              ).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              user.role.isNotEmpty ? user.role : "No Role",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF0C8F3E),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
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
        Expanded(
          child: Text(
            text.isNotEmpty ? text : "-",
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }
}
