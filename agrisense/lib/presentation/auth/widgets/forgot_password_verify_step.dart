import 'dart:async';
import 'package:flutter/material.dart';
import 'package:agrisense/presentation/auth/widgets/otp_input_box.dart';
import 'package:agrisense/presentation/auth/widgets/step_indicator.dart';
import 'package:agrisense/presentation/common/widgets/auth_snackbar.dart';
import 'package:agrisense/presentation/common/widgets/auth_button.dart';
import 'package:agrisense/presentation/common/widgets/auth_card.dart';

class ForgotPasswordVerifyStep extends StatefulWidget {
  final VoidCallback onNext;
  final String email;
  final TextEditingController c1;
  final TextEditingController c2;
  final TextEditingController c3;
  final TextEditingController c4;
  final TextEditingController c5;
  final TextEditingController c6;

  const ForgotPasswordVerifyStep({
    super.key,
    required this.onNext,
    required this.email,
    required this.c1,
    required this.c2,
    required this.c3,
    required this.c4,
    required this.c5,
    required this.c6,
  });

  @override
  State<ForgotPasswordVerifyStep> createState() =>
      _ForgotPasswordVerifyStepState();
}

class _ForgotPasswordVerifyStepState extends State<ForgotPasswordVerifyStep> {
  final FocusNode f1 = FocusNode();
  final FocusNode f2 = FocusNode();
  final FocusNode f3 = FocusNode();
  final FocusNode f4 = FocusNode();
  final FocusNode f5 = FocusNode();
  final FocusNode f6 = FocusNode();

  int seconds = 58;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds == 0) {
        t.cancel();
      } else {
        setState(() => seconds--);
      }
    });
  }

  void clearOtpBoxes() {
    widget.c1.clear();
    widget.c2.clear();
    widget.c3.clear();
    widget.c4.clear();
    widget.c5.clear();
    widget.c6.clear();
    FocusScope.of(context).requestFocus(f1);
  }

  void resendCode() {
    setState(() => seconds = 58);
    clearOtpBoxes();
    startTimer();
    AuthSnackBar.showSuccess(context, "OTP resent successfully");
  }

  bool _isOtpComplete() {
    return widget.c1.text.trim().isNotEmpty &&
        widget.c2.text.trim().isNotEmpty &&
        widget.c3.text.trim().isNotEmpty &&
        widget.c4.text.trim().isNotEmpty &&
        widget.c5.text.trim().isNotEmpty &&
        widget.c6.text.trim().isNotEmpty;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const StepIndicator(currentStep: 2),
          const SizedBox(height: 20),

          AuthCard(
            child: Column(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0E8F3E).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.key,
                    color: Color(0xFF0E8F3E),
                    size: 32,
                  ),
                ),
                const SizedBox(height: 20),

                const Text(
                  "Enter Verification Code",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                Text(
                  "We sent a 6-digit code to ${widget.email}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OtpInputBox(controller: widget.c1, focusNode: f1),
                    OtpInputBox(controller: widget.c2, focusNode: f2),
                    OtpInputBox(controller: widget.c3, focusNode: f3),
                    OtpInputBox(controller: widget.c4, focusNode: f4),
                    OtpInputBox(controller: widget.c5, focusNode: f5),
                    OtpInputBox(controller: widget.c6, focusNode: f6),
                  ],
                ),
                const SizedBox(height: 30),

                AuthButton(
                  text: "Verify Code",
                  icon: Icons.verified,
                  onPressed: () {
                    if (seconds == 0) {
                      clearOtpBoxes();
                      AuthSnackBar.showError(
                        context,
                        "OTP expired. Please resend the code.",
                      );
                      return;
                    }

                    if (!_isOtpComplete()) {
                      AuthSnackBar.showError(
                        context,
                        "Please enter complete 6-digit code",
                      );
                      return;
                    }

                    AuthSnackBar.showSuccess(
                      context,
                      "Verification successful",
                    );
                    widget.onNext();
                  },
                ),
                const SizedBox(height: 15),

                seconds > 0
                    ? Text(
                        "Resend code in ${seconds}s",
                        style: const TextStyle(color: Colors.black54),
                      )
                    : TextButton(
                        onPressed: resendCode,
                        child: const Text(
                          "Resend Code",
                          style: TextStyle(
                            color: Color(0xFF0E8F3E),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
