import 'package:flutter/material.dart';
import '../widgets/change_password_header.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: const [
          ChangePasswordHeader(),

          Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
