import 'package:flutter/material.dart';

import '../../data/constants.dart';
import '../shared/widgets.dart';

class BaseAppLayout extends StatelessWidget with AppGaps {
  BaseAppLayout({
    required this.imagePath,
    required this.children,
    this.imageAlignment = Alignment.center,
    this.maxHeightHeaderPercent = 0.3,
    this.headerChild,
    this.bodyPadding,
    super.key,
  });

  final String imagePath;
  final Alignment imageAlignment;
  final List<Widget> children;
  final EdgeInsets? bodyPadding;
  final double maxHeightHeaderPercent;
  final Widget? headerChild;

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double minHeight = (deviceHeight * maxHeightHeaderPercent) >
            AppConstants.DEFAULT_BACKGROUND_HEIGHT
        ? AppConstants.DEFAULT_BACKGROUND_HEIGHT
        : deviceHeight * maxHeightHeaderPercent;
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Positioned(
          top: 0,
          child: AppHeadingBackground(
            image: imagePath,
            height: minHeight,
            imageAlignment: imageAlignment,
          ),
        ),
        Positioned(
          bottom: 0,
          top: minHeight - medium,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: AppBox(
                  color: Theme.of(context).colorScheme.background,
                  maxHeightPercent: 1,
                  padding: bodyPadding,
                  child: CustomScrollView(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    slivers: <Widget>[
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: children,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (headerChild != null)
          Positioned(
            top: 0,
            child: headerChild!,
          )
      ],
    );
  }
}
