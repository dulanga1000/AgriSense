import 'dart:io';
import 'package:agrisense/data/models/disease_result_model.dart';

class DiseaseRepository {
  Future<DiseaseResultModel> analyzeImage(File image) async {
    await Future.delayed(const Duration(seconds: 2));

    return const DiseaseResultModel(
      diseaseName: 'Leaf Spot',
      scientificName: 'Cercospora spp.',
      confidence: 0.92,
      symptoms: [
        'Small brown or dark spots on leaves',
        'Yellow halo around lesions',
        'Premature leaf drop in severe cases',
      ],
      treatments: [
        'Remove and destroy infected leaves',
        'Apply a suitable fungicide as directed',
        'Avoid overhead irrigation late in the day',
      ],
      preventions: [
        'Ensure good airflow between plants',
        'Water at soil level to keep leaves dry',
        'Use disease-free seeds and tools',
      ],
    );
  }
}
