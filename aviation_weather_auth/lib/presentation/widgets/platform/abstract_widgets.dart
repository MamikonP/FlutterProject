import 'package:flutter/material.dart';

abstract class IWidgetsFactory {
  Widget slider({required double current,
    required void Function(dynamic value)? onChanged,
    double min = 0.0,
    final double max = 1.0,
    void Function(dynamic value)? onChangedEnd,});
}
