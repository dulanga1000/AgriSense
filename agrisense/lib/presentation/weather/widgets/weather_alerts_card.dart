import 'package:flutter/material.dart';

class WeatherAlertsCard extends StatelessWidget {
  const WeatherAlertsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Row(
            children: const [
              Icon(Icons.warning_amber_rounded, color: Colors.orange),

              SizedBox(width: 8),

              Text(
                "Weather Alerts",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(height: 14),

          /// All Clear Box
          Container(
            padding: const EdgeInsets.all(14),

            decoration: BoxDecoration(
              color: const Color(0xffE8F7EE),
              borderRadius: BorderRadius.circular(12),

              border: const Border(
                left: BorderSide(color: Color(0xff22C55E), width: 4),
              ),
            ),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const Icon(Icons.check_circle, color: Color(0xff22C55E)),

                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: const [
                      Text(
                        "All Clear",
                        style: TextStyle(
                          color: Color(0xff166534),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 4),

                      Text(
                        "No weather warnings for Western Province today. Safe for all farming activities.",
                        style: TextStyle(
                          color: Color(0xff166534),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          /// Humidity Notice Box
          Container(
            padding: const EdgeInsets.all(14),

            decoration: BoxDecoration(
              color: const Color(0xffEEF2FF),
              borderRadius: BorderRadius.circular(12),
            ),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const Icon(Icons.water_drop_outlined, color: Color(0xff2563EB)),

                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: const [
                      Text(
                        "Humidity Notice",
                        style: TextStyle(
                          color: Color(0xff1E40AF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 4),

                      Text(
                        "High humidity (65%) - Monitor crops for fungal diseases. Ensure proper ventilation.",
                        style: TextStyle(
                          color: Color(0xff1E40AF),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
