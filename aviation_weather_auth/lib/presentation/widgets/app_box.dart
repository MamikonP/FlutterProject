import 'package:flutter/material.dart';

import '../shared/widgets.dart';

class AppBox extends StatelessWidget with AppGaps {
  AppBox(
      {required this.child,
      required this.maxHeightPercent,
      this.color = Colors.white,
      this.padding,
      super.key});

  final Widget child;
  final double maxHeightPercent;
  final Color color;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding:
          padding ?? EdgeInsets.only(left: medium, right: medium, top: small),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(medium),
          topRight: Radius.circular(medium),
        ),
      ),
      child: child,
    );
  }
}
