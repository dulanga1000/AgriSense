import 'package:flutter/material.dart';
import 'package:agrisense/core/constants/feature_constants.dart';
import 'feature_card.dart';

class FeatureGrid extends StatelessWidget {
  const FeatureGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final features = FeatureConstants.features;

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
            onTap: () =>
                Navigator.pushNamed(context, features[index].routeName),
          );
        },
      ),
    );
  }
}
