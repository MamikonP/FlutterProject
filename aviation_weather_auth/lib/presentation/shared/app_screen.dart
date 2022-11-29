// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../widgets/app_bottom_navigation_bar.dart';
import 'widgets.dart';

class AppScreen extends StatelessWidget with AppColors {
  AppScreen({
    Key? key,
    required this.body,
    this.scrollable = false,
    this.paddingLeft = 0,
    this.paddingRight = 0,
    this.paddingTop = 0,
    this.paddingBottom = 0,
    this.withNavigationBar = false,
    this.appBar,
  }) : super(key: key);

  final Widget body;
  final bool scrollable;
  final double paddingLeft;
  final double paddingRight;
  final double paddingTop;
  final double paddingBottom;
  final bool withNavigationBar;
  final AppBar? appBar;

  @override
  Widget build(BuildContext context) {
    final Padding paddingBody = Padding(
      padding: EdgeInsets.only(
        left: paddingLeft,
        right: paddingRight,
        top: paddingTop,
        bottom: paddingBottom,
      ),
      child: body,
    );

    final Widget bodyLayout = scrollable
        ? SingleChildScrollView(
            child: paddingBody,
          )
        : paddingBody;

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: bodyLayout,
      ),
      bottomNavigationBar: withNavigationBar ? AppBottomNavigationBar() : null,
    );
  }
}
