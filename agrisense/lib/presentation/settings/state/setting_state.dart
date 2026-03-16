import 'package:flutter/material.dart';

class SettingState extends ChangeNotifier {
  
  bool _notifications = false;
  bool _darkMode = true;
  bool _sound = false;

  
  bool get notifications => _notifications;
  bool get darkMode => _darkMode;
  bool get sound => _sound;

  
  void toggleNotifications(bool value) {
    _notifications = value;
    notifyListeners(); 
  }

  void toggleDarkMode(bool value) {
    _darkMode = value;
    notifyListeners();
  }

  void toggleSound(bool value) {
    _sound = value;
    notifyListeners();
  }
}