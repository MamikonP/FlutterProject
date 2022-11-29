import 'package:flutter/material.dart';

import '../shared/widgets.dart';

class AppSearchField extends StatelessWidget with AppColors, AppGaps {
  AppSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(small),
      child: Material(
        color: lightColor,
        borderRadius: BorderRadius.circular(small),
        child: AppInput(
          hintText: 'Search...',
          withBorder: false,
          contentPadding: EdgeInsets.zero,
          textInputAction: TextInputAction.done,
          prefixWidget: Icon(
            Icons.search,
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
