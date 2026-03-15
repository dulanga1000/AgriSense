import 'package:flutter/material.dart';
import 'package:agrisense/data/models/farm_stats_model.dart';

class ProfileFarm extends StatefulWidget {
  const ProfileFarm({super.key});

  @override
  State<ProfileFarm> createState() => _ProfileFarmState();
}

class _ProfileFarmState extends State<ProfileFarm> {

  final FarmStatsModel stats = FarmStatsModel(
    acres: 15,
    scans: 42,
    crops: 8,
    experience: 10,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: const [
              Icon(
                Icons.eco,
                color: Color(0xFF0C8F3E),
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                "Farming Stats",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildFarmStat(
                icon: Icons.landscape,
                number: stats.acres.toString(),
                label: "Acres",
                bgColor: const Color(0xFFDDF1E5),
                iconColor: const Color(0xFF0C8F3E),
              ),
              _buildFarmStat(
                icon: Icons.camera_alt,
                number: stats.scans.toString(),
                label: "Scans",
                bgColor: const Color(0xFFE3EAF6),
                iconColor: Colors.blueGrey,
              ),
              _buildFarmStat(
                icon: Icons.eco,
                number: stats.crops.toString(),
                label: "Crops",
                bgColor: const Color(0xFFF5EFD8),
                iconColor: Colors.green,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFarmStat({
    required IconData icon,
    required String number,
    required String label,
    required Color bgColor,
    required Color iconColor,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),

        const SizedBox(height: 10),

        Text(
          number,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 2),

        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color.fromARGB(255, 40, 36, 36),
          ),
        ),
      ],
    );
  }
}