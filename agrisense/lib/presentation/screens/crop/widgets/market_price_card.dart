import 'package:flutter/material.dart';

class MarketPriceCard extends StatelessWidget {
  const MarketPriceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Market Prices",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            "Stay updated with the current prices of your crops in local markets.",
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}