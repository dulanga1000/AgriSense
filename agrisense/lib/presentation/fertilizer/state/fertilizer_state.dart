import 'package:flutter/material.dart';
import 'package:agrisense/data/models/fertilizer_model.dart';
import 'package:agrisense/data/repositories/fertilizer_repository.dart';

class FertilizerState extends ChangeNotifier {
  final FertilizerRepository _repository;

  FertilizerState(this._repository);

  FertilizerModel? _recommendation;
  bool _isLoading = false;
  String? _error;

  FertilizerModel? get recommendation => _recommendation;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> getRecommendation(String cropType, double landSize) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _repository.getRecommendation(cropType, landSize);
      _recommendation = result;
    } catch (e) {
      _error = "Failed to load recommendation";
      _recommendation = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  void clear() {
    _recommendation = null;
    _error = null;
    notifyListeners();
  }
}