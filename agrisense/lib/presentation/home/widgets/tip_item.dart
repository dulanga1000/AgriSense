import 'package:flutter/material.dart';
import 'package:agrisense/data/models/farming_tip_model.dart';

class TipItem extends StatelessWidget {
  final FarmingTip farmingTip;

  const TipItem({super.key, required this.farmingTip});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _getIconColor().withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(_getIcon(), color: _getIconColor(), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              farmingTip.description,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIcon() {
    switch (farmingTip.icon) {
      case 'plant':
        return Icons.eco;
      case 'rain':
        return Icons.water_drop;
      case 'sun':
        return Icons.wb_sunny;
      case 'warning':
        return Icons.warning_amber;
      default:
        return Icons.lightbulb_outline;
    }
  }

  Color _getIconColor() {
    switch (farmingTip.icon) {
      case 'plant':
        return Colors.green;
      case 'rain':
        return Colors.blue;
      case 'sun':
        return Colors.orange;
      case 'warning':
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }
}
