import 'package:agrisense/presentation/weather/state/weather_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:agrisense/presentation/common/navigation/main_tab_navigator.dart';
import 'package:agrisense/data/models/user_model.dart';
import 'package:agrisense/data/models/weather_model.dart';
import 'package:agrisense/presentation/notification/screens/notification_screen.dart';
import 'package:agrisense/presentation/notification/state/notification_state.dart';

class HomeHeader extends StatelessWidget {
  final UserModel user;
  const HomeHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final unreadCount = context.select<NotificationState, int>(
      (state) => state.notifications.where((n) => n.isUnread).length,
    );
    final weatherState = context.watch<WeatherState>();
    final WeatherModel? weather = weatherState.isLoading
        ? null
        : weatherState.weather;

    return Container(
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
        mainAxisSize: MainAxisSize.min,
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

              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const NotificationScreen(),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.25),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          CupertinoIcons.bell,
                          color: Colors.white,
                        ),
                      ),

                      if (unreadCount > 0)
                        Positioned(
                          top: 2,
                          right: 2,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              unreadCount > 99 ? "99+" : unreadCount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.20),
              borderRadius: BorderRadius.circular(16),
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Today's Weather",
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 6),

                      if (weatherState.isLoading)
                        const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      else
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.white70,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                weather?.city ?? "Location unavailable",
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

                      const SizedBox(height: 4),

                      Row(
                        children: [
                          Text(
                            weather != null
                                ? "${weather.temperature.toStringAsFixed(0)}°C"
                                : "--°C",
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
                        weather != null
                            ? "${weather.condition} • ${weather.humidity}% Humidity"
                            : weatherState.errorMessage != null
                            ? "Failed to load weather"
                            : "Loading...",
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha: 0.25),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    MainTabNavigator.goToTab(context, 2);
                  },
                  child: const Text("View More"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
