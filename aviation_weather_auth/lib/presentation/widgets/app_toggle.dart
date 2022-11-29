import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

import '../../data/constants.dart';
import '../../data/settings_constants.dart';
import '../shared/widgets.dart';

class AppToggle extends StatelessWidget with AppColors, AppGaps {
  AppToggle({
    required this.title,
    required this.labels,
    required this.selectedIndex,
    required this.selectedLabelIndex,
    this.hasPremiumAccess = false,
    super.key,
  });

  final String title;
  final List<String> labels;
  final int selectedIndex;
  final dynamic Function(int index) selectedLabelIndex;
  final bool hasPremiumAccess;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppGap(medium, direction: AppGapDirection.vertical),
        Padding(
          padding: EdgeInsets.only(left: medium),
          child: Align(
            alignment: Alignment.centerLeft,
            child: AppText(
              title,
              fontSize: 12,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        AppGap(small, direction: AppGapDirection.vertical),
        Stack(
          children: <Widget>[
            Container(
              constraints: const BoxConstraints(
                minHeight: 40,
              ),
              padding: EdgeInsets.all(smallest),
              decoration: BoxDecoration(
                color: lightColor,
                borderRadius: BorderRadius.circular(5),
                boxShadow: <BoxShadow>[
                  BoxShadow(blurRadius: 5, color: hoverColor),
                ],
              ),
              child: FlutterToggleTab(
                borderRadius: 5,
                labels: labels,
                selectedIndex: selectedIndex,
                selectedTextStyle: TextStyle(fontSize: 14, color: lightColor),
                unSelectedTextStyle: TextStyle(fontSize: 12, color: darkColor),
                selectedLabelIndex: selectedLabelIndex,
                height: high,
                isScroll: false,
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                selectedBackgroundColors: <Color>[
                  accentColor,
                  accentBrightColor
                ],
                unSelectedBackgroundColors: <Color>[transparent],
                isShadowEnable: false,
                width: 100 - small,
              ),
            ),
            if (hasPremiumAccess)
              Positioned(
                right: smallest,
                top: smallest,
                child: SizedBox(
                  width: highest,
                  height: medium,
                  child: AppGradientBox(
                    colors: <Color>[
                      permiumAccessColor,
                      permiumAccessBrightColor,
                    ],
                    child: AppText(
                      'PRO',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: lightColor,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
          ],
        ),
        if (title == ClockSystem.name)
          AppGap(medium, direction: AppGapDirection.vertical),
      ],
    );
  }
}
