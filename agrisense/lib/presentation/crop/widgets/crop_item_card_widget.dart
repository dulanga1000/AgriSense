import 'package:flutter/material.dart';
import 'package:agrisense/data/models/crop_model.dart';

class CropItemCardWidget extends StatelessWidget {
  final CropModel crop;

  const CropItemCardWidget({super.key, required this.crop});

  IconData _iconForCrop(String iconName) {
    final lower = iconName.toLowerCase();
    if (lower.contains('rice') || lower.contains('paddy')) {
      return Icons.rice_bowl;
    }
    if (lower.contains('maize') || lower.contains('corn')) {
      return Icons.grass;
    }
    if (lower.contains('vegetable')) {
      return Icons.local_florist;
    }
    if (lower.contains('tractor')) {
      return Icons.agriculture;
    }
    if (lower.contains('basket')) {
      return Icons.shopping_basket;
    }
    if (lower.contains('water')) {
      return Icons.water_drop;
    }
    if (lower.contains('bug') || lower.contains('pest')) {
      return Icons.bug_report;
    }
    return Icons.eco;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _iconForCrop(crop.iconName),
                  color: Colors.green.shade700,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      crop.cropName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Duration: ${crop.duration}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: crop.tag == "Prime Time"
                      ? Colors.green.shade50
                      : Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  crop.tag,
                  style: TextStyle(
                    fontSize: 12,
                    color: crop.tag == "Prime Time"
                        ? Colors.green
                        : Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _infoBox(
                  label: "Water Need",
                  value: crop.water,
                  color: Colors.blue.shade50,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _infoBox(
                  label: "Profitability",
                  value: crop.profit,
                  color: Colors.green.shade50,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(),
          const Text(
            "Best suited for:",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 2),
          Text(
            crop.suited,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _infoBox({
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
