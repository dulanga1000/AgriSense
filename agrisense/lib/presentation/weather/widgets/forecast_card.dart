import 'package:flutter/material.dart';
import 'package:agrisense/data/models/weather_model.dart';

class ForecastCard extends StatelessWidget {
  final List<ForecastModel> forecastList;

  const ForecastCard({super.key, required this.forecastList});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
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
          const Text(
            "5-Day Forecast",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // ✅ ForecastModel directly pass — no decompose
            children: forecastList
                .map((data) => _ForecastItem(forecast: data))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _ForecastItem extends StatelessWidget {
  final ForecastModel forecast;

  const _ForecastItem({required this.forecast});
  IconData get _icon {
    switch (forecast.condition) {
      case "sunny":
        return Icons.wb_sunny_outlined;
      case "rain":
        return Icons.grain;
      case "cloud":
        return Icons.cloud_outlined;
      default:
        return Icons.wb_sunny_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          forecast.day,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 6),
        Icon(_icon, size: 28, color: Colors.blue),
        const SizedBox(height: 6),
        Text(
          forecast.temp,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          forecast.rain,
          style: const TextStyle(color: Colors.blue, fontSize: 12),
        ),
      ],
    );
  }
}
