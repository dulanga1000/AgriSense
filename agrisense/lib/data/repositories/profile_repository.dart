import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:agrisense/data/models/user_model.dart';
import 'package:agrisense/data/models/farm_stats_model.dart';

class ProfileRepository {
  static const _nameKey = 'name';
  static const _emailKey = 'email';
  static const _phoneKey = 'phone';
  static const _bioKey = 'bio';
  static const _imageKey = 'image';
  static const _roleKey = 'role';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 🔍 Debug helper - verify UID matches
  Future<void> debugCheckUID() async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      try {
        final doc = await _firestore
            .collection('users')
            .doc(currentUser.uid)
            .get();
        if (doc.exists) {
          // Debug check passed - document exists
        }
      } catch (e) {
        // Silent error handling
      }
    }
  }

  Future<UserModel> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final currentUser = _auth.currentUser;

    // ✅ NEW: Try fetching fresh data from Firebase first
    if (currentUser != null) {
      try {
        final doc = await _firestore
            .collection('users')
            .doc(currentUser.uid)
            .get();
        if (doc.exists && doc.data() != null) {
          final firestoreUser = UserModel.fromMap(doc.data()!);
          // Update local cache with fresh cloud data
          await _saveLocally(prefs, firestoreUser);
          return firestoreUser;
        }
      } catch (e) {
        // Silently fail and fallback to local cache if offline
      }
    }

    // 🔄 EXISTING: Fallback to local storage (unchanged)
    return UserModel(
      id: currentUser?.uid ?? '1', // Use real UID if available, else '1'
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

    // Save locally for instant UI updates
    await _saveLocally(prefs, user);

    // Sync with Firebase Firestore
    if (currentUser != null) {
      try {
        // Ensure we are saving with the correct Firebase UID
        final userToSave = user.copyWith(id: currentUser.uid);
        final dataToSave = userToSave.toMap();

        await _firestore
            .collection('users')
            .doc(currentUser.uid)
            .set(dataToSave, SetOptions(merge: true))
            .timeout(
              const Duration(seconds: 10),
              onTimeout: () => throw Exception('Firestore write timeout'),
            );
      } catch (e) {
        // Silent error - allow profile updates to proceed with local data
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

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_nameKey);
    await prefs.remove(_emailKey);
    await prefs.remove(_phoneKey);
    await prefs.remove(_bioKey);
    await prefs.remove(_imageKey);
    await prefs.remove(_roleKey);
  }

  // ─── Farm Stats Persistence ───────────────────────────────────────

  /// Load farm stats from Firestore for authenticated users.
  /// Returns empty stats for guest users.
  Future<FarmStatsModel> loadFarmStats() async {
    final currentUser = _auth.currentUser;

    if (currentUser != null) {
      try {
        final doc = await _firestore
            .collection('users')
            .doc(currentUser.uid)
            .collection('stats')
            .doc('farm_stats')
            .get();
        if (doc.exists && doc.data() != null) {
          return FarmStatsModel.fromMap(doc.data()!);
        }
      } catch (e) {
        // Silently fail — return empty stats
      }
    }

    return FarmStatsModel.empty();
  }

  /// Save farm stats to Firestore ONLY for authenticated users.
  /// Guest users skip Firestore write — data stays in memory only.
  Future<void> saveFarmStats(FarmStatsModel stats) async {
    final currentUser = _auth.currentUser;

    // Only persist to Firestore for authenticated users
    if (currentUser != null) {
      try {
        await _firestore
            .collection('users')
            .doc(currentUser.uid)
            .collection('stats')
            .doc('farm_stats')
            .set(stats.toMap(), SetOptions(merge: true))
            .timeout(
              const Duration(seconds: 10),
              onTimeout: () => throw Exception('Firestore write timeout'),
            );
      } catch (e) {
        // Silent error — stats still update in memory
      }
    }
  }
}
