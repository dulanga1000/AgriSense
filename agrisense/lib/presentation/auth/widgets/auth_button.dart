import 'package:flutter/material.dart';
import 'package:agrisense/data/models/auth_button_model.dart';

class AuthButton extends StatelessWidget {
  final AuthButtonModel button;
  final VoidCallback onPressed;

  const AuthButton({
    super.key,
    required this.button,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {

    final iconWidget = button.icon != null ? Icon(button.icon) : null;

    return SizedBox(
      width: double.infinity,
      child: button.outlined
          ? OutlinedButton.icon(
              onPressed: onPressed,
              icon: iconWidget ?? const SizedBox(),
              label: Text(button.text),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            )
          : ElevatedButton.icon(
              onPressed: onPressed,
              icon: iconWidget ?? const SizedBox(),
              label: Text(
                button.text,
                style: const TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0E8F3E),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
    );
  }
}