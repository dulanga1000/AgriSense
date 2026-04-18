import 'package:flutter/material.dart';
import 'package:agrisense/data/models/fertilizer_model.dart';
import 'package:agrisense/data/repositories/fertilizer_repository.dart';

class FertilizerState extends ChangeNotifier {
  final FertilizerRepository _repository;

  FertilizerState(this._repository);

  FertilizerModel? recommendation;
  bool isLoading = false;
  String? errorMessage;
  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;

  Future<void> getRecommendation(String cropType, double landSize) async {
    isLoading = true;
    errorMessage = null;
    recommendation = null;
    notifyListeners();

    try {
      recommendation = await _repository.getRecommendation(cropType, landSize);
    } catch (e) {
      final message = e.toString().replaceFirst('Exception: ', '').trim();
      errorMessage = message.isEmpty
          ? "Failed to get AI recommendation. Please try again."
          : message;
      debugPrint("Fertilizer recommendation error: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}
