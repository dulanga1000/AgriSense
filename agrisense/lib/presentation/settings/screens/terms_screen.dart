import 'package:agrisense/presentation/common/widgets/gradient_app_bar.dart';
import 'package:agrisense/presentation/common/widgets/info_section_widget.dart';
import 'package:agrisense/presentation/settings/constants/terms_constants.dart';
import 'package:flutter/material.dart';
import 'package:agrisense/presentation/common/widgets/info_date_section_widget.dart';
import 'package:agrisense/presentation/common/widgets/info_card_widget.dart';
import '../widgets/terms_acceptance_widget.dart';
import 'package:agrisense/presentation/common/widgets/info_bullet_section_widget.dart';
import '../widgets/terms_disclaimer_widget.dart';
import 'package:agrisense/presentation/common/widgets/info_text_section_widget.dart';
import '../widgets/terms_termination_widget.dart';
import 'package:agrisense/presentation/common/widgets/info_contact_section_widget.dart';
import '../widgets/terms_notice_widget.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const GradientAppBar(
        title: "Terms of Service",
        subtitle: "Your agreement with our services",
        colors: [Color(0xFF2E6CF6), Color(0xFF1C3FDB)],
      ),
      body: Column(
        children: [
          InfoDateSectionWidget(
            label: TermsConstants.effectiveDateLabel,
            date: DateTime.now(),
          ),

          const Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InfoCardWidget(
                    icon: TermsConstants.icon,
                    iconColor: TermsConstants.color,
                    title: TermsConstants.title,
                    description: TermsConstants.description,
                  ),
                  TermsAcceptanceWidget(),
                  InfoSectionWidget(
                    mainIcon: TermsConstants.serviceIcon,
                    mainColor: TermsConstants.serviceColor,
                    title: TermsConstants.serviceTitle,
                    description: TermsConstants.serviceDescription,
                    items: TermsConstants.serviceItems,
                  ),
                  InfoBulletSectionWidget(
                    icon: TermsConstants.responsibilityIcon,
                    iconColor: TermsConstants.responsibilityColor,
                    title: TermsConstants.responsibilityTitle,
                    description: TermsConstants.responsibilityDescription,
                    items: TermsConstants.responsibilityItems,
                  ),
                  TermsDisclaimerWidget(),
                  InfoTextSectionWidget(
                    title: TermsConstants.ipTitle,
                    paragraphs: TermsConstants.ipContent,
                  ),
                  InfoBulletSectionWidget(
                    icon: TermsConstants.liabilityIcon,
                    iconColor: TermsConstants.liabilityColor,
                    title: TermsConstants.liabilityTitle,
                    description: TermsConstants.liabilityDescription,
                    items: TermsConstants.liabilityItems,
                    footerText: TermsConstants.liabilityFooter,
                  ),
                  TermsTerminationWidget(),
                  InfoTextSectionWidget(
                    title: TermsConstants.modificationTitle,
                    paragraphs: TermsConstants.modificationContent,
                  ),
                  InfoTextSectionWidget(
                    title: TermsConstants.governingTitle,
                    paragraphs: TermsConstants.governingContent,
                  ),
                  InfoContactSectionWidget(
                    titleIcon: TermsConstants.contactIcon,
                    title: TermsConstants.contactTitle,
                    description: TermsConstants.contactDescription,
                    items: TermsConstants.contactItems,
                    gradient: TermsConstants.contactGradient,
                  ),
                  TermsNoticeWidget(),
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
