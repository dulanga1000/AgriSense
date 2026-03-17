import 'package:flutter/material.dart';
import 'package:agrisense/presentation/common/widgets/app_back_button.dart';

class SettingHeader extends StatelessWidget {
  const SettingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF2D6CDF),
            Color(0xFF214EBF),
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(1),
          bottomRight: Radius.circular(1),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: const [
              
              AppBackButton(fallbackIndex: 0),

              SizedBox(width: 12),

              
              Text(
                "App Settings",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}