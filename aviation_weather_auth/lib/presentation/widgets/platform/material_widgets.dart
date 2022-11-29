import 'package:flutter/material.dart';

import '../../shared/widgets.dart';
import 'abstract_widgets.dart';

class MaterialWidgetsFactory with AppColors implements IWidgetsFactory {
  @override
  Widget slider({
    required double current,
    required void Function(dynamic value)? onChanged,
    double min = 0.0,
    final double max = 1.1,
    void Function(dynamic value)? onChangedEnd,
  }) {
    return Slider(
      min: min,
      max: max,
      value: current,
      onChanged: onChanged,
      onChangeEnd: onChangedEnd,
      activeColor: accentColor,
      inactiveColor: dividerColor,
    );
  }
}
