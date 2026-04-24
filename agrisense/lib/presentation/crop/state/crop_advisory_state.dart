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
    selectedSeason = season;
    notifyListeners();
  }

  void updateDistrict(DistrictModel district) {
    selectedDistrict = district;
    notifyListeners();
  }

  List<CropModel> crops = [];
  List<CalendarEntryModel> calendarEntries = [];
  List<MarketPriceModel> marketPrices = [];
  List<ExpertTipModel> expertTips = [];

  bool isLoading = false;
  String? error;

  Future<void> loadAdvisoryData() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _repository.getRecommendedCrops(),
        _repository.getCalendarEntries(),
        _repository.getMarketPrices(),
        _repository.getExpertTips(),
      ]);

      crops = results[0] as List<CropModel>;
      calendarEntries = results[1] as List<CalendarEntryModel>;
      marketPrices = results[2] as List<MarketPriceModel>;
      expertTips = results[3] as List<ExpertTipModel>;
    } catch (_) {
      error = 'Failed to load crop advisory data';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

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
