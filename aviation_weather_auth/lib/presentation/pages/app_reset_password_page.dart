import 'package:flutter/material.dart';
import '../../data/constants.dart';
import '../shared/app_screen.dart';
import '../widgets/screens/app_forgot_password.dart';

class AppResetPasswordPage extends StatelessWidget {
  const AppResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      body: AppForgotPassword(AuthPasswordType.reset),
    );
  }
}
