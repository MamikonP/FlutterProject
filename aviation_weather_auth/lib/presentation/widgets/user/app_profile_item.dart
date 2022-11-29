import 'package:flutter/material.dart';

import '../../../data/constants.dart';
import '../../shared/widgets.dart';

class AppProfileItem extends StatelessWidget with AppColors, AppGaps {
  AppProfileItem(this.iconName, this.text, {required this.onTap, super.key});

  final String iconName;
  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: smallest),
      child: GestureDetector(
        onTap: onTap,
        child: Material(
          color: lightColor,
          borderRadius: BorderRadius.circular(3),
          child: ListTile(
            dense: true,
            minLeadingWidth: 25,
            leading: AppImage(
              image: 'assets/images/icons/$iconName',
              imageType: ImageType.asset,
            ),
            title: AppText(
              text,
              color: primaryColor,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
