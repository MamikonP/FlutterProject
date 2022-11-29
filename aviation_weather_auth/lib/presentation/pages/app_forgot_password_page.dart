import 'package:flutter/material.dart';
import '../../data/constants.dart';
import '../shared/app_screen.dart';
import '../widgets/screens/app_forgot_password.dart';

class AppForgotPasswordPage extends StatelessWidget {
  const AppForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      body: AppForgotPassword(AuthPasswordType.forgot),
    );
  }
}
