import 'package:flutter/material.dart';
import 'package:agrisense/data/models/farming_tip_model.dart';
import './tip_item.dart';

class FarmingTipsSection extends StatelessWidget {
  const FarmingTipsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FarmingTip> tips = [
      FarmingTip(
        id: 1,
        description: "Good day for rice cultivation - high humidity detected",
        icon: "plant",
      ),
      FarmingTip(
        id: 2,
        description:
            "Light rain expected tomorrow - postpone pesticide application",
        icon: "rain",
      ),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.lightbulb_outline, color: Colors.orange),
              SizedBox(width: 8),
              Text(
                "Today's Farming Tips",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),

          const SizedBox(height: 16),

          ...tips.map((tip) => TipItem(farmingTip: tip)),
        ],
      ),
    );
  }
}
