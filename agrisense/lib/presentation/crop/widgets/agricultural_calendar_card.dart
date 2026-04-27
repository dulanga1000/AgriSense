import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrisense/data/models/calendar_entry_model.dart';
import 'package:agrisense/presentation/crop/state/crop_advisory_state.dart';

class AgriculturalCalendarCard extends StatelessWidget {
  const AgriculturalCalendarCard({super.key});

  IconData _iconForCalendarItem(String iconName) {
    final lower = iconName.toLowerCase();
    if (lower.contains('tractor')) {
      return Icons.agriculture;
    }
    if (lower.contains('basket')) {
      return Icons.shopping_basket;
    }
    if (lower.contains('water')) {
      return Icons.water_drop;
    }
    if (lower.contains('bug') || lower.contains('pest')) {
      return Icons.bug_report;
    }
    if (lower.contains('rice')) {
      return Icons.rice_bowl;
    }
    if (lower.contains('maize') || lower.contains('corn')) {
      return Icons.grass;
    }
    if (lower.contains('vegetable')) {
      return Icons.local_florist;
    }
    return Icons.eco;
  }

  @override
  Widget build(BuildContext context) {
    final entries = context.watch<CropAdvisoryState>().calendarEntries;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
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
          ...entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _calendarItem(entry),
            ),
          ),
        ],
      ),
    );
  }

  Widget _calendarItem(CalendarEntryModel entry) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              _iconForCalendarItem(entry.iconName),
              color: Colors.green.shade700,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.month,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  entry.crops,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFE7F0FF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              entry.label,
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
