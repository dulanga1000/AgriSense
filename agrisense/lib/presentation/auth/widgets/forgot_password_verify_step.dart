import 'package:flutter/material.dart';
import 'otp_input_box.dart';

class ForgotPasswordVerifyStep extends StatelessWidget {

  final VoidCallback onNext;

  ForgotPasswordVerifyStep({super.key, required this.onNext});

  final c1 = TextEditingController();
  final c2 = TextEditingController();
  final c3 = TextEditingController();
  final c4 = TextEditingController();
  final c5 = TextEditingController();
  final c6 = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [

          const SizedBox(height: 30),

          const Text(
            "Enter Verification Code",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          const Text(
            "We sent a 6-digit code to guest@email.com",
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 25),

          // otp input boxes
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OtpInputBox(controller: c1),
              OtpInputBox(controller: c2),
              OtpInputBox(controller: c3),
              OtpInputBox(controller: c4),
              OtpInputBox(controller: c5),
              OtpInputBox(controller: c6),
            ],
          ),

          const SizedBox(height: 30),

          // verify button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onNext,
              child: const Text("Verify Code"),
            ),
          ),
        ],
      ),
    );
  }
}