import 'package:flutter/material.dart';
import 'package:agrisense/data/models/user_model.dart';
import 'package:agrisense/data/models/farm_stats_model.dart';

class ProfileState extends ChangeNotifier {
  UserModel user = UserModel(
    id: '1',
    name: "Guest",
    role: "Farmer",
    location: "Western Province, Sri Lanka",
    phone: "+91 98765 43210",
    email: "guest@email.com",
    memberSince: "Jan 2024",
    bio: "Experienced farmer specializing in rice and wheat cultivation",
  );

  FarmStatsModel farmStats = FarmStatsModel(
    acres: 15,
    scans: 42,
    crops: 8,
    experience: 10,
  );

  void updateUser(UserModel updatedUser) {
    user = updatedUser;
    notifyListeners();
  }

  void updateFarmStats(FarmStatsModel updatedStats) {
    farmStats = updatedStats;
    notifyListeners();
  }
}
