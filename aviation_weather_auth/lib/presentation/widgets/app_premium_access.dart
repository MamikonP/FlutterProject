import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';
import '../shared/widgets.dart';

class AppPremiumAccess extends StatelessWidget with AppColors, AppGaps {
  AppPremiumAccess({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(small),
        margin: EdgeInsets.all(small),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: <Widget>[
            AppText(
              L10n.locale(context).localization.getPremiumAccess,
              fontSize: 18,
            ),
            AppText(L10n.locale(context).localization.unlockFeatures),
          ],
        ),
      ),
    );
  }
}
