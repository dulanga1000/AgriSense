import 'package:flutter/material.dart';

class PolicyUpdateWidget extends StatelessWidget {
  final DateTime lastUpdated;

  const PolicyUpdateWidget({super.key, required this.lastUpdated});

  String formatDate(DateTime date) {
    return "${_getMonth(date.month)} ${date.day.toString().padLeft(2, '0')}, ${date.year}";
  }

  String _getMonth(int month) {
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
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // 🔵 Left Blue Line
          Container(
            width: 4,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(4),
            ),
          ),

          const SizedBox(width: 10),

          // 📅 Text
          Expanded(
            child: Text(
              "Last Updated: ${formatDate(lastUpdated)}",
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
