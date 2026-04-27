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

  FarmStatsModel farmStats = FarmStatsModel(
    acres: 15,
    scans: 42,
    crops: 8,
    experience: 10,
  );

  Future<void> loadUser() async {
    user = await _repository.loadUser();

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
    print('\n🔍 ════════ DEBUGGING FIRESTORE SYNC ════════');
    await _repository.debugCheckUID();
    print('🔍 ══════════════════════════════════════════\n');
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

    await _repository.clearUser();
    notifyListeners();
  }
}
