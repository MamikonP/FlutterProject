import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    this.fontSize = 16,
    this.textAlign = TextAlign.start,
    this.fontWeight = FontWeight.w500,
    this.textDecoration = TextDecoration.none,
    this.color,
    super.key,
  });

  final String text;
  final double fontSize;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final TextDecoration textDecoration;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        decoration: textDecoration,
      ),
    );
  }
}
