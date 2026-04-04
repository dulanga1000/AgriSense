import 'package:agrisense/presentation/common/widgets/info_section_widget.dart';
import 'package:agrisense/presentation/settings/constants/policy_constants.dart';
import 'package:flutter/material.dart';
import 'package:agrisense/presentation/common/widgets/app_back_button.dart';
import 'package:agrisense/presentation/common/widgets/info_date_section_widget.dart';
import 'package:agrisense/presentation/common/widgets/info_card_widget.dart';
import '../widgets/policy_info_widget.dart';
import '../widgets/policy_usage_widget.dart';
import 'package:agrisense/presentation/common/widgets/info_bullet_section_widget.dart';
import '../widgets/policy_thirdparty_widget.dart';
import 'package:agrisense/presentation/common/widgets/info_text_section_widget.dart';
import 'package:agrisense/presentation/common/widgets/info_contact_section_widget.dart';

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
            InfoDateSectionWidget(
              label: PolicyConstants.lastUpdatedLabel,
              date: DateTime(2026, 4, 3), // or from backend
            ),
            InfoCardWidget(
              icon: PolicyConstants.introIcon,
              iconColor: PolicyConstants.introColor,
              title: PolicyConstants.introTitle,
              description: PolicyConstants.introDescription,
            ),
            PolicyInfoWidget(),
            PolicyUsageWidget(),
            InfoSectionWidget(
              mainIcon: PolicyConstants.securityIcon,
              mainColor: PolicyConstants.securityColor,
              title: PolicyConstants.securityTitle,
              description: PolicyConstants.securityDescription,
              items: PolicyConstants.securityItems,
            ),
            InfoBulletSectionWidget(
              icon: PolicyConstants.rightsIcon,
              iconColor: PolicyConstants.rightsColor,
              title: PolicyConstants.rightsTitle,
              description: PolicyConstants.rightsDescription,
              items: PolicyConstants.rightsItems,
            ),
            PolicyThirdPartyWidget(),
            InfoTextSectionWidget(
              title: PolicyConstants.retentionTitle,
              paragraphs: PolicyConstants.retentionContent,
            ),
            InfoTextSectionWidget(
              title: PolicyConstants.childrenTitle,
              paragraphs: PolicyConstants.childrenContent,
            ),
            InfoTextSectionWidget(
              title: PolicyConstants.changesTitle,
              paragraphs: PolicyConstants.changesContent,
            ),
            InfoContactSectionWidget(
              titleIcon: PolicyConstants.contactIcon,
              title: PolicyConstants.contactTitle,
              description: PolicyConstants.contactDescription,
              items: PolicyConstants.contactItems,
              backgroundColor: PolicyConstants.contactBgColor,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
