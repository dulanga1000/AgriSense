import 'package:flutter/material.dart';
import '../widgets/language_header.dart'; 

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], 
      body: Column(
        children: const [
          
          LanguageHeader(),
          
          
          Expanded(
            child: SizedBox(), 
          ),
        ],
      ),
    );
  }
}