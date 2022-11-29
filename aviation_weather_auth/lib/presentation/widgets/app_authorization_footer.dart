import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/constants.dart';
import '../shared/app_navigator.dart';
import '../shared/widgets.dart';

class AppAuthorizationFooter extends StatelessWidget with AppColors, AppGaps {
  AppAuthorizationFooter(this._authType, {super.key});

  final AuthType _authType;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localization = AppLocalizations.of(context)!;
    final Widget footer = _authType == AuthType.signIn
        ? TextButton(
            onPressed: () {
              AppNavigator.pop(context);
            },
            child: AppText(
              localization.skipNow,
              color: accentColor,
              textDecoration: TextDecoration.underline,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),
          )
        : RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(
                fontSize: 12,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: localization.signingAgreement,
                  style: TextStyle(color: secondaryColor),
                ),
                TextSpan(
                  recognizer: _navigate(context, '/terms'),
                  text: ' ${localization.terms} ',
                  style: TextStyle(
                    color: accentColor,
                  ),
                ),
                TextSpan(
                  text: localization.signingUsage,
                  style: TextStyle(color: secondaryColor),
                ),
                TextSpan(
                  recognizer: _navigate(context, '/privacy-policy'),
                  text: ' ${localization.privacyPolicy} ',
                  style: TextStyle(
                    color: accentColor,
                  ),
                ),
              ],
            ),
          );
    return Padding(
      padding: EdgeInsets.all(small),
      child: footer,
    );
  }

  TapGestureRecognizer _navigate(BuildContext context, String route) {
    return TapGestureRecognizer()
      ..onTap = () => AppNavigator.toNamed(context, route);
  }
}
