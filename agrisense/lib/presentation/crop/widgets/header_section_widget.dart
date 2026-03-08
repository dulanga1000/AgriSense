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
          const Icon(Icons.location_on, color: Colors.white),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Western Province, Sri Lanka",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 6),
                Text(
                  "Yala Season",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "March-April - Main planting period",
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                )
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