// presentation/common/widgets/custom_button.dart

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Gradient? gradient;
  final IconData? icon;
  final IconAlignment iconAlignment;
  final bool outlined;
  final double? width;
  final EdgeInsetsGeometry padding;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.gradient,
    this.icon,
    this.iconAlignment = IconAlignment.start,
    this.outlined = false,
    this.width = double.infinity,
    this.padding = const EdgeInsets.symmetric(
      vertical: 16,
    ), // ← matches GoogleAuthButton
  });

  // ── shared text style — matches GoogleAuthButton ───────────────
  static const _textStyle = TextStyle(
    fontSize: 18, // ← matches GoogleAuthButton
    fontWeight: FontWeight.w500, // ← matches GoogleAuthButton
  );

  @override
  Widget build(BuildContext context) {
    // ── Outlined ───────────────────────────────────────────────
    if (outlined) {
      return SizedBox(
        width: width,
        child: OutlinedButton.icon(
          onPressed: onPressed,
          icon: icon != null ? Icon(icon) : const SizedBox.shrink(),
          label: Text(text, style: _textStyle),
          iconAlignment: iconAlignment,
          style: OutlinedButton.styleFrom(
            padding: padding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      );
    }

    // ── Gradient ───────────────────────────────────────────────
    if (gradient != null) {
      return SizedBox(
        width: width,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ElevatedButton.icon(
            onPressed: onPressed,
            icon: icon != null
                ? Icon(icon, color: Colors.white)
                : const SizedBox.shrink(),
            label: Text(text, style: _textStyle.copyWith(color: Colors.white)),
            iconAlignment: iconAlignment,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              foregroundColor: Colors.white,
              padding: padding,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      );
    }

    // ── Solid (default) ────────────────────────────────────────
    return SizedBox(
      width: width,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon != null
            ? Icon(icon, color: Colors.white)
            : const SizedBox.shrink(),
        label: Text(text, style: _textStyle.copyWith(color: Colors.white)),
        iconAlignment: iconAlignment,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? const Color(0xFF0E8F3E),
          foregroundColor: Colors.white,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
