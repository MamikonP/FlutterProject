import 'package:flutter/material.dart';

import '../../styles.dart';

class AppText extends StatelessWidget {

	const AppText(
		this.text,
		{
			Key? key,
			this.size,
			this.fontSize,
			this.height,
			this.lineHeight,
			this.theme,
			this.color,
			this.isUppercase = false,
			this.isBold = false,
			this.fontWeight,
			this.alignment = 'left',
			this.textOverflow,
			this.decoration,
			this.maxLines
		}
	) : super(key: key);

	final String text;
	final String? size;
	final double? fontSize;
	final String? height;
	final double? lineHeight;
	final String? theme;
	final Color? color;
	final bool isUppercase;
	final bool isBold;
	final FontWeight? fontWeight;
	final String alignment;
	final TextOverflow? textOverflow;
	final TextDecoration? decoration;
	final int? maxLines;

	@override
	Widget build(BuildContext context) {
		return Text(
			isUppercase ? text.toUpperCase() : text,
			textAlign: getAlignment(),
			overflow: textOverflow,
			maxLines: maxLines,
			style: TextStyle(
				fontSize: fontSize ?? getFontSize(),
				fontWeight: fontWeight ?? getFontWeight(),
				height: lineHeight ?? getLineHeight(),
				color: color ?? getColor(),
				decoration: decoration
			)
		);
	}

	Color getColor() {
		switch (theme) {
			case 'light':
				return AppColors.light;
			case 'secondary':
				return AppColors.secondary;
			case 'success':
				return AppColors.success;
			case 'attention':
				return AppColors.attention;
			default:
				return AppColors.main;
		}
	}

	double getFontSize() {
		switch (size) {
			case 'smallest':
				return 12;
			case 'small':
				return 14;
			default:
				return 16;
		}
	}

	FontWeight getFontWeight() {
		switch (isBold) {
			case true:
				return FontWeight.bold;
			default:
				return FontWeight.normal;
		}
	}

	double getLineHeight() {
		switch (height) {
			case 'smallest':
				return 1.1;
			case 'small':
				return 1.25;
			case 'big':
				return 1.5;
			default:
				return 1.43;
		}
	}

	TextAlign getAlignment() {
		switch (alignment) {
			case 'center':
				return TextAlign.center;
			case 'right':
				return TextAlign.right;
			default:
				return TextAlign.left;
		}
	}
}
