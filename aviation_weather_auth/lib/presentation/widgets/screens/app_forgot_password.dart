import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/constants.dart';
import '../../shared/app_navigator.dart';
import '../../shared/widgets.dart';

class AppForgotPassword extends StatelessWidget with AppColors, AppGaps {
  AppForgotPassword(this._authPasswordType, {super.key});

  final AuthPasswordType _authPasswordType;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localization = AppLocalizations.of(context)!;
    return BaseAppLayout(
      imagePath: 'assets/images/illustration_password.pdf',
      maxHeightHeaderPercent: 0.4,
      children: <Widget>[
        AppText(
          _authPasswordType == AuthPasswordType.forgot
              ? localization.forgotPassword
              : localization.resetPassword,
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: primaryColor,
        ),
        AppGap(medium, direction: AppGapDirection.vertical),
        AppText(
          _authPasswordType == AuthPasswordType.forgot
              ? localization.forgotPasswordDesc
              : localization.resetPasswordDesc,
          fontSize: 12,
          color: secondaryColor,
        ),
        AppGap(highest, direction: AppGapDirection.vertical),
        if (_authPasswordType == AuthPasswordType.forgot)
          AppInput(
            header: localization.email,
            textInputType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
          ),
        if (_authPasswordType == AuthPasswordType.reset)
          AppInput(
            header: localization.newPassword,
            isPassword: true,
          ),
        if (_authPasswordType == AuthPasswordType.reset)
          AppGap(medium, direction: AppGapDirection.vertical),
        if (_authPasswordType == AuthPasswordType.reset)
          AppInput(
            header: localization.confirmPassword,
            isPassword: true,
          ),
        AppGap(medium, direction: AppGapDirection.vertical),
        if (_authPasswordType == AuthPasswordType.forgot)
          AppButton(
            text: localization.sendLinkButton,
            onPressed: () {
              AppNavigator.toNamed(context, '/reset-password');
            },
          )
        else
          AppButton(
            text: localization.resetPasswordButton,
            onPressed: () {
              AppNavigator.popUntil(context, '/login');
            },
          ),
        const Spacer(),
        if (_authPasswordType == AuthPasswordType.forgot)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppText(
                localization.rememberPassword,
                color: secondaryColor,
                fontSize: 12,
              ),
              AppGap(smallest, direction: AppGapDirection.horizontal),
              InkWell(
                onTap: () {
                  AppNavigator.pop(context);
                },
                child: AppText(
                  localization.login,
                  color: accentColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        if (_authPasswordType == AuthPasswordType.forgot)
          AppGap(medium, direction: AppGapDirection.vertical),
      ],
    );
  }
}
