import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingState extends ChangeNotifier {
  bool notifications = true;
  bool darkMode = false;
  bool sound = true;

  bool diseaseAlerts = true;
  bool weatherUpdates = true;
  bool farmingTips = true;
  bool authAlerts = true;

  bool autoUpdate = true;

  // Persistence keys
  static const _notificationsKey = 'setting_notifications';
  static const _darkModeKey = 'setting_darkMode';
  static const _soundKey = 'setting_sound';
  static const _diseaseAlertsKey = 'setting_diseaseAlerts';
  static const _weatherUpdatesKey = 'setting_weatherUpdates';
  static const _farmingTipsKey = 'setting_farmingTips';
  static const _authAlertsKey = 'setting_authAlerts';
  static const _autoUpdateKey = 'setting_autoUpdate';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Callback to update notification state when settings change
  VoidCallback? _onNotificationSettingsChanged;

  void setNotificationSettingsCallback(VoidCallback callback) {
    _onNotificationSettingsChanged = callback;
  }

  /// Load settings from Firestore first, then SharedPreferences fallback
  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final currentUser = _auth.currentUser;

    // Try Firestore first
    if (currentUser != null) {
      try {
        final doc = await _firestore
            .collection('users')
            .doc(currentUser.uid)
            .collection('settings')
            .doc('app_settings')
            .get();
        if (doc.exists && doc.data() != null) {
          final data = doc.data()!;
          notifications = data[_notificationsKey] ?? true;
          darkMode = data[_darkModeKey] ?? false;
          sound = data[_soundKey] ?? true;
          diseaseAlerts = data[_diseaseAlertsKey] ?? true;
          weatherUpdates = data[_weatherUpdatesKey] ?? true;
          farmingTips = data[_farmingTipsKey] ?? true;
          authAlerts = data[_authAlertsKey] ?? true;
          autoUpdate = data[_autoUpdateKey] ?? true;

          // Update local cache
          await _saveLocally(prefs);
          notifyListeners();
          return;
        }
      } catch (e) {
        // Silently fall through to local cache
      }
    }

    // Fallback to SharedPreferences
    notifications = prefs.getBool(_notificationsKey) ?? true;
    darkMode = prefs.getBool(_darkModeKey) ?? false;
    sound = prefs.getBool(_soundKey) ?? true;
    diseaseAlerts = prefs.getBool(_diseaseAlertsKey) ?? true;
    weatherUpdates = prefs.getBool(_weatherUpdatesKey) ?? true;
    farmingTips = prefs.getBool(_farmingTipsKey) ?? true;
    authAlerts = prefs.getBool(_authAlertsKey) ?? true;
    autoUpdate = prefs.getBool(_autoUpdateKey) ?? true;

    notifyListeners();
  }

  void toggleNotifications(bool val) {
    notifications = val;
    _notifyNotificationSettingsChanged();
    _saveSettings();
    notifyListeners();
  }

  void toggleDarkMode(bool val) {
    darkMode = val;
    _saveSettings();
    notifyListeners();
  }

  void toggleSound(bool val) {
    sound = val;
    _saveSettings();
    notifyListeners();
  }

  void toggleDiseaseAlerts(bool val) {
    diseaseAlerts = val;
    _notifyNotificationSettingsChanged();
    _saveSettings();
    notifyListeners();
  }

  void toggleWeatherUpdates(bool val) {
    weatherUpdates = val;
    _notifyNotificationSettingsChanged();
    _saveSettings();
    notifyListeners();
  }

  void toggleFarmingTips(bool val) {
    farmingTips = val;
    _notifyNotificationSettingsChanged();
    _saveSettings();
    notifyListeners();
  }

  void toggleAuthAlerts(bool val) {
    authAlerts = val;
    _notifyNotificationSettingsChanged();
    _saveSettings();
    notifyListeners();
  }

  void toggleAutoUpdate(bool val) {
    autoUpdate = val;
    _saveSettings();
    notifyListeners();
  }

  void _notifyNotificationSettingsChanged() {
    _onNotificationSettingsChanged?.call();
  }

  /// Persist settings to both SharedPreferences and Firestore
  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await _saveLocally(prefs);

    // Sync to Firestore
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      try {
        await _firestore
            .collection('users')
            .doc(currentUser.uid)
            .collection('settings')
            .doc('app_settings')
            .set(_toMap(), SetOptions(merge: true));
      } catch (e) {
        // Silent error - local save still works
      }
    }
  }

  Future<void> _saveLocally(SharedPreferences prefs) async {
    await prefs.setBool(_notificationsKey, notifications);
    await prefs.setBool(_darkModeKey, darkMode);
    await prefs.setBool(_soundKey, sound);
    await prefs.setBool(_diseaseAlertsKey, diseaseAlerts);
    await prefs.setBool(_weatherUpdatesKey, weatherUpdates);
    await prefs.setBool(_farmingTipsKey, farmingTips);
    await prefs.setBool(_authAlertsKey, authAlerts);
    await prefs.setBool(_autoUpdateKey, autoUpdate);
  }

  Map<String, dynamic> _toMap() {
    return {
      _notificationsKey: notifications,
      _darkModeKey: darkMode,
      _soundKey: sound,
      _diseaseAlertsKey: diseaseAlerts,
      _weatherUpdatesKey: weatherUpdates,
      _farmingTipsKey: farmingTips,
      _authAlertsKey: authAlerts,
      _autoUpdateKey: autoUpdate,
    };
  }

  /// Reset settings to defaults and clear local cache on logout
  Future<void> resetForLogout() async {
    notifications = true;
    darkMode = false;
    sound = true;
    diseaseAlerts = true;
    weatherUpdates = true;
    farmingTips = true;
    authAlerts = true;
    autoUpdate = true;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_notificationsKey);
    await prefs.remove(_darkModeKey);
    await prefs.remove(_soundKey);
    await prefs.remove(_diseaseAlertsKey);
    await prefs.remove(_weatherUpdatesKey);
    await prefs.remove(_farmingTipsKey);
    await prefs.remove(_authAlertsKey);
    await prefs.remove(_autoUpdateKey);

    notifyListeners();
  }
}
