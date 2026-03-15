import 'package:flutter/material.dart';
import 'package:agrisense/data/models/feature_model.dart';
import 'package:agrisense/core/routes/app_routes.dart';

class FeatureCard extends StatelessWidget {
  final FeatureModel feature;
  final VoidCallback onTap;

  const FeatureCard({super.key, required this.feature, required this.onTap});
  static const Map<String, IconData> _iconMap = {
    AppRoutes.fertilizer: Icons.agriculture,
    AppRoutes.cropAdvisory: Icons.grass,
  };

  @override
  Widget build(BuildContext context) {
    final icon = _iconMap[feature.routeName] ?? Icons.eco;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.25),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.green.shade700),
            const SizedBox(height: 10),
            Text(
              feature.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Text(
                feature.description,
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
