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
      create: (_) => CropAdvisoryState()..fetchAdvisory(),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: const Color(0xFF16A34A),
          elevation: 0,
          leading: const AppBackButton(fallbackIndex: 0),
          title: const Text("Crop Advisory", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        body: const _CropAdvisoryBody(),
        bottomNavigationBar: Builder(
          builder: (context) => BottomNavBarWidget(
            currentIndex: 0,
            onTap: (index) => MainTabNavigator.goToTab(context, index),
          ),
        ),
      ),
    );
  }
}

class _CropAdvisoryBody extends StatelessWidget {
  const _CropAdvisoryBody();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CropAdvisoryState>();
    final dropdownWidth = (MediaQuery.of(context).size.width - 48) / 2;

    return Stack(
      children: [
        const SingleChildScrollView(
          child: Column(
            children: [
              HeaderSectionWidget(),
              SizedBox(height: 16),
              FilterSectionWidget(),
              SizedBox(height: 16),
              RecommendedCropsSectionWidget(), 
              AgriculturalCalendarCard(),
              SizedBox(height: 20),
              MarketPriceCard(),
              SizedBox(height: 20),
              ExpertTipsCard(),
              SizedBox(height: 30),
            ],
          ),
        ),

        
        if (state.isSeasonOpen) Positioned(top: 146, left: 12, width: dropdownWidth, child: Material(elevation: 8, child: SeasonDropdownContent(state: state))),
        if (state.isLocationOpen) Positioned(top: 146, right: 12, width: dropdownWidth, child: Material(elevation: 8, child: LocationDropdownContent(state: state))),

        
        if (state.isLoading)
          Container(
            color: Colors.black.withValues(alpha: 0.3),
            child: const Center(child: CircularProgressIndicator(color: Colors.white)),
          ),
      ],
    );
  }
}