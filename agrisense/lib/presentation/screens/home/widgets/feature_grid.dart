import 'package:flutter/material.dart';
import 'package:agrisense/presentation/screens/fertilizer/fertilizer_screen.dart';
import 'package:agrisense/presentation/screens/crop/screens/crop_advisory_screen.dart';

class FeatureGrid extends StatelessWidget {
  const FeatureGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 0.9, // prevents overflow
      children: [
        /// Fertilizer Card
        _buildFeatureCard(
          context,
          title: "Fertilizer",
          icon: Icons.grass,
          color: Colors.green,
          page: const FertilizerScreen(),
        ),

        /// Crop Advisory Card
        _buildFeatureCard(
          context,
          title: "Crop Advisory",
          icon: Icons.agriculture,
          color: Colors.orange,
          page: const CropAdvisoryScreen(),
        ),
      ],
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required Widget page,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 42, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
