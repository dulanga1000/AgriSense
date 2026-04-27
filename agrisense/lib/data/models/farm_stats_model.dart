class FarmStatsModel {
  final int acres;
  final int scans;
  final int crops;
  final int experience;

  FarmStatsModel({
    required this.acres,
    required this.scans,
    required this.crops,
    required this.experience,
  });

  // Convert from Firebase/Local Map to Object
  factory FarmStatsModel.fromMap(Map<String, dynamic> map) {
    return FarmStatsModel(
      acres: map['acres'] ?? 0,
      scans: map['scans'] ?? 0,
      crops: map['crops'] ?? 0,
      experience: map['experience'] ?? 0,
    );
  }

  // Convert Object to Firebase/Local Map
  Map<String, dynamic> toMap() {
    return {
      'acres': acres,
      'scans': scans,
      'crops': crops,
      'experience': experience,
    };
  }

  // Helper to update just one field easily
  FarmStatsModel copyWith({
    int? acres,
    int? scans,
    int? crops,
    int? experience,
  }) {
    return FarmStatsModel(
      acres: acres ?? this.acres,
      scans: scans ?? this.scans,
      crops: crops ?? this.crops,
      experience: experience ?? this.experience,
    );
  }
}
