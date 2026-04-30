import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CostCard extends StatelessWidget {
  final double estimatedCost;

  const CostCard({super.key, required this.estimatedCost});

  String _formatCost(double cost) {
    final formatter = NumberFormat('#,##0.00', 'en_US');
    return 'LKR ${formatter.format(cost)}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.payments_outlined, size: 30, color: Colors.green),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Estimated Cost",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatCost(estimatedCost),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

