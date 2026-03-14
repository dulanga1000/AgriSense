class OtpVerificationModel {
  final String email;
  final List<String> otp;

  OtpVerificationModel({
    required this.email,
    required this.otp,
  });

  bool isOtpComplete() {
    return otp.every((digit) => digit.isNotEmpty);
  }

  String getOtpCode() {
    return otp.join();
  }
}