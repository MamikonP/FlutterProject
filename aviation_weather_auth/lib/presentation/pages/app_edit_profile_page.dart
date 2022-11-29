import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../shared/app_screen.dart';
import '../shared/widgets.dart';
import '../widgets/screens/app_edit_profile.dart';

class AppEditProfilePage extends StatelessWidget with AppColors, AppGaps {
  AppEditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      appBar: AppBar(
        title: AppText(AppLocalizations.of(context)!.editProfile),
        centerTitle: true,
        backgroundColor: accentColor,
      ),
      body: AppEditProfile(),
      paddingLeft: small,
      paddingRight: small,
      paddingTop: medium,
      scrollable: true,
    );
  }
}
