import 'package:flutter/material.dart';

class HeaderSectionWidget extends StatelessWidget {
  const HeaderSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF16A34A),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 5),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// LOCATION
                Row(
                  children: [
                    Image.asset(
                      "assets/images/location_icon.png",
                      height: 18,
                      width: 18,
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      "Western Province, Sri Lanka",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                const Text(
                  "Selected Season",
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),

                const SizedBox(height: 4),

                /// SEASON WITH CALENDAR ICON
                Row(
                  children: [
                    Image.asset(
                      "assets/images/calendar1_icon.png",
                      height: 25,
                      width: 25,
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      "Yala Season",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                const Text(
                  "March-April - Main planting period",
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),

          Image.asset(
            "assets/images/crop_icon.png",
            height: 60,
          )
        ],
      ),
    );
  }
}