import 'package:flutter/material.dart';

class AuthButtonModel {
  final String text;
  final IconData? icon;
  final bool outlined;

  AuthButtonModel({
    required this.text,
    this.icon,
    this.outlined = false,
  });
}