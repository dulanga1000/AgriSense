import 'dart:io';
import 'package:agrisense/data/models/disease_result_model.dart';

class DiseaseRepository {
  Future<DiseaseResultModel> detectDisease(File image) async {
    await Future.delayed(const Duration(seconds: 2));

    return const DiseaseResultModel(
      diseaseName: "Late Blight",
      scientificName: "Phytophthora infestans",
      confidence: 0.92,
      symptoms: [
        "Dark brown spots on leaves",
        "White fungal growth on leaf undersides",
        "Rapid wilting and decay",
        "Affected stems turn black",
      ],
      treatments: [
        "Remove and destroy infected plants immediately",
        "Apply copper-based fungicides",
        "Use Mancozeb (2g per liter) spray every 7-10 days",
        "Ensure proper drainage in the field",
      ],
      preventions: [
        "Use disease-resistant varieties",
        "Maintain proper plant spacing",
        "Avoid overhead irrigation",
        "Apply preventive fungicide sprays during humid weather",
        "Remove plant debris after harvest",
      ],
    );
  }
}
