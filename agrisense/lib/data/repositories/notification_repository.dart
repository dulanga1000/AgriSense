import 'package:agrisense/data/models/notification_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  NotificationModel _fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();

    final time = _parseDateTime(data['time']) ?? DateTime.now();

    return NotificationModel(
      id: (data['id'] as String?) ?? doc.id,
      title: (data['title'] as String?) ?? '',
      description: (data['description'] as String?) ?? '',
      time: time,
      type: (data['type'] as String?) ?? 'notification',
      isUnread: (data['isUnread'] as bool?) ?? false,
    );
  }

  DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.tryParse(value);
    if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
    return null;
  }

  Future<List<NotificationModel>> fetchNotifications({
    bool forceRefresh = false,
  }) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return <NotificationModel>[];

    // `forceRefresh` kept for interface compatibility: Firestore reads will
    // always re-query when this method is called.
    final collection = _firestore
        .collection('users')
        .doc(uid)
        .collection('notifications');

    final snap = await collection.orderBy('time', descending: true).get();
    return snap.docs.map((d) => _fromDoc(d)).toList();
  }

  Future<bool> markAsRead(String notificationId) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return false;

    final docRef = _firestore
        .collection('users')
        .doc(uid)
        .collection('notifications')
        .doc(notificationId);

    final doc = await docRef.get();
    if (!doc.exists) return false;

    await docRef.update({'isUnread': false});
    return true;
  }

  Future<int> markAllAsRead() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return 0;

    final collection = _firestore
        .collection('users')
        .doc(uid)
        .collection('notifications');

    final unreadSnap =
        await collection.where('isUnread', isEqualTo: true).get();
    if (unreadSnap.docs.isEmpty) return 0;

    final batch = _firestore.batch();
    var updatedCount = 0;

    for (final doc in unreadSnap.docs) {
      batch.update(doc.reference, {'isUnread': false});
      updatedCount++;
    }

    await batch.commit();
    return updatedCount;
  }

  void reset() {
    // No-op: notifications are loaded from Firestore.
  }
}
