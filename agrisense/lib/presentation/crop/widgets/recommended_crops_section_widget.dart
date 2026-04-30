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
            "Recommended Crops",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            "${state.selectedSeason.name} - ${state.selectedDistrict.district}",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          if (state.isLoading)
            _buildLoadingIndicator()
          else if (state.error != null)
            _buildErrorMessage(state.error!)
          else
            ...crops.map((crop) => CropItemCardWidget(crop: crop)),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              width: 32,
              height: 32,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Color(0xFF16A34A),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Loading recommendations...",
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorMessage(String error) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Text(
          error,
          style: const TextStyle(fontSize: 13, color: Colors.redAccent),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

