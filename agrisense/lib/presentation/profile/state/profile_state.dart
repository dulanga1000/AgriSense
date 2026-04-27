import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:agrisense/data/models/user_model.dart';
import 'package:agrisense/data/models/farm_stats_model.dart';
import 'package:agrisense/data/repositories/profile_repository.dart';

class ProfileState extends ChangeNotifier {
  final ProfileRepository _repository;

  ProfileState(this._repository);

  UserModel user = UserModel(
    id: '1',
    name: "Guest",
    role: "Farmer",
    location: "Sri Lanka",
    phone: "+94 000 000 000",
    email: "guest@email.com",
    memberSince: "Jan 2024",
  );

  // Started at 0 instead of hardcoded numbers
  FarmStatsModel farmStats = FarmStatsModel(
    acres: 0,
    scans: 0,
    crops: 0,
    experience: 0,
  );

  Future<void> loadUser() async {
    user = await _repository.loadUser();
    farmStats = await _repository.loadFarmStats(); // ✅ Load the real stats!

    final authUser = FirebaseAuth.instance.currentUser;
    if (authUser != null) {
      final resolvedName = _resolveName(authUser.displayName, authUser.email);
      final resolvedEmail = authUser.email ?? user.email;

      user = user.copyWith(
        id: authUser.uid,
        name: resolvedName,
        email: resolvedEmail,
      );
      await _repository.saveUser(user);
    }

    notifyListeners();
  }

  // ✅ NEW: Call this every time a scan completes!
  Future<void> incrementScan() async {
    farmStats = farmStats.copyWith(scans: farmStats.scans + 1);
    await _repository.saveFarmStats(
      farmStats,
    ); // Saves locally and pushes to Firebase
    notifyListeners();
  }

  Future<void> syncFromAuthUser(User authUser) async {
    final resolvedName = _resolveName(authUser.displayName, authUser.email);
    final resolvedEmail = authUser.email ?? user.email;

    user = user.copyWith(
      id: authUser.uid,
      name: resolvedName,
      email: resolvedEmail,
    );

    await _repository.saveUser(user);
    notifyListeners();
  }

  String _resolveName(String? displayName, String? email) {
    final trimmedName = (displayName ?? '').trim();
    if (trimmedName.isNotEmpty) return trimmedName;

    final rawEmail = (email ?? '').trim();
    if (rawEmail.contains('@')) {
      final local = rawEmail.split('@').first.trim();
      if (local.isNotEmpty) return local;
    }

    return user.name;
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

  Future<void> resetToGuest() async {
    user = UserModel(
      id: '1',
      name: 'Guest',
      role: 'Farmer',
      location: 'Sri Lanka',
      phone: '+94 000 000 000',
      email: 'guest@email.com',
      memberSince: 'Jan 2024',
    );

    // ✅ Reset stats visually
    farmStats = FarmStatsModel(acres: 0, scans: 0, crops: 0, experience: 0);

    await _repository.clearUser(); // Wipes local data
    notifyListeners();
  }
}
