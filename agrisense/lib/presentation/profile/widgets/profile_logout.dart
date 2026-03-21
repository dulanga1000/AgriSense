import 'package:flutter/material.dart';
import 'package:agrisense/core/routes/app_routes.dart';
import 'package:agrisense/presentation/common/widgets/custom_button.dart';

class ProfileLogout extends StatefulWidget {
  const ProfileLogout({super.key});

  @override
  State<ProfileLogout> createState() => _ProfileLogoutState();
}

class _ProfileLogoutState extends State<ProfileLogout> {
  bool _isLoading = false;

  Future<void> _handleLogout() async {
    setState(() => _isLoading = true);

    try {
      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logout failed: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFFFF2D2D)),
            )
          : CustomButton(
              text: 'Logout',
              icon: Icons.logout,
              backgroundColor: const Color(0xFFFF2D2D),
              onPressed: _handleLogout,
            ),
    );
  }
}
