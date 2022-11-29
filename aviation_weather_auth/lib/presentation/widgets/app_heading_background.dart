// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../data/constants.dart';
import '../shared/widgets.dart';

class AppHeadingBackground extends StatelessWidget {
  AppHeadingBackground({
    super.key,
    required this.image,
    required this.height,
    required this.imageAlignment,
    this.width
  });

  final String image;
  final Alignment imageAlignment;
  final double height;
  double? width;

  @override
  Widget build(BuildContext context) {
    width ??= MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      height: height,
      child: AppImage(
        image: image,
        imageType: ImageType.asset,
        alignment: imageAlignment,
      ),
    );
  }
}
