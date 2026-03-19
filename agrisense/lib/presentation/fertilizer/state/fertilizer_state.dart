import 'package:flutter/material.dart';
import 'package:agrisense/data/models/fertilizer_model.dart';
import 'package:agrisense/data/repositories/fertilizer_repository.dart';

class FertilizerState extends ChangeNotifier {
  final FertilizerRepository _repository;

  FertilizerState(this._repository);

  FertilizerModel? recommendation;
  bool isLoading = false;

  Future<void> getRecommendation(String cropType, double landSize) async {
    isLoading = true;
    notifyListeners();

    recommendation = await _repository.getRecommendation(cropType, landSize);

    isLoading = false;
    notifyListeners();
  }
}
