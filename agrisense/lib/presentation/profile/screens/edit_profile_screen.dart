import 'package:flutter/material.dart';
import '../widgets/edit_profile_header.dart';
import '../widgets/edit_profile_form.dart';
import '../widgets/form_details.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: const [
            EditProfileHeader(),

            
            SizedBox(height: 200),

            EditProfileForm(),

            SizedBox(height: 30),

            FormDetails(),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}