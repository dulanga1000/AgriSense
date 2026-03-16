import 'package:flutter/material.dart';
import '../widgets/edit_profile_header.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            
            const EditProfileHeader(),

            const SizedBox(height: 200),

            
            const EditProfileForm(),

            const SizedBox(height: 20),

            
            const FormDetails(),

            const SizedBox(height: 10),

            
            EditSaveButton(
              onPressed: () => _saveChanges(context),
            ),

            
            EditCancelButton(
              onPressed: () => _cancelEdit(context),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}