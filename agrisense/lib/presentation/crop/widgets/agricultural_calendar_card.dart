import 'package:flutter/material.dart';

class AgriculturalCalendarCard extends StatelessWidget {
  const AgriculturalCalendarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xfff3f4f6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Image(
                image: AssetImage('assets/images/calendar.png'),
                width: 24,
                height: 24,
              ),
              SizedBox(width: 8),
              Text(
                "Agricultural Calendar",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(height: 16),

          _calendarItem(
            image: "assets/images/tractor.png",
            month: "February",
            crops: "Rice (Yala)",
            label: "Land Preparation",
          ),

          const SizedBox(height: 12),

          _calendarItem(
            image: "assets/images/plant.png",
            month: "March-April",
            crops: "Rice, Vegetables, Maize",
            label: "Planting",
          ),

          const SizedBox(height: 12),

          _calendarItem(
            image: "assets/images/basket.png",
            month: "June-July",
            crops: "Vegetables, Cowpea",
            label: "Harvesting",
          ),

          const SizedBox(height: 12),

          _calendarItem(
            image: "assets/images/rice.png",
            month: "July-August",
            crops: "Rice (Yala Season)",
            label: "Harvesting",
          ),
        ],
      ),
    );
  }

  Widget _calendarItem({
    required String image,
    required String month,
    required String crops,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Image.asset(image, width: 32, height: 32),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  month,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  crops,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xffe7f0ff),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
