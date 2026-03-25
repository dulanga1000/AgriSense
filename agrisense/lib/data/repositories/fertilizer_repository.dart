import 'dart:developer' as developer; 
import 'package:agrisense/data/models/fertilizer_model.dart';
import 'agri_repository.dart';

class FertilizerRepository {
  
  final AgriRepository _api = AgriRepository();

  Future<FertilizerModel> getRecommendation(String cropType, double landSize) async {
    try {
      
      final Map<String, dynamic> data = await _api.getFertilizerRecommendation(cropType, landSize);
      
      
      return FertilizerModel.fromMap(data, cropType); 
    } catch (e, stackTrace) {
      
      developer.log(
        "Error in FertilizerRepository",
        error: e,
        stackTrace: stackTrace,
        name: "FertilizerRepository",
      );
      
      
      rethrow; 
    }
  }
}