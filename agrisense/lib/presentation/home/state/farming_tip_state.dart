import 'package:flutter/material.dart';
import 'package:agrisense/data/models/farming_tip_model.dart';
import 'package:agrisense/data/repositories/farming_tip_repository.dart';

class FarmingTipState extends ChangeNotifier {
  final FarmingTipRepository repository;
  String _lastLoadedLocation = 'Colombo, Western Province';

  FarmingTipState(this.repository);

  List<FarmingTip> tips = [];
  bool isLoading = false;
  String? error;

  Future<void> loadTips({String? location, bool forceReload = false}) async {
    final requestedLocation = (location ?? _lastLoadedLocation).trim().isEmpty
        ? 'Colombo, Western Province'
        : (location ?? _lastLoadedLocation).trim();

    if (!forceReload &&
        requestedLocation == _lastLoadedLocation &&
        tips.isNotEmpty) {
      return;
    }

    try {
      isLoading = true;
      error = null;
      notifyListeners();

      tips = await repository.getTips(requestedLocation);
      _lastLoadedLocation = requestedLocation;
    } catch (e) {
      error = "Failed to load tips";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void resetForLogout() {
    tips = [];
    isLoading = false;
    error = null;
    _lastLoadedLocation = 'Colombo, Western Province';
    notifyListeners();
  }
}
