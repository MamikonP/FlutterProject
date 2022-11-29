import 'package:flutter/material.dart';

import '../../data/constants.dart';

class AppGap extends StatelessWidget {
  const AppGap(this.gap, {super.key, required this.direction});

  final AppGapDirection direction;
  final double gap;

  @override
  Widget build(BuildContext context) {
    if (direction == AppGapDirection.horizontal) {
      return SizedBox(
        width: gap,
      );
    } else {
      return SizedBox(
        height: gap,
      );
    }
  }
}
