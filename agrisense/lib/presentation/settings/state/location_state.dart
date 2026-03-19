import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationState extends ChangeNotifier {
  String _currentLocation = 'Gampaha, Western Province';
  bool _isLoading = false;
  String? _error;

  String get currentLocation => _currentLocation;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void setLocation(String location) {
    _currentLocation = location;
    _error = null;
    notifyListeners();
  }

  Future<void> detectMyLocation() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _error = 'Location services are disabled.';
        _isLoading = false;
        notifyListeners();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _error = 'Location permission denied.';
          _isLoading = false;
          notifyListeners();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _error = 'Location permission permanently denied.';
        _isLoading = false;
        notifyListeners();
        return;
      }

      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks.first;
        final String city = place.locality ?? place.subAdministrativeArea ?? '';
        final String province = place.administrativeArea ?? '';
        _currentLocation = [
          city,
          province,
        ].where((s) => s.isNotEmpty).join(', ');
        if (_currentLocation.isEmpty) _currentLocation = 'Unknown Location';
      }
    } catch (e) {
      _error = 'Failed to detect location. Please try again.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
