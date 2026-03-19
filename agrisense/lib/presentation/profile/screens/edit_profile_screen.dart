import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrisense/presentation/profile/state/profile_state.dart';
import 'package:agrisense/presentation/common/widgets/app_back_button.dart';

import '../widgets/edit_profile_image.dart';
import '../widgets/edit_profile_form.dart';
import '../widgets/form_details.dart';
import '../widgets/edit_save.dart';
import '../widgets/edit_cancel.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  void _saveChanges(BuildContext context) {
    Navigator.pop(context);
  }

  void _cancelEdit(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        leading: const AppBackButton(fallbackIndex: 0),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF00A63E), Color(0xFF008236)],
            ),
          ),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const EditProfileImage(),
            const SizedBox(height: 20),

            EditProfileForm(
              onChanged: (name, email, phone, bio, role) {
                context.read<ProfileState>().updateProfile(
                  name: name,
                  email: email,
                  phone: phone,
                  bio: bio,
                  role: role,
                );
              },
            ),

            const SizedBox(height: 20),
            const FormDetails(),

            EditSaveButton(onPressed: () => _saveChanges(context)),
            EditCancelButton(onPressed: () => _cancelEdit(context)),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
