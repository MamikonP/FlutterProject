import 'package:flutter/material.dart';

import '../shared/widgets.dart';

class AppDivider extends StatelessWidget with AppColors {
  AppDivider({super.key, this.withText, this.thickness});

  final String? withText;
  final double? thickness;

  @override
  Widget build(BuildContext context) {
    Widget divider = Divider(
      color: dividerColor,
      thickness: thickness,
    );

    if (withText != null) {
      divider = Row(
        children: <Widget>[
          Expanded(child: divider),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AppText(
              withText!,
              fontSize: 12,
              color: secondaryColor,
            ),
          ),
          Expanded(child: divider),
        ],
      );
    }

    return divider;
  }
}
