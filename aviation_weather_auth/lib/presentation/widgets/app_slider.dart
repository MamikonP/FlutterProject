import 'package:flutter/material.dart';

import '../shared/widgets.dart';
import 'platform/abstract_widgets.dart';
import 'platform/get_specific_widgets.dart';
import 'styles/app_slider_track_shape.dart';

class AppSlider extends StatelessWidget with AppColors, AppGaps {
  AppSlider({
    super.key,
    required this.title,
    required this.min,
    required this.max,
    required this.current,
    this.onChanged,
    this.onChangedEnd,
  });

  final String title;
  final double min;
  final double max;
  final double current;
  final void Function(dynamic value)? onChanged;
  final void Function(dynamic value)? onChangedEnd;
  final IWidgetsFactory widgetsFactory = getWidgetsFactory();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: medium),
      margin: EdgeInsets.only(top: medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AppText(
                title,
                fontSize: 12,
                color: Theme.of(context).colorScheme.secondary,
              ),
              AppText(
                '${current.floor()}',
                fontSize: 12,
                color: Theme.of(context).colorScheme.secondary,
              )
            ],
          ),
          SliderTheme(
            data: SliderThemeData(trackShape: AppTrackShape()),
            child: widgetsFactory.slider(
              current: current,
              onChanged: onChanged,
              min: min,
              max: max,
              onChangedEnd: onChangedEnd,
            ),
          ),
        ],
      ),
    );
  }
}
