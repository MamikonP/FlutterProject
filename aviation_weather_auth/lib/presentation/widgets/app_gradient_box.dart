import 'package:flutter/material.dart';

class AppGradientBox extends StatelessWidget {
  const AppGradientBox({
    required this.colors,
    required this.child,
    super.key,
  });

  final List<Color> colors;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: const <double>[0.11, 0.84],
          colors: colors,
        ),
        borderRadius: BorderRadius.circular(3),
      ),
      child: child,
    );
  }
}
