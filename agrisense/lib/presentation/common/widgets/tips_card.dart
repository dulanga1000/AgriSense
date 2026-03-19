import 'package:flutter/material.dart';

class TipsCard extends StatelessWidget {
  final String title;
  final List<String> tips;
  final IconData icon;
  final EdgeInsetsGeometry margin;

  const TipsCard({
    super.key,
    required this.title,
    required this.tips,
    required this.icon,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF1C398E)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF1C398E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          ...tips.map(
            (tip) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.brightness_1,
                    color: Color(0xFF193CB8),
                    size: 8,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      tip,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF193CB8),
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
}
