import 'package:flutter/material.dart';

class ForecastCard extends StatelessWidget {
  const ForecastCard({super.key});

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
            children: const [
              ForecastItem(
                day: "Mon",
                icon: Icons.cloud_outlined,
                temp: "28°",
                rain: "20%",
              ),

              ForecastItem(
                day: "Tue",
                icon: Icons.wb_sunny_outlined,
                temp: "30°",
                rain: "5%",
              ),

              ForecastItem(
                day: "Wed",
                icon: Icons.grain,
                temp: "26°",
                rain: "80%",
              ),

              ForecastItem(
                day: "Thu",
                icon: Icons.cloud_outlined,
                temp: "27°",
                rain: "30%",
              ),

              ForecastItem(
                day: "Fri",
                icon: Icons.wb_sunny_outlined,
                temp: "29°",
                rain: "10%",
              ),
            ],
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
