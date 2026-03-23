import 'package:flutter/material.dart';

class PolicyInfoWidget extends StatelessWidget {
  const PolicyInfoWidget({super.key});

  Widget _buildSection(String title, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 6),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 4, left: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("• "),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 📦 Icon Box
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.storage_outlined, color: Colors.blue),
          ),

          const SizedBox(width: 12),

          // 📄 Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Information We Collect",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                _buildSection("Personal Information:", [
                  "Name and contact details",
                  "Farm location and size",
                  "Profile information",
                  "Login credentials (encrypted)",
                ]),

                _buildSection("Usage Data:", [
                  "Crop detection images",
                  "Disease scanning history",
                  "Weather preferences",
                  "App usage patterns",
                ]),

                _buildSection("Location Data:", [
                  "GPS coordinates for weather data",
                  "Regional farming information",
                  "Climate-specific recommendations",
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
