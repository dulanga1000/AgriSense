import 'package:flutter/material.dart';
import '../../common/widgets/info_section_widget.dart';
import '../../common/widgets/info_contact_section_widget.dart';

class DisclaimerSection {
  final String title;
  final String description;

  const DisclaimerSection({required this.title, required this.description});
}

class TermsConstants {
  // =========================================================
  // 🟢 1. DATE
  // =========================================================
  static const effectiveDateLabel = "Effective Date";

  // =========================================================
  // 🟢 2. INTRO (CARD)
  // =========================================================
  static const title = "Agreement to Terms";

  static const description =
      "Welcome to AgriSense! By accessing or using our mobile farming application, you agree to be bound by these Terms of Service. Please read them carefully before using the app. If you disagree with any part of these terms, you may not access the service.";

  static const icon = Icons.description_outlined;
  static const color = Colors.blue;

  // =========================================================
  // 🟢 3. ACCEPTANCE
  // =========================================================
  static const acceptanceTitle = "Acceptance of Terms";

  static const acceptanceDescription =
      "By creating an account and using AgriSense, you acknowledge that you have read, understood, and agree to be bound by these Terms of Service and our Privacy Policy.";

  static const acceptanceIcon = Icons.check_circle_outline;
  static const acceptanceColor = Colors.green;

  static const acceptanceBoxTitle = "You confirm that:";

  static const List<String> acceptanceItems = [
    "You are at least 13 years of age",
    "You have the legal capacity to enter into this agreement",
    "You will provide accurate and complete information",
  ];

  // =========================================================
  // 🟢 4. SERVICE SECTION
  // =========================================================
  static const serviceTitle = "Description of Service";

  static const serviceDescription =
      "AgriSense is a smart farming assistant application that provides:";

  static const serviceIcon = Icons.phone_android;
  static const serviceColor = Colors.purple;

  static const List<InfoItem> serviceItems = [
    InfoItem(
      icon: Icons.eco,
      color: Colors.green,
      title: "Disease Detection",
      description:
          "AI-powered plant disease identification and treatment recommendations",
    ),
    InfoItem(
      icon: Icons.wb_sunny,
      color: Colors.orange,
      title: "Weather Insights",
      description: "Real-time weather data and crop-specific advice",
    ),
    InfoItem(
      icon: Icons.water_drop,
      color: Colors.blue,
      title: "Fertilizer Recommendations",
      description:
          "Customized fertilizer suggestions based on crop and land size",
    ),
    InfoItem(
      icon: Icons.bar_chart,
      color: Colors.purple,
      title: "Farming Analytics",
      description:
          "Insights and notifications to optimize your farming practices",
    ),
  ];

  // =========================================================
  // 🟢 5. RESPONSIBILITY
  // =========================================================
  static const responsibilityTitle = "User Responsibilities";

  static const responsibilityDescription =
      "As a user of AgriSense, you agree to:";

  static const responsibilityIcon = Icons.people_outline;
  static const responsibilityColor = Colors.orange;

  static const List<String> responsibilityItems = [
    "Provide accurate and truthful information when registering and using the app",
    "Maintain the security and confidentiality of your account credentials",
    "Use the app only for lawful purposes and in accordance with these Terms",
    "Not attempt to gain unauthorized access to any part of the app",
    "Not use the app to transmit viruses, malware, or harmful code",
    "Not interfere with or disrupt the service or servers",
    "Respect the intellectual property rights of AgriSense and third parties",
  ];

  // =========================================================
  // 🟢 6. DISCLAIMER
  // =========================================================
  static const disclaimerTitle = "Important Disclaimer";

  static const disclaimerIcon = Icons.warning_amber_rounded;
  static const disclaimerColor = Colors.orange;

  static const disclaimerHighlight =
      "AgriSense provides informational and educational content only. The recommendations and advice provided by the app should not be considered as professional agricultural advice.";

  static const List<DisclaimerSection> disclaimerSections = [
    DisclaimerSection(
      title: "Professional Consultation:",
      description:
          "Always consult with qualified agricultural professionals, agronomists, or local farming experts before making significant farming decisions.",
    ),
    DisclaimerSection(
      title: "AI Limitations:",
      description:
          "While our disease detection uses advanced AI, it may not be 100% accurate. Verify findings with laboratory testing when necessary.",
    ),
    DisclaimerSection(
      title: "Weather Data:",
      description:
          "Weather forecasts are provided by third-party services and may not always be accurate. Use them as guidance only.",
    ),
    DisclaimerSection(
      title: "No Guarantees:",
      description:
          "We do not guarantee crop yields, harvest success, or financial outcomes from using our recommendations.",
    ),
  ];

  // =========================================================
  // 🟢 7. IP
  // =========================================================
  static const ipTitle = "Intellectual Property Rights";

  static const List<String> ipContent = [
    "All content, features, and functionality of AgriSense are the exclusive property of AgriSense.",
    "These are protected by international copyright, trademark, and intellectual property laws.",
    "You may not reproduce, distribute, or exploit any part of the app without permission.",
  ];

  // =========================================================
  // 🟢 8. LIABILITY
  // =========================================================
  static const liabilityTitle = "Limitation of Liability";

  static const liabilityDescription =
      "To the fullest extent permitted by law, AgriSense shall not be liable for:";

  static const liabilityIcon = Icons.balance;
  static const liabilityColor = Colors.red;

  static const List<String> liabilityItems = [
    "Any indirect, incidental, special, or consequential damages",
    "Loss of profits, revenue, data, or agricultural yields",
    "Crop failures or pest infestations",
    "Damages resulting from reliance on app recommendations",
    "Service interruptions or technical errors",
    "Actions taken by third-party service providers",
  ];

  static const liabilityFooter =
      "Your use of AgriSense is at your sole risk. The service is provided \"as is\" and \"as available\" without warranties of any kind.";

  // =========================================================
  // 🟢 9. TERMINATION
  // =========================================================
  static const terminationTitle = "Account Termination";

  static const terminationDescription =
      "We reserve the right to suspend or terminate your account at any time if:";

  static const List<String> terminationItems = [
    "You violate these Terms of Service",
    "You engage in fraudulent or illegal activities",
    "Your account has been inactive for an extended period",
    "We are required to do so by law",
  ];

  static const terminationFooter =
      "You may also delete your account at any time through the app settings.";

  // =========================================================
  // 🟢 10. MODIFICATION
  // =========================================================
  static const modificationTitle = "Modifications to Terms";

  static const List<String> modificationContent = [
    "We reserve the right to modify or replace these Terms at any time.",
    "We will notify users at least 30 days before changes take effect.",
    "Continued use means acceptance of updated Terms.",
  ];

  // =========================================================
  // 🟢 11. GOVERNING LAW
  // =========================================================
  static const governingTitle = "Governing Law";

  static const List<String> governingContent = [
    "These Terms are governed by the laws of Sri Lanka.",
    "Any disputes shall be resolved in Sri Lankan courts.",
  ];

  // =========================================================
  // 🟢 12. CONTACT
  // =========================================================
  static const contactTitle = "Questions About Terms?";

  static const contactDescription =
      "If you have any questions about these Terms of Service, please contact our legal team:";

  static const contactIcon = Icons.description;

  static const contactGradient = LinearGradient(
    colors: [Color(0xFF2E6CF6), Color(0xFF1C3FDB)],
  );

  static const List<ContactItem> contactItems = [
    ContactItem(icon: Icons.email_outlined, text: "Email: legal@agrisense.com"),
    ContactItem(icon: Icons.phone_outlined, text: "Phone: +94 11 234 5678"),
    ContactItem(
      icon: Icons.location_on_outlined,
      text: "Address: AgriSense HQ, Colombo, Sri Lanka",
    ),
  ];

  // =========================================================
  // 🟢 13. NOTICE
  // =========================================================
  static const noticeText =
      "By using AgriSense, you acknowledge that you have read, understood, and agree to be bound by these Terms of Service.";

  static const noticeColor = Colors.green;
}
