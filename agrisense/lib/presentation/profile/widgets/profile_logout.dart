import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrisense/core/routes/app_routes.dart';
import 'package:agrisense/presentation/auth/state/auth_provider.dart';
import 'package:agrisense/presentation/profile/state/profile_state.dart';
import 'package:agrisense/presentation/disease/state/disease_state.dart';
import 'package:agrisense/presentation/home/state/farming_tip_state.dart';
import 'package:agrisense/presentation/settings/state/location_state.dart';
import 'package:agrisense/presentation/settings/state/setting_state.dart';
import 'package:agrisense/presentation/weather/state/weather_state.dart';
import 'package:agrisense/presentation/notification/state/notification_state.dart';
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
    final auth = context.read<AuthProvider>();
    final profile = context.read<ProfileState>();
    final disease = context.read<DiseaseState>();
    final tips = context.read<FarmingTipState>();
    final location = context.read<LocationState>();
    final weather = context.read<WeatherState>();
    final notifications = context.read<NotificationState>();
    final settings = context.read<SettingState>();

    try {
      await auth.logout();
      await profile.resetToGuest();
      disease.reset();
      tips.resetForLogout();
      location.resetForLogout();
      weather.resetForLogout();
      notifications.resetForLogout();
      await settings.resetForLogout();

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
