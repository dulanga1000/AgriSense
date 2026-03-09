import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WeatherTrendsCard extends StatelessWidget {
  const WeatherTrendsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    final rainfall = [20, 5, 75, 30, 10, 18, 25];
    final temperature = [28, 30, 26, 27, 29, 28, 27];
    final humidity = [65, 60, 80, 70, 60, 55, 62];

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "7-Day Weather Trends",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          /// Temperature & Rainfall
          const Text(
            "Temperature & Rainfall",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 230,
            child: LineChart(
              LineChartData(
                minY: 0,
                maxY: 80,

                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 20,
                ),

                borderData: FlBorderData(show: false),

                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,

                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= days.length) {
                          return const SizedBox();
                        }

                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            days[value.toInt()],
                            style: const TextStyle(fontSize: 12),
                          ),
                        );
                      },
                    ),
                  ),

                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 20,
                      reservedSize: 30,

                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),

                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),

                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),

                lineTouchData: LineTouchData(
                  enabled: true,

                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (spot) => Colors.black,

                    getTooltipItems: (spots) {
                      return spots.map((spot) {
                        int index = spot.x.toInt();

                        return LineTooltipItem(
                          "${days[index]}\n",
                          const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          children: [
                            TextSpan(
                              text: "Temp: ${temperature[index]} °C\n",
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.orange,
                              ),
                            ),

                            TextSpan(
                              text: "Rain: ${rainfall[index]} mm",
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        );
                      }).toList();
                    },
                  ),
                ),

                lineBarsData: [
                  /// Single Temperature Line
                  LineChartBarData(
                    spots: List.generate(
                      temperature.length,
                      (index) => FlSpot(
                        index.toDouble(),
                        temperature[index].toDouble(),
                      ),
                    ),

                    isCurved: true,
                    color: Colors.orange,
                    barWidth: 3,

                    dotData: FlDotData(show: true),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

          /// Humidity Levels
          const Text(
            "Humidity Levels",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 220,
            child: LineChart(
              LineChartData(
                minY: 0,
                maxY: 100,

                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 25,
                ),

                borderData: FlBorderData(show: false),

                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,

                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= days.length) {
                          return const SizedBox();
                        }

                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            days[value.toInt()],
                            style: const TextStyle(fontSize: 12),
                          ),
                        );
                      },
                    ),
                  ),

                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 25,
                      reservedSize: 28,

                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),

                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),

                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),

                lineTouchData: LineTouchData(
                  enabled: true,

                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (spot) => Colors.black,

                    getTooltipItems: (spots) {
                      return spots.map((spot) {
                        int index = spot.x.toInt();

                        return LineTooltipItem(
                          "${days[index]}\nHumidity: ${humidity[index]} %",
                          const TextStyle(fontSize: 11, color: Colors.white),
                        );
                      }).toList();
                    },
                  ),
                ),

                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(
                      humidity.length,
                      (index) =>
                          FlSpot(index.toDouble(), humidity[index].toDouble()),
                    ),

                    isCurved: true,
                    color: const Color(0xFF1DB954),
                    barWidth: 3,
                    dotData: FlDotData(show: true),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.circle, color: Color(0xFF1DB954), size: 10),

              SizedBox(width: 6),

              Text(
                "Humidity (%)",
                style: TextStyle(fontSize: 12, color: Color(0xFF1DB954)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
