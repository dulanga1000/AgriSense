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
    this.bio = "",
    this.imagePath,
  }) : avatarLetter = name.isNotEmpty ? name[0].toUpperCase() : '?';

  UserModel copyWith({
    String? name,
    String? phone,
    String? email,
    String? bio,
    String? imagePath,
    String? role,
  }) {
    return UserModel(
      id: id,
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
