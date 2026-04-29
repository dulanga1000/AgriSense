import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:agrisense/data/models/user_model.dart';
import 'package:agrisense/data/models/farm_stats_model.dart'; // ✅ Added import

class ProfileRepository {
  // User Keys
  static const _nameKey = 'name';
  static const _emailKey = 'email';
  static const _phoneKey = 'phone';
  static const _bioKey = 'bio';
  static const _imageKey = 'image';
  static const _roleKey = 'role';

  // Stats Keys
  static const _statsAcresKey = 'stats_acres';
  static const _statsScansKey = 'stats_scans';
  static const _statsCropsKey = 'stats_crops';
  static const _statsExpKey = 'stats_experience';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ==========================================
  // USER PROFILE LOGIC (Unchanged)
  // ==========================================

  Future<UserModel> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final currentUser = _auth.currentUser;

    if (currentUser != null) {
      try {
        final doc = await _firestore
            .collection('users')
            .doc(currentUser.uid)
            .get();
        if (doc.exists && doc.data() != null) {
          final firestoreUser = UserModel.fromMap(doc.data()!);
          await _saveLocally(prefs, firestoreUser);
          return firestoreUser;
        }
      } catch (e) {
        // Silent error - fallback to local cache
      }
    }

    return UserModel(
      id: currentUser?.uid ?? '1',
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
    final currentUser = _auth.currentUser;

    await _saveLocally(prefs, user);

    if (currentUser != null) {
      try {
        final userToSave = user.copyWith(id: currentUser.uid);
        await _firestore
            .collection('users')
            .doc(currentUser.uid)
            .set(userToSave.toMap(), SetOptions(merge: true));
      } catch (e) {
        // Silent error - local data saved, cloud sync failed
      }
    }
  }

  Future<void> _saveLocally(SharedPreferences prefs, UserModel user) async {
    await prefs.setString(_nameKey, user.name);
    await prefs.setString(_emailKey, user.email);
    await prefs.setString(_phoneKey, user.phone);
    await prefs.setString(_bioKey, user.bio);
    if (user.imagePath != null) {
      await prefs.setString(_imageKey, user.imagePath!);
    }
    await prefs.setString(_roleKey, user.role);
  }

  // ==========================================
  // ✅ NEW: FARM STATS LOGIC
  // ==========================================

  Future<FarmStatsModel> loadFarmStats() async {
    final prefs = await SharedPreferences.getInstance();
    final currentUser = _auth.currentUser;

    // 1. Try Firebase if logged in
    if (currentUser != null) {
      try {
        final doc = await _firestore
            .collection('users')
            .doc(currentUser.uid)
            .get();
        if (doc.exists &&
            doc.data() != null &&
            doc.data()!.containsKey('stats')) {
          final statsMap = doc.data()!['stats'] as Map<String, dynamic>;
          final stats = FarmStatsModel.fromMap(statsMap);
          await _saveStatsLocally(prefs, stats); // Cache locally
          return stats;
        }
      } catch (e) {
        // Silent error - fallback to local cache
      }
    }

    // 2. Fallback to Local Storage (Guest or Offline)
    return FarmStatsModel(
      acres: prefs.getInt(_statsAcresKey) ?? 0,
      scans: prefs.getInt(_statsScansKey) ?? 0,
      crops: prefs.getInt(_statsCropsKey) ?? 0,
      experience: prefs.getInt(_statsExpKey) ?? 0,
    );
  }

  Future<void> saveFarmStats(FarmStatsModel stats) async {
    final prefs = await SharedPreferences.getInstance();
    final currentUser = _auth.currentUser;

    // 1. Always save locally (works for Guests!)
    await _saveStatsLocally(prefs, stats);

    // 2. Only save to Firebase if logged in
    if (currentUser != null) {
      try {
        await _firestore.collection('users').doc(currentUser.uid).set({
          'stats': stats.toMap(), // Save stats as a nested map
        }, SetOptions(merge: true));
      } catch (e) {
        // Silent error - local data saved, cloud sync failed
      }
    }
  }

  Future<void> _saveStatsLocally(
    SharedPreferences prefs,
    FarmStatsModel stats,
  ) async {
    await prefs.setInt(_statsAcresKey, stats.acres);
    await prefs.setInt(_statsScansKey, stats.scans);
    await prefs.setInt(_statsCropsKey, stats.crops);
    await prefs.setInt(_statsExpKey, stats.experience);
  }

  // ==========================================
  // CLEANUP LOGIC
  // ==========================================

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    // Wipe User Data
    await prefs.remove(_nameKey);
    await prefs.remove(_emailKey);
    await prefs.remove(_phoneKey);
    await prefs.remove(_bioKey);
    await prefs.remove(_imageKey);
    await prefs.remove(_roleKey);

    // ✅ Wipe Stats Data (Prevents Guest data from lingering!)
    await prefs.remove(_statsAcresKey);
    await prefs.remove(_statsScansKey);
    await prefs.remove(_statsCropsKey);
    await prefs.remove(_statsExpKey);
  }
}
