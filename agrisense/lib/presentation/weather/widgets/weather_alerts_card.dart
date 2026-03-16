import 'package:flutter/material.dart';
import 'package:agrisense/data/models/weather_model.dart';

class WeatherAlertsCard extends StatelessWidget {
  final List<WeatherAlertModel> alerts;

  const WeatherAlertsCard({super.key, required this.alerts});

  Color _getBgColor(String type) {
    switch (type) {
      case "clear":
        return const Color(0xffE8F7EE);
      case "humidity":
        return const Color(0xffEEF2FF);
      case "rain":
        return const Color(0xffFFF3CD);
      default:
        return Colors.grey.shade100;
    }
  }

  Color _getTextColor(String type) {
    switch (type) {
      case "clear":
        return const Color(0xff166534);
      case "humidity":
        return const Color(0xff1E40AF);
      case "rain":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getIcon(String type) {
    switch (type) {
      case "clear":
        return Icons.check_circle;
      case "humidity":
        return Icons.water_drop_outlined;
      case "rain":
        return Icons.grain;
      default:
        return Icons.info_outline;
    }
  }

  Color? _getBorderColor(String type) {
    if (type == "clear") return const Color(0xff22C55E);
    return null;
  }

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
          const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.orange),
              SizedBox(width: 8),
              Text(
                "Weather Alerts",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 14),

          ...alerts.asMap().entries.map((entry) {
            final index = entry.key;
            final alert = entry.value;
            final borderColor = _getBorderColor(alert.type);

            return Padding(
              padding: EdgeInsets.only(
                bottom: index < alerts.length - 1 ? 12 : 0,
              ),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: _getBgColor(alert.type),
                  borderRadius: BorderRadius.circular(12),
                  border: borderColor != null
                      ? Border(left: BorderSide(color: borderColor, width: 4))
                      : null,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      _getIcon(alert.type),
                      color: _getTextColor(alert.type),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            alert.title,
                            style: TextStyle(
                              color: _getTextColor(alert.type),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            alert.message,
                            style: TextStyle(
                              color: _getTextColor(alert.type),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
