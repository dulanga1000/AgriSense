import 'dart:async';
import 'package:flutter/material.dart';
import 'otp_input_box.dart';
import 'step_indicator.dart';
import 'package:agrisense/presentation/auth/widgets/auth_snackbar.dart';
import 'package:agrisense/presentation/auth/widgets/auth_button.dart';
import 'package:agrisense/data/models/auth_button_model.dart';

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

  /// Focus Nodes
  final FocusNode f1 = FocusNode();
  final FocusNode f2 = FocusNode();
  final FocusNode f3 = FocusNode();
  final FocusNode f4 = FocusNode();
  final FocusNode f5 = FocusNode();
  final FocusNode f6 = FocusNode();

  /// Timer
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
        setState(() {
          seconds--;
        });
      }
    });
  }

  /// CLEAR OTP BOXES
  void clearOtpBoxes() {
    widget.c1.clear();
    widget.c2.clear();
    widget.c3.clear();
    widget.c4.clear();
    widget.c5.clear();
    widget.c6.clear();

    FocusScope.of(context).requestFocus(f1);
  }

  /// RESEND OTP
  void resendCode() {

    setState(() {
      seconds = 58;
    });

    clearOtpBoxes();   // <-- IMPORTANT FIX

    startTimer();

    AuthSnackBar.showSuccess(
      context,
      "OTP resent successfully",
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
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
  Widget build(BuildContext context) {

    final verifyButton = AuthButtonModel(
      text: "Verify Code",
      icon: Icons.verified,
    );

    return SingleChildScrollView(
      child: Column(
        children: [

          const StepIndicator(currentStep: 2),

          const SizedBox(height: 20),

          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 15,
                    offset: Offset(0, 6),
                  ),
                ],
              ),

              child: Column(
                children: [

                  /// Icon
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0E8F3E).withOpacity(0.1),
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
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "We sent a 6-digit code to ${widget.email}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// OTP Boxes
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

                  /// VERIFY BUTTON
                  AuthButton(
                    button: verifyButton,
                    onPressed: () {

                      /// OTP expired
                      if (seconds == 0) {

                        clearOtpBoxes();

                        AuthSnackBar.showError(
                          context,
                          "OTP expired. Please resend the code.",
                        );

                        return;
                      }

                      /// OTP incomplete
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

                  /// RESEND TIMER / BUTTON
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
          ),
        ],
      ),
    );
  }
}

