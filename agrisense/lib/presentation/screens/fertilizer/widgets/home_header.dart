import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:agrisense/data/models/user_model.dart';
import 'package:agrisense/data/models/weather_model.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  UserModel user = UserModel(id: '1', name: 'Guest');

  WeatherModel weather = WeatherModel(
    city: 'Kandy, Sri Lanka',
    temperature: 25.0,
    humidity: 60,
    condition: 'Sunny',
  );

  @override
  void initState() {
    super.initState();
    loadWeather();
  }

  void loadWeather() {
    setState(() {
      weather = WeatherModel(
        city: 'Kandy, Sri Lanka',
        temperature: 25.0,
        humidity: 60,
        condition: 'Sunny',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.40,
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),

      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF4CAF50), Color(0xFF0D520F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome back,",
                    style: TextStyle(color: Colors.white70),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(CupertinoIcons.bell, color: Colors.white),
                  ),

                  Positioned(
                    top: 2,
                    right: 2,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        '3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(16),

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.20),
              borderRadius: BorderRadius.circular(16),
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Today's Weather",
                      style: TextStyle(color: Colors.white70),
                    ),

                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.white70,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          weather.city,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    Row(
                      children: [
                        Text(
                          "${weather.temperature.toStringAsFixed(0)}°C",
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(width: 10),

                        const Icon(
                          CupertinoIcons.cloud_sun,
                          color: Colors.white,
                          size: 28,
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "${weather.condition} • ${weather.humidity}% Humidity",
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.25),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/fertilizer_screen');
                  },

                  child: const Text("View Details"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
