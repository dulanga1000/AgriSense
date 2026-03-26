import 'package:flutter/material.dart';
import 'package:agrisense/presentation/common/widgets/app_back_button.dart';
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
              "Terms of Service",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2),
            Text(
              "Your agreement with our services",
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
      body: Column(
        children: const [
          TermsDateWidget(),

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
