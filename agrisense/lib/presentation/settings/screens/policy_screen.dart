import 'package:agrisense/presentation/common/widgets/gradient_app_bar.dart';
import 'package:agrisense/presentation/common/widgets/info_section_widget.dart';
import 'package:agrisense/presentation/settings/constants/policy_constants.dart';
import 'package:flutter/material.dart';
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
      appBar: const GradientAppBar(
        title: "Privacy Policy",
        subtitle: "User agreement & guidelines",
        colors: [Color(0xFF2E6CF6), Color(0xFF1C3FDB)],
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
