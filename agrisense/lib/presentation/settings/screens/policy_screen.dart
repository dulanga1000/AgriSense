import 'package:flutter/material.dart';
import '../widgets/privacy_header_widget.dart';
import '../widgets/policy_update_widget.dart';
import '../widgets/policy_intro_widget.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      body: Column(
        children: [
          // 🔷 Header
          PrivacyHeaderWidget(onBack: () => Navigator.pop(context)),

          // 📅 Last Updated
          PolicyUpdateWidget(lastUpdated: DateTime.now()),

          // 📄 Scrollable content
          const Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  PolicyIntroWidget(), // ✅ NEW
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
