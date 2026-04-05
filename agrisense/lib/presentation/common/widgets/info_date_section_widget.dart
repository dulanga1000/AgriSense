import 'package:flutter/material.dart';

class InfoDateSectionWidget extends StatelessWidget {
  final String label;
  final DateTime date;
  final Color accentColor;

  const InfoDateSectionWidget({
    super.key,
    required this.label,
    required this.date,
    this.accentColor = Colors.blue,
  });

  String formatDate(DateTime date) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return "${months[date.month - 1]} ${date.day.toString().padLeft(2, '0')}, ${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // 🔵 Accent Line
          Container(
            width: 4,
            height: 28,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),

          const SizedBox(width: 10),

          // 📅 Text
          Expanded(
            child: Text(
              "$label: ${formatDate(date)}",
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
