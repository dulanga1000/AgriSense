import 'package:flutter/material.dart';
import 'package:agrisense/data/models/feature_model.dart';
import 'feature_card.dart';
import 'package:agrisense/presentation/fertilizer/screens/fertilizer_screen.dart';
import 'package:agrisense/presentation/crop/screens/crop_advisory_screen.dart';

class FeatureGrid extends StatelessWidget {
  const FeatureGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FeatureModel> features = [
      FeatureModel(
        name: 'Fertilizer',
        description: 'Get recommendations',
        image: 'assets/images/fertilizer.png',
      ),

      FeatureModel(
        name: 'Crop Advisory',
        description: 'Seasonal guidance',
        image: 'assets/images/icons-crop.png',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),

      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: features.length,

        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),

        itemBuilder: (context, index) {
          return FeatureCard(
            feature: features[index],

            onTap: () {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FertilizerScreen(),
                  ),
                );
              }

              if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CropAdvisoryScreen(),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
