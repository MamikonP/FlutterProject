import 'package:flutter/material.dart';
import '../../data/constants.dart';
import '../shared/app_screen.dart';
import '../shared/widgets.dart';

class AppLoginPage extends StatelessWidget {
  const AppLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      body: AppAuthorize(AuthType.signIn),
    );
  }
}
