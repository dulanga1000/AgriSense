import 'package:flutter/material.dart';
import '../widgets/change_location_header.dart'; 

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], 
      body: Column(
        children: const [
          
          ChangeLocationHeader(),
          
          
          Expanded(
            child: SizedBox(), 
          ),
        ],
      ),
    );
  }
}