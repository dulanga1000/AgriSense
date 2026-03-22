import 'package:flutter/material.dart';
import '../widgets/privacy_header_widget.dart';
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

      body: Column(
        children: [
          // 🔷 Header
          PrivacyHeaderWidget(onBack: () => Navigator.pop(context)),

          // 📅 Last Updated
          PolicyUpdateWidget(lastUpdated: DateTime.now()),

          // 📄 Scrollable Content
          const Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  PolicyIntroWidget(),
                  PolicyInfoWidget(),
                  PolicyUsageWidget(),
                  PolicySecurityWidget(),
                  PolicyRightsWidget(),
                  PolicyThirdPartyWidget(),
                  PolicyRetentionWidget(),
                  PolicyChildrenWidget(),
                  PolicyChangesWidget(),
                  PolicyContactWidget(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
