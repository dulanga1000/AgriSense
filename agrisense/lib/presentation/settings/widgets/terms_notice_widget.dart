import 'package:flutter/material.dart';
import '../constants/terms_constants.dart';

class TermsNoticeWidget extends StatelessWidget {
  const TermsNoticeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: TermsConstants.noticeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: TermsConstants.noticeColor, width: 4),
        ),
      ),
      child: const Text(
        TermsConstants.noticeText,
        style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.4),
      ),
    );
  }
}
