import 'package:flutter/material.dart';

class SettingState extends ChangeNotifier {
  bool notifications = true;
  bool darkMode = false;
  bool sound = true;

  bool diseaseAlerts = true;
  bool weatherUpdates = true;
  bool farmingTips = true;

  bool autoUpdate = true;

  // Callback to update notification state when settings change
  VoidCallback? _onNotificationSettingsChanged;

  void setNotificationSettingsCallback(VoidCallback callback) {
    _onNotificationSettingsChanged = callback;
  }

  void toggleNotifications(bool val) {
    notifications = val;
    _notifyNotificationSettingsChanged();
    notifyListeners();
  }

  void toggleDarkMode(bool val) {
    darkMode = val;
    notifyListeners();
  }

  void toggleSound(bool val) {
    sound = val;
    notifyListeners();
  }

  void toggleDiseaseAlerts(bool val) {
    diseaseAlerts = val;
    _notifyNotificationSettingsChanged();
    notifyListeners();
  }

  void toggleWeatherUpdates(bool val) {
    weatherUpdates = val;
    _notifyNotificationSettingsChanged();
    notifyListeners();
  }

  void toggleFarmingTips(bool val) {
    farmingTips = val;
    _notifyNotificationSettingsChanged();
    notifyListeners();
  }

  void toggleAutoUpdate(bool val) {
    autoUpdate = val;
    notifyListeners();
  }

  void _notifyNotificationSettingsChanged() {
    _onNotificationSettingsChanged?.call();
  }
}
