import 'package:flutter/material.dart';

class ImportantNotesCard extends StatelessWidget {
  const ImportantNotesCard({super.key});

  Widget note(String text) {
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
                Image.asset("assets/images/warning.png", height: 20),
                const SizedBox(width: 8),
                const Text(
                  "Important Notes",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),

            const SizedBox(height: 10),

            note("Always conduct soil testing for accurate NPK requirements"),
            note("Avoid fertilizer application during heavy rain"),
            note("Store fertilizers in a cool, dry place"),
            note("Use protective equipment during application"),
            note("Maintain proper records of fertilizer usage"),

          ],
        ),
      ),
    );
  }
}