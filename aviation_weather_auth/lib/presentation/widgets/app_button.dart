import 'package:flutter/material.dart';

import '../shared/widgets.dart';

class AppButton extends StatelessWidget with AppColors {
  AppButton({super.key, required this.text, required this.onPressed});

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppGradientBox(
      colors: <Color>[accentColor, accentBrightColor],
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          alignment: Alignment.center,
          backgroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          minimumSize: const Size(double.infinity, 40),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: AppText(
          text,
          fontSize: 13,
        ),
      ),
    );
  }
}
