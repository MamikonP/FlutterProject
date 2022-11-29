import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({this.progress, super.key});

  final double? progress;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        value: progress,
      ),
    );
  }
}
