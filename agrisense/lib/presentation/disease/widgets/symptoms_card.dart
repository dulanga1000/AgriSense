import 'package:flutter/material.dart';

class SymptomsCard extends StatelessWidget {
  final List<String> symptoms;

  const SymptomsCard({super.key, required this.symptoms});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFF3E0),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.search, color: Colors.orange, size: 20),
              ),
              const SizedBox(width: 10),
              const Text(
                "Symptoms",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...symptoms.map(
            (symptom) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.circle, color: Colors.orange, size: 8),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(symptom, style: const TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
