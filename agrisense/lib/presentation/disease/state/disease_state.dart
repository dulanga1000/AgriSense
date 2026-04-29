import 'dart:io';
import 'package:flutter/material.dart';
import 'package:agrisense/data/models/disease_result_model.dart';
import 'package:agrisense/data/repositories/disease_repository.dart';

class DiseaseState extends ChangeNotifier {
  final DiseaseRepository _repository;

  DiseaseState(this._repository);

  File? _selectedImage;
  bool _isAnalyzing = false;
  DiseaseResultModel? _result;
  String? _errorMessage;

  File? get selectedImage => _selectedImage;
  bool get isAnalyzing => _isAnalyzing;
  DiseaseResultModel? get result => _result;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null && _errorMessage!.isNotEmpty;
  bool get hasResult => _result != null;
  bool get hasImage => _selectedImage != null;

  void onImageSelected(File image) {
    _selectedImage = image;
    _result = null;
    _errorMessage = null;
    notifyListeners();
  }

  void onChangeImage() {
    _selectedImage = null;
    _result = null;
    _errorMessage = null;
    notifyListeners();
  }

  // ✅ NEW: Now returns a bool (true = success, false = failed)
  Future<bool> detectDisease() async {
    if (_selectedImage == null || _isAnalyzing) return false;

    _isAnalyzing = true;
    _result = null;
    _errorMessage = null;
    notifyListeners();

    try {
      _result = await _repository.analyzeImage(_selectedImage!);
      return true; // ✅ Success! Return true
    } catch (e, st) {
      _errorMessage =
          'Failed to analyze image. Ensure model and labels are loaded.';
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: e,
          stack: st,
          library: 'disease_state',
          context: ErrorDescription('while analyzing plant image'),
        ),
      );
      return false; // Failed
    } finally {
      _isAnalyzing = false;
      notifyListeners();
    }
  }

  void reset() {
    _selectedImage = null;
    _result = null;
    _isAnalyzing = false;
    _errorMessage = null;
    notifyListeners();
  }
}
