import 'package:flutter/material.dart';

class SettingState extends ChangeNotifier {
  bool notifications = true;
  bool darkMode = false;
  bool sound = true;

  bool diseaseAlerts = true;
  bool weatherUpdates = true;
  bool farmingTips = true;

  bool autoUpdate = true;

  void toggleNotifications(bool val) {
    notifications = val;
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
    notifyListeners();
  }

  void toggleWeatherUpdates(bool val) {
    weatherUpdates = val;
    notifyListeners();
  }

  void toggleFarmingTips(bool val) {
    farmingTips = val;
    notifyListeners();
  }

  void toggleAutoUpdate(bool val) {
    autoUpdate = val;
    notifyListeners();
  }
}
