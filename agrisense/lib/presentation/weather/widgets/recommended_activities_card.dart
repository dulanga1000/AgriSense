import 'package:flutter/material.dart';
import 'package:agrisense/data/models/weather_model.dart';

class RecommendedActivitiesCard extends StatefulWidget {
  const RecommendedActivitiesCard({super.key});

  @override
  State<RecommendedActivitiesCard> createState() =>
      _RecommendedActivitiesCardState();
}

class _RecommendedActivitiesCardState extends State<RecommendedActivitiesCard> {
  final activities = RecommendedActivitiesModel(
    bestActivities: [
      "Planting & transplanting seedlings",
      "Field preparation and plowing",
      "Irrigation system maintenance",
    ],
    avoidActivities: [
      "Postpone fertilizer application (80% rain Wed)",
      "Delay fungicide spraying due to humidity",
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Row(
            children: const [
              Icon(Icons.agriculture, color: Colors.green),
              SizedBox(width: 8),
              Text(
                "Recommended Activities Today",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(height: 14),

          /// Best For Today
          Container(
            padding: const EdgeInsets.all(14),

            decoration: BoxDecoration(
              color: const Color(0xffE8F7EE),
              borderRadius: BorderRadius.circular(12),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.check_circle, color: Color(0xff22C55E)),
                    SizedBox(width: 8),
                    Text(
                      "Best For Today",
                      style: TextStyle(
                        color: Color(0xff166534),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                ...activities.bestActivities.map((activity) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.eco,
                          color: Color(0xff166534),
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            activity,
                            style: const TextStyle(
                              color: Color(0xff166534),
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          const SizedBox(height: 12),

          /// Avoid Today
          Container(
            padding: const EdgeInsets.all(14),

            decoration: BoxDecoration(
              color: const Color(0xffF6EFE7),
              borderRadius: BorderRadius.circular(12),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: Colors.deepOrange),
                    SizedBox(width: 8),
                    Text(
                      "Avoid Today",
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                ...activities.avoidActivities.map((activity) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.umbrella,
                          color: Colors.deepOrange,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            activity,
                            style: const TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
