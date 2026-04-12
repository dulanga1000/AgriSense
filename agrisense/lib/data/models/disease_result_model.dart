class DiseaseResultModel {
  final String plantName;
  final String diseaseName;
  final String scientificName;
  final double confidence;
  final List<String> symptoms;
  final List<String> treatments;
  final List<String> preventions;

  const DiseaseResultModel({
    required this.plantName,
    required this.diseaseName,
    required this.scientificName,
    required this.confidence,
    required this.symptoms,
    required this.treatments,
    required this.preventions,
  });

  DiseaseResultModel copyWith({
    String? plantName,
    String? diseaseName,
    String? scientificName,
    double? confidence,
    List<String>? symptoms,
    List<String>? treatments,
    List<String>? preventions,
  }) {
    return DiseaseResultModel(
      plantName: plantName ?? this.plantName,
      diseaseName: diseaseName ?? this.diseaseName,
      scientificName: scientificName ?? this.scientificName,
      confidence: confidence ?? this.confidence,
      symptoms: symptoms ?? this.symptoms,
      treatments: treatments ?? this.treatments,
      preventions: preventions ?? this.preventions,
    );
  }

  factory DiseaseResultModel.fromJson(Map<String, dynamic> json) {
    return DiseaseResultModel(
      plantName:
          (json['plant_name'] ?? json['plantName']) as String? ?? 'Unknown',
      diseaseName: json['disease_name'] as String? ?? 'Unknown',
      scientificName: json['scientific_name'] as String? ?? 'Unknown',
      confidence: (json['confidence'] ?? 0).toDouble(),
      symptoms: List<String>.from(json['symptoms'] ?? []),
      treatments: List<String>.from(json['treatments'] ?? []),
      preventions: List<String>.from(json['preventions'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plant_name': plantName,
      'disease_name': diseaseName,
      'scientific_name': scientificName,
      'confidence': confidence,
      'symptoms': symptoms,
      'treatments': treatments,
      'preventions': preventions,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiseaseResultModel &&
          other.plantName == plantName &&
          other.diseaseName == diseaseName &&
          other.scientificName == scientificName &&
          other.confidence == confidence;

  @override
  int get hashCode =>
      plantName.hashCode ^
      diseaseName.hashCode ^
      scientificName.hashCode ^
      confidence.hashCode;

  @override
  String toString() =>
      'DiseaseResultModel('
      'plantName: $plantName, '
      'diseaseName: $diseaseName, '
      'scientificName: $scientificName, '
      'confidence: ${(confidence * 100).toStringAsFixed(0)}%, '
      'symptoms: ${symptoms.length}, '
      'treatments: ${treatments.length}, '
      'preventions: ${preventions.length}'
      ')';

  String get confidencePercent => '${(confidence * 100).toInt()}%';

  String get severityLevel {
    if (confidence >= 0.85) return 'High';
    if (confidence >= 0.60) return 'Medium';
    return 'Low';
  }
}
