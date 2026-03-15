import 'package:flutter/material.dart';
import 'package:agrisense/data/models/user_model.dart';

class EditProfileHeader extends StatefulWidget {
  const EditProfileHeader({super.key});

  @override
  State<EditProfileHeader> createState() => _EditProfileHeaderState();
}

class _EditProfileHeaderState extends State<EditProfileHeader> {

  final UserModel user = UserModel(
    id: '1',
    name: "Guest",
    role: "Farmer",
    location: "Western Province, Sri Lanka",
    phone: "+91 98765 43210",
    email: "guest@email.com",
    memberSince: "Jan 2024",
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [

        Container(
          height: 130,
          decoration: const BoxDecoration(
            color: Color(0xFF0C8F3E),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(1),
              bottomRight: Radius.circular(1),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [

                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(width: 12),

                  const Text(
                    "Edit Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const Spacer(),

                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1FA755),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.save_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        Positioned(
          top: 150,
          left: 20,
          right: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 26),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
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
              children: [

                Stack(
                  clipBehavior: Clip.none,
                  children: [

                    CircleAvatar(
                      radius: 40,
                      backgroundColor: const Color(0xFF12B24B),
                      child: Text(
                        user.avatarLetter,
                        style: const TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Color(0xFF0C8F3E),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 12),

                const Text(
                  "Tap to change profile picture",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}