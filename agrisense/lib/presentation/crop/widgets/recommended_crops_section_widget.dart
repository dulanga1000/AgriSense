import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrisense/presentation/crop/state/crop_advisory_state.dart';
import 'crop_item_card_widget.dart';

class RecommendedCropsSectionWidget extends StatelessWidget {
  const RecommendedCropsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final crops = context.watch<CropAdvisoryState>().crops;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Recommended Crops for Yala Season",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          const Text(
            "Based on your location and current climate",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          ...crops.map((crop) => CropItemCardWidget(crop: crop)),
        ],
      ),
    );
  }
}
