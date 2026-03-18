import 'package:shared_preferences/shared_preferences.dart';
import 'package:agrisense/data/models/user_model.dart';

class ProfileRepository {
  static const _nameKey = 'name';
  static const _emailKey = 'email';
  static const _phoneKey = 'phone';
  static const _bioKey = 'bio';
  static const _imageKey = 'image';
  static const _roleKey = 'role';

  Future<UserModel> loadUser() async {
    final prefs = await SharedPreferences.getInstance();

    return UserModel(
      id: '1',
      name: prefs.getString(_nameKey) ?? "Guest",
      role: prefs.getString(_roleKey) ?? "Farmer",
      location: "Sri Lanka",
      phone: prefs.getString(_phoneKey) ?? "+94 000 000 000",
      email: prefs.getString(_emailKey) ?? "guest@email.com",
      memberSince: "Jan 2024",
      bio: prefs.getString(_bioKey) ?? "",
      imagePath: prefs.getString(_imageKey),
    );
  }

  Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_nameKey, user.name);
    await prefs.setString(_emailKey, user.email);
    await prefs.setString(_phoneKey, user.phone);
    await prefs.setString(_bioKey, user.bio);
    if (user.imagePath != null) {
      await prefs.setString(_imageKey, user.imagePath!);
    }
    await prefs.setString(_roleKey, user.role);
  }
}
