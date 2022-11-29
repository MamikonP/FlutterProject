import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/constants.dart';
import '../../shared/widgets.dart';

class AppChangePassword extends StatelessWidget with AppGaps {
  AppChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localization = AppLocalizations.of(context)!;
    return Column(
      children: <Widget>[
        AppInput(
          header: localization.password,
          isPassword: true,
        ),
        AppGap(small, direction: AppGapDirection.vertical),
        AppInput(
          header: localization.currentPassword,
          isPassword: true,
        ),
        AppInput(
          header: localization.newPassword,
          isPassword: true,
          textInputAction: TextInputAction.done,
        ),
        AppGap(medium, direction: AppGapDirection.vertical),
        AppButton(
          text: 'Update Password',
          onPressed: () {},
        ),
      ],
    );
  }
}
