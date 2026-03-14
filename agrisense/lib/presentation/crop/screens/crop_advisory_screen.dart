import 'package:flutter/material.dart';
import 'package:agrisense/presentation/common/navigation/main_tab_navigator.dart';
import 'package:agrisense/presentation/common/widgets/app_back_button.dart';
import 'package:agrisense/presentation/common/widgets/bottom_nav_bar.dart';
import '../widgets/header_section_widget.dart';
import '../widgets/filter_section_widget.dart';
import '../widgets/recommended_crops_section_widget.dart';
import '../widgets/agricultural_calendar_card.dart';
import '../widgets/market_price_card.dart';
import '../widgets/expert_tips_card.dart';

class CropAdvisoryScreen extends StatelessWidget {
  const CropAdvisoryScreen({super.key});

  void _onNavTap(BuildContext context, int index) {
    MainTabNavigator.goToTab(context, index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

      body: SingleChildScrollView(
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
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: 0,
        onTap: (index) => _onNavTap(context, index),
      ),
    );
  }
}
