import 'package:flutter/material.dart';
import '../../data/constants.dart';
import '../shared/app_screen.dart';
import '../shared/widgets.dart';

class AppRegisterPage extends StatelessWidget {
  const AppRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      body: AppAuthorize(AuthType.signUp),
    );
  }
}
