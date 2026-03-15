import 'package:flutter/material.dart';
import 'package:agrisense/data/models/weather_model.dart';

class ForecastCard extends StatelessWidget {
  const ForecastCard({super.key});

  @override
  Widget build(BuildContext context) {
    final forecastData = [
      ForecastModel(day: "Mon", temp: "28°", rain: "20%", condition: "cloud"),
      ForecastModel(day: "Tue", temp: "30°", rain: "5%", condition: "sunny"),
      ForecastModel(day: "Wed", temp: "26°", rain: "80%", condition: "rain"),
      ForecastModel(day: "Thu", temp: "27°", rain: "30%", condition: "cloud"),
      ForecastModel(day: "Fri", temp: "29°", rain: "10%", condition: "sunny"),
    ];

    IconData getWeatherIcon(String condition) {
      switch (condition) {
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
            children: forecastData.map((data) {
              return ForecastItem(
                day: data.day,
                icon: getWeatherIcon(data.condition),
                temp: data.temp,
                rain: data.rain,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class ForecastItem extends StatelessWidget {
  final String day;
  final IconData icon;
  final String temp;
  final String rain;

  const ForecastItem({
    super.key,
    required this.day,
    required this.icon,
    required this.temp,
    required this.rain,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(day, style: const TextStyle(fontSize: 12, color: Colors.grey)),

        const SizedBox(height: 6),

        Icon(icon, size: 28, color: Colors.blue),

        const SizedBox(height: 6),

        Text(
          temp,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),

        const SizedBox(height: 4),

        Text(rain, style: const TextStyle(color: Colors.blue, fontSize: 12)),
      ],
    );
  }
}
