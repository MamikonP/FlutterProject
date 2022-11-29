import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/utilities.dart';
import '../bloc/user_auth/user_auth_bloc.dart';
import '../shared/widgets.dart';

class AppSignInButtons extends StatelessWidget with AppColors, AppGaps {
  AppSignInButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localization = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        AppSiginButton(
          text: localization.loginWithGoogle,
          assetImage: 'assets/images/icons/google.svg',
          color: lightColor,
          onPressed: () {
            context.read<UserAuthBloc>().add(const UserSignInWithGoogle());
          },
        ),
        AppSiginButton(
          text: localization.loginWithFacebook,
          assetImage: 'assets/images/icons/facebook.svg',
          color: facebookBackgroundColor,
          onPressed: () {
            context.read<UserAuthBloc>().add(const UserSignInWithFacebook());
          },
        ),
        if (Utilities.isIOSPlatform)
          AppSiginButton(
            text: localization.loginWithApple,
            assetImage: 'assets/images/icons/apple.svg',
            color: darkColor,
            onPressed: () {
              context.read<UserAuthBloc>().add(const UserSignInWithApple());
            },
          ),
      ],
    );
  }
}
