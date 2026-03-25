import 'package:flutter/material.dart';
import '../widgets/terms_header_widget.dart';
import '../widgets/terms_date_widget.dart';
import '../widgets/terms_agreement_widget.dart';
import '../widgets/terms_acceptance_widget.dart';
import '../widgets/terms_description_widget.dart';
import '../widgets/terms_responsibility_widget.dart';
import '../widgets/terms_disclaimer_widget.dart';
import '../widgets/terms_ip_widget.dart';
import '../widgets/terms_liability_widget.dart';
import '../widgets/terms_termination_widget.dart';
import '../widgets/terms_modification_widget.dart';
import '../widgets/terms_governing_widget.dart';
import '../widgets/terms_contact_widget.dart';
import '../widgets/terms_notice_widget.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      body: Column(
        children: const [
          // 🔷 Header
          TermsHeaderWidget(),

          // 📅 Effective Date
          TermsDateWidget(),

          // 📄 Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TermsAgreementWidget(),
                  TermsAcceptanceWidget(),
                  TermsDescriptionWidget(),
                  TermsResponsibilityWidget(),
                  TermsDisclaimerWidget(),
                  TermsIPWidget(),
                  TermsLiabilityWidget(),
                  TermsTerminationWidget(),
                  TermsModificationWidget(),
                  TermsGoverningWidget(),
                  TermsContactWidget(),
                  TermsNoticeWidget(), // ✅ FINAL NOTICE
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
