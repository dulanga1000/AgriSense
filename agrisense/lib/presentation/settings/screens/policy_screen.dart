import 'package:flutter/material.dart';
import 'package:agrisense/presentation/common/widgets/app_back_button.dart';
import '../widgets/policy_update_widget.dart';
import '../widgets/policy_intro_widget.dart';
import '../widgets/policy_info_widget.dart';
import '../widgets/policy_usage_widget.dart';
import '../widgets/policy_security_widget.dart';
import '../widgets/policy_rights_widget.dart';
import '../widgets/policy_thirdparty_widget.dart';
import '../widgets/policy_retention_widget.dart';
import '../widgets/policy_children_widget.dart';
import '../widgets/policy_changes_widget.dart';
import '../widgets/policy_contact_widget.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({super.key});

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
              colors: [Color(0xFF2E6CF6), Color(0xFF1C3FDB)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Privacy Policy",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2),
            Text(
              "User agreement & guidelines",
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PolicyUpdateWidget(lastUpdated: DateTime.now()),
            const PolicyIntroWidget(),
            const PolicyInfoWidget(),
            const PolicyUsageWidget(),
            const PolicySecurityWidget(),
            const PolicyRightsWidget(),
            const PolicyThirdPartyWidget(),
            const PolicyRetentionWidget(),
            const PolicyChildrenWidget(),
            const PolicyChangesWidget(),
            const PolicyContactWidget(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
