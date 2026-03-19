import 'package:flutter/material.dart';
import 'package:agrisense/presentation/common/widgets/app_back_button.dart';
import 'package:agrisense/presentation/settings/widgets/current_location_card.dart';

class LocationChangeScreen extends StatelessWidget {
  const LocationChangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        leading: const AppBackButton(fallbackIndex: 0),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF9810FA), Color(0xFF8200DB)],
            ),
          ),
        ),
        title: const Text(
          "Change Location",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [const CurrentLocationCard()]),
      ),
    );
  }
}
