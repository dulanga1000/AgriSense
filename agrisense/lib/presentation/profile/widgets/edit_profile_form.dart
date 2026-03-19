import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  const EditProfileForm({super.key, required this.onChanged});

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
    _roleController = TextEditingController(text: user.role);
    _nameController = TextEditingController(text: user.name);
    _emailController = TextEditingController(text: user.email);
    _phoneController = TextEditingController(text: user.phone);
    _bioController = TextEditingController(text: user.bio);
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label("Full Name"),
          const SizedBox(height: 6),
          _field(_nameController, Icons.person_outline),

          const SizedBox(height: 16),

          _label("Email"),
          const SizedBox(height: 6),
          _field(_emailController, Icons.email_outlined),

          const SizedBox(height: 16),

          _label("Phone Number"),
          const SizedBox(height: 6),
          _field(_phoneController, Icons.phone_outlined),

          const SizedBox(height: 16),

          _label("Bio"),
          const SizedBox(height: 6),
          TextField(
            controller: _bioController,
            maxLines: 4,
            onChanged: (_) => _sendData(),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _label("Role"),
          const SizedBox(height: 6),
          _field(_roleController, Icons.work_outline),
        ],
      ),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    );
  }

  Widget _field(TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      onChanged: (_) => _sendData(),
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
