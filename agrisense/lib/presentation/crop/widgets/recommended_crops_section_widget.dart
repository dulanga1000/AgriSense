import 'package:flutter/material.dart';
import 'crop_item_card_widget.dart';

class RecommendedCropsSectionWidget extends StatelessWidget {
  const RecommendedCropsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "Recommended Crops for Yala Season",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 4),

          const Text(
            "Based on your location and current climate",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 16),

          CropItemCardWidget(
            cropName: "Rice (Paddy)",
            duration: "3-4 months",
            water: "High",
            profit: "High",
            tag: "Prime Time",
            image: "assets/images/rice.png",
            suited: "Western, Central, North Central Province",
          ),

          CropItemCardWidget(
            cropName: "Vegetables",
            duration: "2-3 months",
            water: "Medium",
            profit: "Very High",
            tag: "Prime Time",
            image: "assets/images/vegetables.png",
            suited: "Uva, Central, Sabaragamuwa Province",
          ),

          CropItemCardWidget(
            cropName: "Maize (Corn)",
            duration: "3 months",
            water: "Medium",
            profit: "Medium",
            tag: "Good Time",
            image: "assets/images/maize.png",
            suited: "North Central, Eastern, Northern Province",
          ),

          CropItemCardWidget(
            cropName: "Cowpea (Mē)",
            duration: "2-3 months",
            water: "Low",
            profit: "Medium",
            tag: "Good Time",
            image: "assets/images/cowpea.png",
            suited: "Dry Zone Areas",
          ),
        ],
      ),
    );
  }
}