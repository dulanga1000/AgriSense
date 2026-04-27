class FarmStatsModel {
  final int acres;
  final int scans;
  final int crops;
  final int experience;
  final Set<String> scannedCropNames;

  FarmStatsModel({
    required this.acres,
    required this.scans,
    required this.crops,
    required this.experience,
    Set<String>? scannedCropNames,
  }) : scannedCropNames = scannedCropNames ?? {};

  factory FarmStatsModel.empty() {
    return FarmStatsModel(
      acres: 0,
      scans: 0,
      crops: 0,
      experience: 0,
      scannedCropNames: {},
    );
  }

  factory FarmStatsModel.fromMap(Map<String, dynamic> map) {
    final cropNames = <String>{};
    if (map['scannedCropNames'] != null) {
      cropNames.addAll(List<String>.from(map['scannedCropNames']));
    }
    return FarmStatsModel(
      acres: map['acres'] ?? 0,
      scans: map['scans'] ?? 0,
      crops: map['crops'] ?? cropNames.length,
      experience: map['experience'] ?? 0,
      scannedCropNames: cropNames,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'acres': acres,
      'scans': scans,
      'crops': crops,
      'experience': experience,
      'scannedCropNames': scannedCropNames.toList(),
    };
  }

  FarmStatsModel copyWith({
    int? acres,
    int? scans,
    int? crops,
    int? experience,
    Set<String>? scannedCropNames,
  }) {
    return FarmStatsModel(
      acres: acres ?? this.acres,
      scans: scans ?? this.scans,
      crops: crops ?? this.crops,
      experience: experience ?? this.experience,
      scannedCropNames: scannedCropNames ?? this.scannedCropNames,
    );
  }
}