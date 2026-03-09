import 'package:flutter/material.dart';

class MarketPriceCard extends StatelessWidget {
  const MarketPriceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9, // reduced width
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF7A00), Color(0xFFFF5A00)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            const Row(
              children: [
                Icon(Icons.trending_up, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  "Current Market Prices",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            const Text(
              "Recent prices at local markets",
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),

            const SizedBox(height: 20),

            /// Crop Items
            _priceItem(
              crop: "Tomato",
              price: "Rs. 150-200/kg",
              demand: "↑ High Demand",
              demandColor: const Color(0xFF9C8F2B),
            ),

            const SizedBox(height: 12),

            _priceItem(
              crop: "Cabbage",
              price: "Rs. 80-120/kg",
              demand: "→ Medium Demand",
              demandColor: const Color(0xFFB39B9B),
            ),

            const SizedBox(height: 12),

            _priceItem(
              crop: "Green Chili",
              price: "Rs. 300-400/kg",
              demand: "↑ Very High Demand",
              demandColor: const Color(0xFF7C8F2B),
            ),

            const SizedBox(height: 18),

            /// Info Box
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.white70, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Prices vary by region and season. Check local markets for accurate rates.",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _priceItem({
    required String crop,
    required String price,
    required String demand,
    required Color demandColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  crop,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: demandColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              demand,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
