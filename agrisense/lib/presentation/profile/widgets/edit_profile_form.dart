import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrisense/presentation/common/widgets/custom_text_field.dart';
import 'package:agrisense/presentation/common/widgets/email_textfield.dart';
import 'package:agrisense/presentation/profile/state/profile_state.dart';

class EditProfileForm extends StatefulWidget {
  final Function(
    String name,
    String email,
    String phone,
    String bio,
    String role,
  )
  onChanged;

  final GlobalKey<FormState> formKey;

  const EditProfileForm({
    super.key,
    required this.onChanged,
    required this.formKey,
  });

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _bioController;
  late TextEditingController _roleController;

  @override
  void initState() {
    super.initState();
    final user = context.read<ProfileState>().user;
    _nameController = TextEditingController(text: user.name);
    _emailController = TextEditingController(text: user.email);
    _phoneController = TextEditingController(text: user.phone);
    _bioController = TextEditingController(text: user.bio);
    _roleController = TextEditingController(text: user.role);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  void _sendData() {
    widget.onChanged(
      _nameController.text.trim(),
      _emailController.text.trim(),
      _phoneController.text.trim(),
      _bioController.text.trim(),
      _roleController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              label: 'Full Name',
              hintText: 'Enter your name',
              prefixIcon: Icons.person_outline,
              controller: _nameController,
              onChanged: (_) => _sendData(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is required';
                }
                if (value.length < 3) {
                  return 'Name must be at least 3 characters';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            EmailTextField(
              controller: _emailController,
              onChanged: (_) => _sendData(),
            ),

            const SizedBox(height: 16),

            CustomTextField(
              label: 'Phone Number',
              hintText: 'Enter your phone',
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              controller: _phoneController,
              onChanged: (_) => _sendData(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phone number is required';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            const Text(
              'Bio',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _bioController,
              maxLines: 4,
              onChanged: (_) => _sendData(),
              decoration: InputDecoration(
                hintText: 'Write something about yourself',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF0E8F3E),
                    width: 2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            CustomTextField(
              label: 'Role',
              hintText: 'Enter your role',
              prefixIcon: Icons.work_outline,
              controller: _roleController,
              onChanged: (_) => _sendData(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Role is required';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
