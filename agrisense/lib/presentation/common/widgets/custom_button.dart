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
    this.padding = const EdgeInsets.symmetric(vertical: 16),
  });

  static const _textStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static const _primaryColor = Color(0xFF0E8F3E);

  @override
  Widget build(BuildContext context) {
    if (outlined) {
      return SizedBox(
        width: width,
        child: OutlinedButton.icon(
          onPressed: onPressed,
          icon: icon != null
              ? Icon(icon, color: _primaryColor)
              : const SizedBox.shrink(),
          label: Text(
            text,
            style: _textStyle.copyWith(color: _primaryColor),
          ),
          iconAlignment: iconAlignment,
          style: OutlinedButton.styleFrom(
            foregroundColor: _primaryColor,
            side: const BorderSide(color: _primaryColor),
            padding: padding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      );
    }

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
                ? const Icon(Icons.check, color: Colors.white)
                : const SizedBox.shrink(),
            label: Text(
              text,
              style: _textStyle.copyWith(color: Colors.white),
            ),
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

    return SizedBox(
      width: width,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon != null
            ? Icon(icon, color: Colors.white)
            : const SizedBox.shrink(),
        label: Text(
          text,
          style: _textStyle.copyWith(color: Colors.white),
        ),
        iconAlignment: iconAlignment,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? _primaryColor,
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