import 'package:flutter/material.dart';
import 'package:agrisense/data/models/user_model.dart';
import 'package:agrisense/data/models/farm_stats_model.dart';
import 'package:agrisense/data/repositories/profile_repository.dart';

class ProfileState extends ChangeNotifier {
  final ProfileRepository _repository = ProfileRepository();

  UserModel user = UserModel(
    id: '1',
    name: "Guest",
    role: "Farmer",
    location: "Sri Lanka",
    phone: "+94 000 000 000",
    email: "guest@email.com",
    memberSince: "Jan 2024",
  );

  FarmStatsModel farmStats = FarmStatsModel(
    acres: 15,
    scans: 42,
    crops: 8,
    experience: 10,
  );

  Future<void> loadUser() async {
    user = await _repository.loadUser();
    notifyListeners();
  }

  Future<void> updateProfile({
    String? name,
    String? phone,
    String? email,
    String? bio,
    String? role,
  }) async {
    user = user.copyWith(
      name: name ?? user.name,
      phone: phone ?? user.phone,
      email: email ?? user.email,
      bio: bio ?? user.bio,
      role: role ?? user.role,
    );

    await _repository.saveUser(user);
    notifyListeners();
  }

  Future<void> updateProfileImage(String path) async {
    user = user.copyWith(imagePath: path);

    await _repository.saveUser(user);
    notifyListeners();
  }
}
