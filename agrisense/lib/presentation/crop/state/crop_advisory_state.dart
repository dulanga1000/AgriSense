import 'package:flutter/material.dart';
import 'package:agrisense/core/constants/season_constants.dart';
import 'package:agrisense/core/constants/location_constants.dart';
import 'package:agrisense/data/models/season_model.dart';
import 'package:agrisense/data/models/district_model.dart';
import 'package:agrisense/data/models/crop_model.dart';
import 'package:agrisense/data/models/calendar_entry_model.dart';
import 'package:agrisense/data/models/market_price_model.dart';
import 'package:agrisense/data/models/expert_tip_model.dart';

class CropAdvisoryState extends ChangeNotifier {
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

  List<CropModel> crops = [
    const CropModel(
      cropName: "Rice (Paddy)",
      duration: "3-4 months",
      water: "High",
      profit: "High",
      tag: "Prime Time",
      imagePath: "assets/images/rice.png",
      suited: "Western, Central, North Central Province",
    ),
    const CropModel(
      cropName: "Vegetables",
      duration: "2-3 months",
      water: "Medium",
      profit: "Very High",
      tag: "Prime Time",
      imagePath: "assets/images/vegetables.png",
      suited: "Uva, Central, Sabaragamuwa Province",
    ),
    const CropModel(
      cropName: "Maize (Corn)",
      duration: "3 months",
      water: "Medium",
      profit: "Medium",
      tag: "Good Time",
      imagePath: "assets/images/maize.png",
      suited: "North Central, Eastern, Northern Province",
    ),
    const CropModel(
      cropName: "Cowpea (Mē)",
      duration: "2-3 months",
      water: "Low",
      profit: "Medium",
      tag: "Good Time",
      imagePath: "assets/images/cowpea.png",
      suited: "Dry Zone Areas",
    ),
  ];

  List<CalendarEntryModel> calendarEntries = [
    const CalendarEntryModel(
      month: "February",
      crops: "Rice (Yala)",
      label: "Land Preparation",
      imagePath: "assets/images/tractor.png",
    ),
    const CalendarEntryModel(
      month: "March-April",
      crops: "Rice, Vegetables, Maize",
      label: "Planting",
      imagePath: "assets/images/plant.png",
    ),
    const CalendarEntryModel(
      month: "June-July",
      crops: "Vegetables, Cowpea",
      label: "Harvesting",
      imagePath: "assets/images/basket.png",
    ),
    const CalendarEntryModel(
      month: "July-August",
      crops: "Rice (Yala Season)",
      label: "Harvesting",
      imagePath: "assets/images/rice.png",
    ),
  ];

  List<MarketPriceModel> marketPrices = [
    const MarketPriceModel(
      crop: "Tomato",
      price: "Rs. 150-200/kg",
      demand: "↑ High Demand",
      demandType: "high",
    ),
    const MarketPriceModel(
      crop: "Cabbage",
      price: "Rs. 80-120/kg",
      demand: "→ Medium Demand",
      demandType: "medium",
    ),
    const MarketPriceModel(
      crop: "Green Chili",
      price: "Rs. 300-400/kg",
      demand: "↑ Very High Demand",
      demandType: "very_high",
    ),
  ];

  List<ExpertTipModel> expertTips = [
    const ExpertTipModel(
      title: "Water Management",
      description:
          "Monitor rainfall patterns and adjust irrigation schedules accordingly",
      type: "water",
    ),
    const ExpertTipModel(
      title: "Soil Preparation",
      description: "Test soil pH and add organic matter before planting",
      type: "soil",
    ),
    const ExpertTipModel(
      title: "Pest Control",
      description:
          "Regular monitoring helps prevent major outbreaks during this season",
      type: "pest",
    ),
  ];

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
