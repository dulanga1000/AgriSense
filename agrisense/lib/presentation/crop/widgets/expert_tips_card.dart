import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrisense/data/models/expert_tip_model.dart';
import 'package:agrisense/presentation/crop/state/crop_advisory_state.dart';

class ExpertTipsCard extends StatelessWidget {
  const ExpertTipsCard({super.key});

  Color _getTipColor(String type) {
    switch (type) {
      case 'water':
        return Colors.green.shade100;
      case 'soil':
        return Colors.blue.shade100;
      case 'pest':
        return Colors.orange.shade100;
      default:
        return Colors.grey.shade100;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tips = context.watch<CropAdvisoryState>().expertTips;

    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset("assets/images/bulb.png", width: 22, height: 22),
                const SizedBox(width: 8),
                const Text(
                  "Expert Tips for Yala Season",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...tips.map(
              (tip) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _tipItem(tip),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tipItem(ExpertTipModel tip) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _getTipColor(tip.type),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset("assets/images/check.png", width: 20, height: 20),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black, fontSize: 13),
                children: [
                  TextSpan(
                    text: "${tip.title}: ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: tip.description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
