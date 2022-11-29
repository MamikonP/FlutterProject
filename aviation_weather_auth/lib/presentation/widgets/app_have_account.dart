import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/constants.dart';
import '../shared/app_navigator.dart';
import '../shared/widgets.dart';

class AppHaveAnAccount extends StatelessWidget with AppColors {
  AppHaveAnAccount(this._authType, {super.key});

  final AuthType _authType;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localization = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AppText(
          _authType == AuthType.signIn
              ? localization.dontHaveAnAccount
              : localization.alreadyHaveAnAccount,
          color: secondaryColor,
          fontSize: 12,
        ),
        TextButton(
          style: TextButton.styleFrom(
            alignment: Alignment.centerLeft,
            foregroundColor: transparent,
          ),
          onPressed: () {
            if (_authType == AuthType.signIn) {
              AppNavigator.toNamed(context, '/register');
            } else {
              AppNavigator.pop(context);
            }
          },
          child: AppText(
            _authType == AuthType.signIn
                ? localization.signUp
                : localization.login,
            color: accentColor,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
