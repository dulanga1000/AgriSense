import 'package:flutter/material.dart';
import '../../common/widgets/info_section_widget.dart';
import '../../common/widgets/info_contact_section_widget.dart';

class InfoSectionData {
  final String title;
  final List<String> items;

  const InfoSectionData({required this.title, required this.items});
}

class PolicyConstants {
  // =========================================================
  // 🟢 1. DATE
  // =========================================================
  static const lastUpdatedLabel = "Last Updated";

  // =========================================================
  // 🟢 2. INTRO
  // =========================================================
  static const introTitle = "Introduction";

  static const introDescription =
      "Welcome to AgriSense. We are committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy explains how we collect, use, and safeguard your data when you use our mobile farming application.";

  static const introIcon = Icons.shield_outlined;
  static const introColor = Colors.green;

  // =========================================================
  // 🟢 3. INFORMATION WE COLLECT
  // =========================================================
  static const infoTitle = "Information We Collect";

  static const infoIcon = Icons.storage_outlined;
  static const infoColor = Colors.blue;

  static const List<InfoSectionData> infoSections = [
    InfoSectionData(
      title: "Personal Information:",
      items: [
        "Name and contact details",
        "Farm location and size",
        "Profile information",
        "Login credentials (encrypted)",
      ],
    ),
    InfoSectionData(
      title: "Usage Data:",
      items: [
        "Crop detection images",
        "Disease scanning history",
        "Weather preferences",
        "App usage patterns",
      ],
    ),
    InfoSectionData(
      title: "Location Data:",
      items: [
        "GPS coordinates for weather data",
        "Regional farming information",
        "Climate-specific recommendations",
      ],
    ),
  ];

  // =========================================================
  // 🟢 4. USAGE
  // =========================================================
  static const usageTitle = "How We Use Your Information";

  static const usageIcon = Icons.remove_red_eye_outlined;
  static const usageColor = Colors.purple;

  static const List<String> usageItems = [
    "Provide personalized farming recommendations and crop advice",
    "Detect and identify plant diseases using AI technology",
    "Deliver weather updates and farming alerts specific to your location",
    "Improve our services and develop new features",
    "Send you important notifications about your crops and farm",
    "Ensure app security and prevent fraudulent activity",
  ];

  // =========================================================
  // 🟢 5. SECURITY
  // =========================================================
  static const securityTitle = "Data Security";

  static const securityDescription =
      "We implement industry-standard security measures to protect your personal information:";

  static const securityIcon = Icons.lock_outline;
  static const securityColor = Colors.red;

  static const List<InfoItem> securityItems = [
    InfoItem(
      icon: Icons.lock,
      color: Colors.orange,
      title: "Encryption",
      description:
          "All data is encrypted in transit and at rest using AES-256 encryption",
    ),
    InfoItem(
      icon: Icons.shield,
      color: Colors.blue,
      title: "Secure Servers",
      description:
          "Data stored on secure, protected servers with regular backups",
    ),
    InfoItem(
      icon: Icons.person,
      color: Colors.purple,
      title: "Access Control",
      description: "Limited access to personal data on a need-to-know basis",
    ),
    InfoItem(
      icon: Icons.search,
      color: Colors.teal,
      title: "Regular Audits",
      description: "Periodic security audits and vulnerability assessments",
    ),
  ];

  // =========================================================
  // 🟢 6. RIGHTS
  // =========================================================
  static const rightsTitle = "Your Rights";

  static const rightsDescription = "You have the right to:";

  static const rightsIcon = Icons.description_outlined;
  static const rightsColor = Colors.orange;

  static const List<String> rightsItems = [
    "Access your personal data stored in the app",
    "Request correction of inaccurate data",
    "Delete your account and associated data",
    "Opt-out of marketing communications",
    "Export your data in a portable format",
    "Withdraw consent for data processing",
  ];

  // =========================================================
  // 🟢 7. THIRD PARTY
  // =========================================================
  static const thirdPartyTitle = "Third-Party Services";

  static const thirdPartyDescription =
      "AgriSense may use third-party services for:";

  static const List<String> thirdPartyItems = [
    "Weather data and forecasts",
    "AI-powered disease detection",
    "Cloud storage and analytics",
    "Payment processing (if applicable)",
  ];

  static const thirdPartyFooter =
      "These services have their own privacy policies and we ensure they meet our security standards.";

  // =========================================================
  // 🟢 8. RETENTION
  // =========================================================
  static const retentionTitle = "Data Retention";

  static const List<String> retentionContent = [
    "We retain your personal information only as long as necessary to provide our services and comply with legal obligations.",
    "You can request deletion of your data at any time through the app settings.",
    "Upon deletion, your data will be permanently removed from our servers within 30 days.",
  ];

  // =========================================================
  // 🟢 9. CHILDREN
  // =========================================================
  static const childrenTitle = "Children's Privacy";

  static const List<String> childrenContent = [
    "AgriSense is not intended for users under the age of 13.",
    "We do not knowingly collect personal information from children.",
    "If you believe we have collected information from a child, please contact us immediately.",
  ];

  // =========================================================
  // 🟢 10. CHANGES
  // =========================================================
  static const changesTitle = "Changes to This Policy";

  static const List<String> changesContent = [
    "We may update this Privacy Policy from time to time.",
    "We will notify you of any significant changes via email or in-app notification.",
    "Your continued use of AgriSense after changes are made constitutes acceptance of the updated policy.",
  ];

  // =========================================================
  // 🟢 11. CONTACT
  // =========================================================
  static const contactTitle = "Contact Us";

  static const contactDescription =
      "If you have any questions or concerns about this Privacy Policy or your data, please contact us:";

  static const contactIcon = Icons.notifications_none;

  static final contactBgColor = Colors.green.shade700;

  static const List<ContactItem> contactItems = [
    ContactItem(
      icon: Icons.email_outlined,
      text: "Email: privacy@agrisense.com",
    ),
    ContactItem(icon: Icons.phone_outlined, text: "Phone: +94 11 234 5678"),
    ContactItem(
      icon: Icons.location_on_outlined,
      text: "Address: AgriSense HQ, Colombo, Sri Lanka",
    ),
  ];
}
