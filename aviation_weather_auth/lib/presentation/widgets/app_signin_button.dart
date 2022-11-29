import 'package:flutter/material.dart';

import '../../data/constants.dart';
import '../shared/widgets.dart';

class AppSiginButton extends StatelessWidget with AppColors {
  AppSiginButton({
    required this.text,
    required this.assetImage,
    required this.color,
    required this.onPressed,
    super.key,
  });

  final String text;
  final String assetImage;
  final Color color;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: color,
          padding: EdgeInsets.zero,
          minimumSize: const Size(double.infinity, 40),
          side: color == lightColor ? BorderSide(color: dividerColor) : null,
        ),
        onPressed: onPressed,
        child: Row(
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                  color: color == facebookBackgroundColor
                      ? facebookIconBackgroundColor
                      : color == darkColor
                          ? darkColor
                          : lightColor,
                  border: color == lightColor
                      ? Border(
                          right: BorderSide(color: dividerColor),
                        )
                      : null),
              child: AppImage(
                image: assetImage,
                imageType: ImageType.asset,
                fit: BoxFit.none,
              ),
            ),
            Expanded(
              child: AppText(
                text,
                color: color == lightColor ? primaryColor : lightColor,
                textAlign: TextAlign.center,
                fontSize: 13,
              ),
            )
          ],
        ),
      ),
    );
  }
}
