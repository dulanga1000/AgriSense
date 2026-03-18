import 'package:flutter/material.dart';
import 'package:agrisense/presentation/common/widgets/app_back_button.dart';

class ChangeLocationHeader extends StatelessWidget {
  const ChangeLocationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF9114FF), Color(0xFF7A0BC0)],
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
                "Change Location",
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
