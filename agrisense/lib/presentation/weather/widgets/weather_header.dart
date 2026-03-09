import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:agrisense/core/routes/app_routes.dart';
import 'package:agrisense/data/models/weather_model.dart';
import 'package:agrisense/presentation/home/screens/home_screen.dart';

class WeatherHeader extends StatefulWidget {
  const WeatherHeader({super.key});

  @override
  State<WeatherHeader> createState() => _WeatherHeaderState();
}

class _WeatherHeaderState extends State<WeatherHeader> {
  WeatherModel weather = WeatherModel(
    city: "Western Province, Sri Lanka",
    temperature: 28,
    humidity: 65,
    condition: "Cloudy",
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 45, 20, 25),

      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff3B82F6), Color(0xff2563EB)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 18,
                ),

                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.main);
                },
              ),

              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Weather & Crops",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    "Real-time farming insights",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(18),

            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(18),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Colors.white70,
                      size: 14,
                    ),

                    const SizedBox(width: 5),

                    Expanded(
                      child: Text(
                        weather.city,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                const Text(
                  "Current Weather",
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${weather.temperature.toStringAsFixed(0)}°C",
                      style: const TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const Icon(
                      CupertinoIcons.cloud,
                      color: Colors.white,
                      size: 50,
                    ),
                  ],
                ),

                const Divider(color: Colors.white30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _weatherInfo(Icons.water_drop, "Humidity", "65%"),
                    _weatherInfo(Icons.air, "Wind Speed", "12 km/h"),
                    _weatherInfo(Icons.remove_red_eye, "Visibility", "8 km"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _weatherInfo(IconData icon, String title, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 18),

        const SizedBox(height: 4),

        Text(
          title,
          style: const TextStyle(color: Colors.white70, fontSize: 11),
        ),

        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
