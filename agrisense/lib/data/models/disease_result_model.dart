class DiseaseResultModel {
  final String diseaseName;
  final String scientificName;
  final double confidence;
  final List<String> symptoms;
  final List<String> treatments;
  final List<String> preventions;

  const DiseaseResultModel({
    required this.diseaseName,
    required this.scientificName,
    required this.confidence,
    required this.symptoms,
    required this.treatments,
    required this.preventions,
  });

  factory DiseaseResultModel.fromJson(Map<String, dynamic> json) {
    return DiseaseResultModel(
      diseaseName: json['disease_name'],
      scientificName: json['scientific_name'],
      confidence: (json['confidence'] ?? 0).toDouble(),
      symptoms: List<String>.from(json['symptoms']),
      treatments: List<String>.from(json['treatments']),
      preventions: List<String>.from(json['preventions']),
    );
  }
}
