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

  FarmStatsModel farmStats = FarmStatsModel.empty();

  Future<void> loadUser() async {
    user = await _repository.loadUser();

    final authUser = FirebaseAuth.instance.currentUser;
    if (authUser != null) {
      // Only fill in name/email if Firestore data is empty or default
      final bool nameIsDefault = user.name.isEmpty || user.name == 'Guest';
      final bool emailIsDefault = user.email.isEmpty || user.email == 'guest@email.com';

      user = user.copyWith(
        id: authUser.uid,
        name: nameIsDefault ? _resolveName(authUser.displayName, authUser.email) : null,
        email: emailIsDefault ? authUser.email : null,
      );

      // Only save back if we actually filled in defaults
      if (nameIsDefault || emailIsDefault) {
        await _repository.saveUser(user);
      }
    }

    // Load farm stats (from Firestore for auth users, empty for guest)
    farmStats = await _repository.loadFarmStats();

    notifyListeners();
  }

  Future<void> syncFromAuthUser(User authUser) async {
    // Load existing data from Firestore first to avoid overwriting
    user = await _repository.loadUser();

    // Only fill in name/email if Firestore data is empty or default
    final bool nameIsDefault = user.name.isEmpty || user.name == 'Guest';
    final bool emailIsDefault = user.email.isEmpty || user.email == 'guest@email.com';

    user = user.copyWith(
      id: authUser.uid,
      name: nameIsDefault ? _resolveName(authUser.displayName, authUser.email) : null,
      email: emailIsDefault ? authUser.email : null,
    );

    // Only save back if we actually filled in defaults
    if (nameIsDefault || emailIsDefault) {
      await _repository.saveUser(user);
    }

    // Load farm stats from Firestore for authenticated user
    farmStats = await _repository.loadFarmStats();

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
    try {
      user = user.copyWith(
        name: name ?? user.name,
        phone: phone ?? user.phone,
        email: email ?? user.email,
        bio: bio ?? user.bio,
        role: role ?? user.role,
      );

      await _repository.saveUser(user);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  Future<void> updateProfileImage(String path) async {
    user = user.copyWith(imagePath: path);

    await _repository.saveUser(user);
    notifyListeners();
  }

  // 🔍 Debug: Check UID and Firestore sync
  Future<void> debugFirebaseSync() async {
    await _repository.debugCheckUID();
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

    // Reset farm stats to zero in memory (NOT saved to Firebase)
    farmStats = FarmStatsModel.empty();

    await _repository.clearUser();
    notifyListeners();
  }

  // ─── Farm Stats Methods ───────────────────────────────────────────

  /// Called after a successful disease scan.
  /// Increments scan count, adds plant name to unique crops set.
  /// Saves to Firestore only for authenticated users.
  Future<void> incrementScanCount(String plantName) async {
    final updatedCrops = Set<String>.from(farmStats.scannedCropNames);

    // Only add valid, non-error plant names
    final trimmed = plantName.trim();
    if (trimmed.isNotEmpty &&
        trimmed != 'Unknown' &&
        trimmed != 'Unsupported') {
      updatedCrops.add(trimmed);
    }

    farmStats = farmStats.copyWith(
      scans: farmStats.scans + 1,
      crops: updatedCrops.length,
      scannedCropNames: updatedCrops,
    );

    notifyListeners();

    // Save to Firestore (only for auth users — repo handles the check)
    await _repository.saveFarmStats(farmStats);
  }

  /// Allows user to update their farm acres count.
  Future<void> updateAcres(int acres) async {
    farmStats = farmStats.copyWith(acres: acres);
    notifyListeners();
    await _repository.saveFarmStats(farmStats);
  }
}
