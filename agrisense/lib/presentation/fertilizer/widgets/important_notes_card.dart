import 'package:flutter/material.dart';
import 'package:agrisense/presentation/fertilizer/constants/fertilizer_constants.dart';

class ImportantNotesCard extends StatelessWidget {
  const ImportantNotesCard({super.key});

  Widget _note(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text("• $text"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellow[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.warning_amber_rounded, color: Colors.orange),
                const SizedBox(width: 8),
                const Text(
                  "Important Notes",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...FertilizerConstants.importantNotes.map((note) => _note(note)),
          ],
        ),
      ),
    );
  }
}
