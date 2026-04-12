import 'package:flutter/material.dart';
import 'package:agrisense/data/models/farming_tip_model.dart';
import './tip_item.dart';

class FarmingTipsSection extends StatelessWidget {
  final List<FarmingTip> tips;

  const FarmingTipsSection({super.key, required this.tips});

  @override
  Widget build(BuildContext context) {
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
          const Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.orange),
              SizedBox(width: 8),
              Text(
                "Today's Farming Tips",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 16),

          if (tips.isEmpty)
            const Text(
              "No tips available today. Check back later!",
              style: TextStyle(color: Colors.grey),
            )
          else
            Column(
              children: tips.map((tip) => TipItem(farmingTip: tip)).toList(),
            ),
        ],
      ),
    );
  }
}
