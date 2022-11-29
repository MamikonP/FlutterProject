import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../shared/app_screen.dart';
import '../shared/widgets.dart';
import '../widgets/screens/app_change_password.dart';

class AppChangePasswordPage extends StatelessWidget with AppColors, AppGaps {
  AppChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      appBar: AppBar(
        title: AppText(AppLocalizations.of(context)!.changePassword),
        centerTitle: true,
        backgroundColor: accentColor,
      ),
      body: AppChangePassword(),
      paddingLeft: small,
      paddingRight: small,
      paddingTop: medium,
      scrollable: true,
    );
  }
}
