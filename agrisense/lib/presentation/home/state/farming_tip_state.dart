import 'package:flutter/material.dart';
import 'package:agrisense/data/models/farming_tip_model.dart';
import 'package:agrisense/data/repositories/farming_tip_repository.dart';

class FarmingTipState extends ChangeNotifier {
  final FarmingTipRepository repository;

  FarmingTipState(this.repository);

  List<FarmingTip> tips = [];
  bool isLoading = false;
  String? error;

  Future<void> loadTips() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      tips = await repository.getTips();
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
    notifyListeners();
  }
}
