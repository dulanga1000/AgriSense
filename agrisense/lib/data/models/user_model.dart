class UserModel {
  final String id;
  final String name;
  final String role;
  final String location;
  final String phone;
  final String email;
  final String memberSince;
  final String avatarLetter;
  final String bio;
  final String? imagePath;

  UserModel({
    required this.id,
    required this.name,
    required this.role,
    required this.location,
    required this.phone,
    required this.email,
    required this.memberSince,
    this.bio = '',
    this.imagePath,
  }) : avatarLetter = name.isNotEmpty ? name[0].toUpperCase() : '?';

  factory UserModel.empty() {
    return UserModel(
      id: '',
      name: '',
      email: '',
      role: '',
      location: '',
      phone: '',
      bio: '',
      memberSince: '',
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? 'Farmer',
      location: map['location'] ?? '',
      phone: map['phone'] ?? '',
      bio: map['bio'] ?? '',
      memberSince: map['memberSince'] ?? '',
      imagePath: map['imagePath'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'location': location,
      'phone': phone,
      'bio': bio,
      'memberSince': memberSince,
      'imagePath': imagePath,
    };
  }

  bool get isEmpty => id.isEmpty;
  bool get isNotEmpty => id.isNotEmpty;

  static String currentDate() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? bio,
    String? imagePath,
    String? role,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      location: location,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      memberSince: memberSince,
      bio: bio ?? this.bio,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
