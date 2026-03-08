import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: const Color(0xFF16A34A),
        elevation: 0,
        leading: const Icon(Icons.arrow_back),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Crop Advisory"),
            Text(
              "Smart farming recommendations",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header section
            const HeaderSectionWidget(),

            const SizedBox(height: 16),

            /// Season & location filter
            const FilterSectionWidget(),

            const SizedBox(height: 16),

            /// Recommended crops list
            const RecommendedCropsSectionWidget(),

            const SizedBox(height: 20),

            /// Agricultural calendar
            const AgriculturalCalendarCard(),

            const SizedBox(height: 20),

            /// Market prices
            const MarketPriceCard(),

            const SizedBox(height: 20),

            /// Expert tips
            const ExpertTipsCard(),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}