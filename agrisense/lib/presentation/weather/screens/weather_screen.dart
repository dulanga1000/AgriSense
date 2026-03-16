import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrisense/presentation/weather/state/weather_state.dart';
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
    return ChangeNotifierProvider(
      create: (_) => WeatherState()..loadWeatherData(),
      child: Scaffold(
        backgroundColor: const Color(0xffF3F4F6),
        body: Consumer<WeatherState>(
          builder: (context, state, _) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  WeatherHeader(weather: state.weather),
                  const SizedBox(height: 16),

                  const LocationSelector(),
                  const SizedBox(height: 16),

                  if (state.rainPrediction != null)
                    RainPredictionCard(rainData: state.rainPrediction!),
                  const SizedBox(height: 16),

                  ForecastCard(forecastList: state.forecast),

                  WeatherTrendsCard(trends: state.trends),
                  const SizedBox(height: 16),

                  WeatherAlertsCard(alerts: state.alerts),
                  const SizedBox(height: 16),

                  if (state.activities != null)
                    RecommendedActivitiesCard(activities: state.activities!),
                  const SizedBox(height: 16),

                  if (state.irrigationAdvice != null)
                    IrrigationAdviceCard(advice: state.irrigationAdvice!),

                  const SizedBox(height: 30),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
