import 'dart:async';
import 'package:flutter/material.dart';
import 'package:agrisense/core/services/auth_api_service.dart';
import 'package:agrisense/presentation/auth/widgets/otp_input_box.dart';
import 'package:agrisense/presentation/auth/widgets/step_indicator.dart';
import 'package:agrisense/presentation/common/widgets/auth_card.dart';
import 'package:agrisense/presentation/common/widgets/auth_snackbar.dart';
import 'package:agrisense/presentation/common/widgets/custom_button.dart';

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

  int seconds = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    f1.dispose();
    f2.dispose();
    f3.dispose();
    f4.dispose();
    f5.dispose();
    f6.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds == 0) {
        t.cancel();
      } else {
        setState(() => seconds--);
      }
    });
  }

  void _resendCode() async {
    try {
      await AuthApiService.sendOtp(widget.email);
      setState(() => seconds = 60);
      _startTimer();
      AuthSnackBar.showSuccess(context, 'OTP resent');
    } catch (e) {
      AuthSnackBar.showError(context, 'Failed to resend');
    }
  }

  void _onVerify() async {
    final otp =
        widget.c1.text +
        widget.c2.text +
        widget.c3.text +
        widget.c4.text +
        widget.c5.text +
        widget.c6.text;

    if (otp.length != 6) {
      AuthSnackBar.showError(context, 'Enter complete OTP');
      return;
    }

    try {
      await AuthApiService.verifyOtp(widget.email, otp);

      AuthSnackBar.showSuccess(context, 'OTP verified!');
      widget.onNext();
    } catch (e) {
      AuthSnackBar.showError(context, 'Invalid OTP');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const StepIndicator(currentStep: 2),
        const SizedBox(height: 20),

        AuthCard(
          child: Column(
            children: [
              // Key icon at the top
              Container(
                margin: const EdgeInsets.only(bottom: 10, top: 10),
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: const Color(0xFFEAF3FF),
                  child: Image.asset(
                    'assets/icons/app_icon.png',
                    width: 32,
                    height: 32,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.vpn_key, size: 32, color: Colors.blueAccent),
                  ),
                ),
              ),
              const Text(
                'Enter Verification Code',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'We sent a 6-digit code to\n${widget.email}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 20),

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

              CustomButton(text: 'Verify Code', onPressed: _onVerify),

              const SizedBox(height: 10),

              seconds > 0
                  ? Text('Resend in ${seconds}s')
                  : TextButton(
                      onPressed: _resendCode,
                      child: const Text('Resend OTP'),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
