import 'package:flutter/material.dart';
import 'package:agrisense/presentation/crop/constants/season_constants.dart';
import 'package:agrisense/core/constants/location_constants.dart';
import 'package:agrisense/data/models/season_model.dart';
import 'package:agrisense/data/models/district_model.dart';
import 'package:agrisense/data/models/crop_model.dart';
import 'package:agrisense/data/models/calendar_entry_model.dart';
import 'package:agrisense/data/models/market_price_model.dart';
import 'package:agrisense/data/models/expert_tip_model.dart';
import 'package:agrisense/data/repositories/agri_repository.dart';

class CropAdvisoryState extends ChangeNotifier {
  final AgriRepository _repository = AgriRepository();

  SeasonModel selectedSeason = SeasonConstants.seasons.first;
  DistrictModel selectedDistrict = LocationConstants.districts.first;

  bool isSeasonOpen = false;
  bool isLocationOpen = false;
  bool isLoading = false;

  
  List<CropModel> crops = [];
  List<CalendarEntryModel> calendarEntries = [];
  List<MarketPriceModel> marketPrices = [];
  List<ExpertTipModel> expertTips = [];

  void toggleSeason() => {isSeasonOpen = !isSeasonOpen, if(isSeasonOpen) isLocationOpen = false, notifyListeners()};
  void toggleLocation() => {isLocationOpen = !isLocationOpen, if(isLocationOpen) isSeasonOpen = false, notifyListeners()};

  void updateSeason(SeasonModel season) {
    selectedSeason = season;
    fetchAdvisory();
    notifyListeners();
  }

  void updateDistrict(DistrictModel district) {
    selectedDistrict = district;
    fetchAdvisory();
    notifyListeners();
  }

  Future<void> fetchAdvisory() async {
    isLoading = true;
    notifyListeners();

    try {
      final data = await _repository.getCropAdvisory(selectedSeason.name, selectedDistrict.district);

      
      crops = (data['crops'] as List).map((e) => CropModel.fromJson(e)).toList();
      calendarEntries = (data['calendar'] as List).map((e) => CalendarEntryModel.fromJson(e)).toList();
      marketPrices = (data['market_prices'] as List).map((e) => MarketPriceModel.fromJson(e)).toList();
      expertTips = (data['expert_tips'] as List).map((e) => ExpertTipModel.fromJson(e)).toList();
      
    } catch (e) {
      debugPrint("Advisory Error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}