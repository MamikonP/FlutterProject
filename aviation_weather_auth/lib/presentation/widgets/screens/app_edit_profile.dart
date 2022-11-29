import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/constants.dart';
import '../../shared/app_navigator.dart';
import '../../shared/widgets.dart';

class AppEditProfile extends StatelessWidget with AppGaps, AppColors {
  AppEditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localization = AppLocalizations.of(context)!;
    final User? user = FirebaseAuth.instance.currentUser;
    return Column(
      children: <Widget>[
        AppInput(
          header: localization.name,
          initialValue: user?.displayName,
          textCapitalization: TextCapitalization.sentences,
          withBorder: false,
          includeHeader: true,
          suffixWidget: Icon(
            Icons.edit,
            color: primaryColor,
            size: 20,
          ),
        ),
        AppGap(small, direction: AppGapDirection.vertical),
        AppInput(
          header: localization.email,
          initialValue: user?.email,
          textInputType: TextInputType.emailAddress,
          withBorder: false,
          includeHeader: true,
          enabled: false,
        ),
        AppGap(small, direction: AppGapDirection.vertical),
        GestureDetector(
          onTap: () {
            AppNavigator.toNamed(context, '/change-password');
          },
          child: AppInput(
            header: localization.password,
            initialValue: '******',
            isPassword: true,
            withBorder: false,
            includeHeader: true,
            enabled: false,
            suffixWidget: Icon(
              Icons.edit,
              color: primaryColor,
              size: 20,
            ),
          ),
        ),
        AppGap(medium, direction: AppGapDirection.vertical),
        AppText(
          localization.deleteAccount,
          color: primaryColor,
          textDecoration: TextDecoration.underline,
          fontSize: 12,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
