import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrisense/presentation/crop/state/crop_advisory_state.dart';
import 'crop_item_card_widget.dart';

class RecommendedCropsSectionWidget extends StatelessWidget {
  const RecommendedCropsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CropAdvisoryState>();
    final crops = state.crops;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recommended Crops for ${state.selectedSeason.name}", 
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Text("Based on your location and current climate", style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 16),
          if (crops.isEmpty && !state.isLoading)
            const Padding(padding: EdgeInsets.all(20), child: Center(child: Text("No data found for this selection.")))
          else
            ...crops.map((crop) => CropItemCardWidget(crop: crop)),
        ],
      ),
    );
  }
}