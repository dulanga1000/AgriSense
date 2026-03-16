import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrisense/presentation/common/navigation/main_tab_navigator.dart';
import 'package:agrisense/presentation/common/widgets/app_back_button.dart';
import 'package:agrisense/presentation/common/widgets/bottom_nav_bar.dart';
import 'package:agrisense/presentation/crop/state/crop_advisory_state.dart';
import '../widgets/header_section_widget.dart';
import '../widgets/filter_section_widget.dart';
import '../widgets/recommended_crops_section_widget.dart';
import '../widgets/agricultural_calendar_card.dart';
import '../widgets/market_price_card.dart';
import '../widgets/expert_tips_card.dart';

class CropAdvisoryScreen extends StatelessWidget {
  const CropAdvisoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CropAdvisoryState(),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: const Color(0xFF16A34A),
          elevation: 0,
          leading: const AppBackButton(fallbackIndex: 0),
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Crop Advisory",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Smart farming recommendations",
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ],
          ),
        ),
        body: _CropAdvisoryBody(),
        bottomNavigationBar: Builder(
          builder: (context) => BottomNavBarWidget(
            currentIndex: 0,
            highlightSelected: false,
            onTap: (index) => MainTabNavigator.goToTab(context, index),
          ),
        ),
      ),
    );
  }
}

class _CropAdvisoryBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<CropAdvisoryState>();
    final screenWidth = MediaQuery.of(context).size.width;
    final dropdownWidth = (screenWidth - 48) / 2;

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: const [
              HeaderSectionWidget(),
              SizedBox(height: 16),
              FilterSectionWidget(),
              SizedBox(height: 16),
              RecommendedCropsSectionWidget(),
              SizedBox(height: 20),
              AgriculturalCalendarCard(),
              SizedBox(height: 20),
              MarketPriceCard(),
              SizedBox(height: 20),
              ExpertTipsCard(),
              SizedBox(height: 30),
            ],
          ),
        ),
        if (state.isSeasonOpen)
          Positioned(
            top: _getFilterTop(context),
            left: 12,
            width: dropdownWidth,
            child: Material(
              elevation: 12,
              shadowColor: Colors.black38,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(12),
              ),
              child: SeasonDropdownContent(state: state),
            ),
          ),
        if (state.isLocationOpen)
          Positioned(
            top: _getFilterTop(context),
            right: 12,
            width: dropdownWidth,
            child: Material(
              elevation: 12,
              shadowColor: Colors.black38,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(12),
              ),
              child: LocationDropdownContent(state: state),
            ),
          ),
      ],
    );
  }

  double _getFilterTop(BuildContext context) {
    return 130 + 16 + 62;
  }
}
