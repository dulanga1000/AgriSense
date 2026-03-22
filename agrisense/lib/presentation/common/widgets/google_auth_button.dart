import 'package:flutter/material.dart';

class GoogleAuthButton extends StatefulWidget {
  final String text;
  final VoidCallback onSuccess;

  const GoogleAuthButton({
    super.key,
    required this.text,
    required this.onSuccess,
  });

  @override
  State<GoogleAuthButton> createState() => _GoogleAuthButtonState();
}

class _GoogleAuthButtonState extends State<GoogleAuthButton> {
  bool _isLoading = false;

  Future<void> _handleGoogleAuth() async {
    setState(() => _isLoading = true);

    try {
      // ── Step 1: Google Sign In SDK ─────────────────────────────
      // TODO: uncomment when google_sign_in package is added
      // final googleUser = await GoogleSignIn().signIn();
      // if (googleUser == null) return;

      // ── Step 2: Get credentials ────────────────────────────────
      // final googleAuth = await googleUser.authentication;

      // ── Step 3: Send to your backend ───────────────────────────
      // TODO: replace with your actual AuthRepository call
      // await AuthRepository().googleAuth(
      //   idToken: googleAuth.idToken,
      //   accessToken: googleAuth.accessToken,
      // );

      await Future.delayed(
        const Duration(seconds: 1),
      ); // ← remove when connected

      if (!mounted) return;
      widget.onSuccess();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Google authentication failed: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: _isLoading ? null : _handleGoogleAuth,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.grey[100],
          padding: const EdgeInsets.symmetric(vertical: 16),
          side: const BorderSide(color: Colors.grey),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/android_neutral_rd_na@2x.png',
                    height: 30,
                    width: 30,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    widget.text,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
