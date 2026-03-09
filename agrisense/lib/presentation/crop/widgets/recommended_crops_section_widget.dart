import 'package:flutter/material.dart';
import 'crop_item_card_widget.dart';

class RecommendedCropsSectionWidget extends StatelessWidget {
  const RecommendedCropsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recommended Crops for Yala Season",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),

          CropItemCardWidget(
            cropName: "Rice (Paddy)",
            duration: "3-4 months",
            water: "High",
            profit: "High",
            tag: "Prime Time",
            image: "assets/images/rice.png",
          ),

          CropItemCardWidget(
            cropName: "Vegetables",
            duration: "2-3 months",
            water: "Medium",
            profit: "Very High",
            tag: "Prime Time",
            image: "assets/images/vegetables.png",
          ),

          CropItemCardWidget(
            cropName: "Maize (Corn)",
            duration: "3 months",
            water: "Medium",
            profit: "Medium",
            tag: "Good Time",
            image: "assets/images/maize.png",
          ),

          CropItemCardWidget(
            cropName: "Cowpea (Mē)",
            duration: "2-3 months",
            water: "Low",
            profit: "Medium",
            tag: "Good Time",
            image: "assets/images/cowpea.png",
          ),
        ],
      ),
    );
  }
}