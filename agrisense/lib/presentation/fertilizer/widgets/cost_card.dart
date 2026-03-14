import 'package:flutter/material.dart';

class CostCard extends StatefulWidget {
  final double estimatedCost;

  const CostCard({super.key, required this.estimatedCost});

  @override
  State<CostCard> createState() => _CostCardState();
}

class _CostCardState extends State<CostCard> {

  late double cost;

  @override
  void initState() {
    super.initState();
    cost = widget.estimatedCost;
  }

  @override
  void didUpdateWidget(covariant CostCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update cost if recommendation changes
    if (oldWidget.estimatedCost != widget.estimatedCost) {
      setState(() {
        cost = widget.estimatedCost;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [

            Image.asset(
              'assets/images/money.png',
              width: 30,
              height: 30,
            ),

            const SizedBox(width: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text(
                  "Estimated Cost",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  "LKR ${cost.toStringAsFixed(2)}",
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