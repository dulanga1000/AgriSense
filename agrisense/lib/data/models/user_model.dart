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

  UserModel({required this.id, required this.name, required this.role, required this.location, required this.phone, required this.email, required this.memberSince, this.bio = ""})
      : avatarLetter = name.isNotEmpty ? name[0].toUpperCase() : '?';
}
