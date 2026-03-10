import 'package:flutter/material.dart';
import 'package:agrisense/presentation/weather/widgets/weather_header.dart';
import 'package:agrisense/presentation/weather/widgets/location_selector.dart';
import 'package:agrisense/presentation/weather/widgets/rain_prediction_card.dart';
import 'package:agrisense/presentation/weather/widgets/forecast_card.dart';
import 'package:agrisense/presentation/weather/widgets/weather_trends_card.dart';
import 'package:agrisense/presentation/weather/widgets/weather_alerts_card.dart';
import 'package:agrisense/presentation/weather/widgets/recommended_activities_card.dart';
import 'package:agrisense/presentation/weather/widgets/irrigation_advice_card.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F4F6),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const WeatherHeader(),

            const SizedBox(height: 16),

            const LocationSelector(),

            const SizedBox(height: 16),

            const RainPredictionCard(),

            const SizedBox(height: 16),

            const ForecastCard(),

            const WeatherTrendsCard(),

            const SizedBox(height: 16),

            const WeatherAlertsCard(),

            const SizedBox(height: 16),

            const RecommendedActivitiesCard(),

            const SizedBox(height: 16),

            const IrrigationAdviceCard(),
          ],
        ),
      ),
    );
  }
}
