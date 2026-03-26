import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agrisense/presentation/settings/state/location_state.dart';
import 'package:agrisense/presentation/weather/state/weather_state.dart';

class CurrentLocationCard extends StatelessWidget {
  const CurrentLocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final locationState = context.watch<LocationState>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Current Location',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 6),

          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: Color(0xFF9810FA),
                size: 20,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  locationState.currentLocation,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),

          if (locationState.error != null) ...[
            const SizedBox(height: 8),
            Text(
              locationState.error!,
              style: const TextStyle(fontSize: 12, color: Colors.redAccent),
            ),
          ],

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: locationState.isLoading
                  ? null
                  : () async {
                      final locationStateRef = context.read<LocationState>();
                      final weatherState = context.read<WeatherState>();

                      await locationStateRef.detectMyLocation();

                      if (locationStateRef.error == null) {
                        await weatherState.updateLocation(
                          locationStateRef.currentLocation,
                        );
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9810FA),
                foregroundColor: Colors.white,
                disabledBackgroundColor: const Color(
                  0xFF9810FA,
                ).withValues(alpha: 0.6),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: locationState.isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(
                      Icons.near_me_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
              label: Text(
                locationState.isLoading ? 'Detecting...' : 'Detect My Location',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
