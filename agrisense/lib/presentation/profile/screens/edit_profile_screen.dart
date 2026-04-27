import 'package:agrisense/presentation/common/widgets/gradient_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrisense/presentation/common/widgets/custom_button.dart';
import 'package:agrisense/presentation/profile/state/profile_state.dart';
import '../widgets/edit_profile_image.dart';
import '../widgets/edit_profile_form.dart';
import '../widgets/form_details.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isInitialized = false;
  bool _isSaving = false;

  late String _name;
  late String _email;
  late String _phone;
  late String _bio;
  late String _role;
  String? _imagePath;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInitialized) return;

    final user = context.read<ProfileState>().user;
    _name = user.name;
    _email = user.email;
    _phone = user.phone;
    _bio = user.bio;
    _role = user.role;
    _imagePath = user.imagePath;

    _isInitialized = true;
  }

  void _showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: const Duration(seconds: 2),
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF0C8F3E),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Profile updated successfully!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () =>
                    ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                child: const Icon(Icons.close, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: const Duration(seconds: 3),
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.red[700],
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () =>
                    ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                child: const Icon(Icons.close, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final profileState = context.read<ProfileState>();
      final originalImagePath = profileState.user.imagePath;

      print('📝 Updating profile data...');
      await profileState.updateProfile(
        name: _name,
        email: _email,
        phone: _phone,
        bio: _bio,
        role: _role,
      );
      print('✅ Profile data updated');

      if (_imagePath != null && _imagePath != originalImagePath) {
        print('🖼️ Updating profile image...');
        await profileState.updateProfileImage(_imagePath!);
        print('✅ Profile image updated');
      }

      if (!mounted) return;

      _showSuccessSnackBar();
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) Navigator.pop(context);
      });
    } catch (e) {
      if (!mounted) return;
      print('❌ Error saving profile: $e');
      final errorMsg = e.toString().replaceAll('Exception: ', '');
      _showErrorSnackBar('Error: $errorMsg');
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: const GradientAppBar(
        title: "Edit Profile",
        colors: [Color(0xFF00A63E), Color(0xFF008236)],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            EditProfileImage(
              initialImagePath: _imagePath,
              avatarLetter: _name.isNotEmpty ? _name[0].toUpperCase() : 'G',
              onImageChanged: (path) {
                _imagePath = path;
              },
            ),
            const SizedBox(height: 20),

            EditProfileForm(
              formKey: _formKey,
              onChanged: (name, email, phone, bio, role) {
                _name = name;
                _email = email;
                _phone = phone;
                _bio = bio;
                _role = role;
              },
            ),

            const SizedBox(height: 20),

            const FormDetails(),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Opacity(
                opacity: _isSaving ? 0.5 : 1.0,
                child: IgnorePointer(
                  ignoring: _isSaving,
                  child: CustomButton(
                    text: _isSaving ? 'Saving...' : 'Save Changes',
                    onPressed: _onSave,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                text: 'Cancel',
                outlined: true,
                onPressed: () => Navigator.pop(context),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
