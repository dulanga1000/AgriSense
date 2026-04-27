import 'package:flutter/material.dart';
import 'package:agrisense/presentation/crop/constants/season_constants.dart';
import 'package:agrisense/core/constants/location_constants.dart';
import 'package:agrisense/data/repositories/crop_advisory_repository.dart';
import 'package:agrisense/data/models/season_model.dart';
import 'package:agrisense/data/models/district_model.dart';
import 'package:agrisense/data/models/crop_model.dart';
import 'package:agrisense/data/models/calendar_entry_model.dart';
import 'package:agrisense/data/models/market_price_model.dart';
import 'package:agrisense/data/models/expert_tip_model.dart';

class CropAdvisoryState extends ChangeNotifier {
  CropAdvisoryState(this._repository);

  final CropAdvisoryRepository _repository;

  SeasonModel selectedSeason = SeasonConstants.seasons.first;
  DistrictModel selectedDistrict = LocationConstants.districts.first;

  bool isSeasonOpen = false;
  bool isLocationOpen = false;

  void toggleSeason() {
    isSeasonOpen = !isSeasonOpen;
    if (isSeasonOpen) isLocationOpen = false;
    notifyListeners();
  }

  void toggleLocation() {
    isLocationOpen = !isLocationOpen;
    if (isLocationOpen) isSeasonOpen = false;
    notifyListeners();
  }

  void updateSeason(SeasonModel season) {
    if (selectedSeason == season) return; // Ignore if it's the same season
    selectedSeason = season;
    isSeasonOpen = false; // Close the dropdown
    notifyListeners();
    loadAdvisoryData(); // ✅ Automatically fetch new AI data for the new season
  }

  void updateDistrict(DistrictModel district) {
    if (selectedDistrict == district) {
      return; // Ignore if it's the same district
    }
    selectedDistrict = district;
    isLocationOpen = false; // Close the dropdown
    notifyListeners();
    loadAdvisoryData(); // ✅ Automatically fetch new AI data for the new location
  }

  List<CropModel> crops = [];
  List<CalendarEntryModel> calendarEntries = [];
  List<MarketPriceModel> marketPrices = [];
  List<ExpertTipModel> expertTips = [];

  bool isLoading = false;
  String? error;
  int _loadRequestId = 0;

  Future<void> loadAdvisoryData() async {
    final requestId = ++_loadRequestId;
    final locationName = selectedDistrict.district;
    final seasonName = selectedSeason.name;

    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _repository.getRecommendedCrops(locationName, seasonName),
        _repository.getCalendarEntries(locationName, seasonName),
        _repository.getMarketPrices(locationName, seasonName),
        _repository.getExpertTips(locationName, seasonName),
      ]);

      // Ignore stale results if user changed season/location while this request was running.
      if (requestId != _loadRequestId ||
          locationName != selectedDistrict.district ||
          seasonName != selectedSeason.name) {
        return;
      }

      crops = results[0] as List<CropModel>;
      calendarEntries = results[1] as List<CalendarEntryModel>;
      marketPrices = results[2] as List<MarketPriceModel>;
      expertTips = results[3] as List<ExpertTipModel>;
    } catch (e) {
      if (requestId != _loadRequestId) {
        return;
      }

      error =
          'Failed to load crop advisory data. Please check your connection.';
      debugPrint(
        "Crop Advisory Error: $e",
      ); // Helpful for debugging if Gemini fails
    } finally {
      if (requestId == _loadRequestId) {
        isLoading = false;
        notifyListeners();
      }
    }
  }

  // --- Manual Setters ---
  void setCrops(List<CropModel> data) {
    crops = data;
    notifyListeners();
  }

  void setCalendarEntries(List<CalendarEntryModel> data) {
    calendarEntries = data;
    notifyListeners();
  }

  void setMarketPrices(List<MarketPriceModel> data) {
    marketPrices = data;
    notifyListeners();
  }

  void setExpertTips(List<ExpertTipModel> data) {
    expertTips = data;
    notifyListeners();
  }
}
