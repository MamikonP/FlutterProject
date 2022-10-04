import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../styles.dart';

class AppHeading extends StatelessWidget {

	const AppHeading(
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
			this.isBold = true,
			this.alignment = 'left',
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
	final String alignment;
	final int? maxLines;

	@override
	Widget build(BuildContext context) {
		return AutoSizeText(
			isUppercase ? text.toUpperCase() : text,
			textAlign: getAlignment(),
			maxLines: maxLines,
			style: TextStyle(
				fontSize: fontSize ?? getFontSize(),
				fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
				height: lineHeight ?? getLineHeight(),
				color: color ?? getColor()
			)
		);
	}

	Color getColor() {
		switch (theme) {
			case 'light':
				return AppColors.light;
			default:
				return AppColors.main;
		}
	}

	double getFontSize() {
		switch (size) {
			case 'smallest':
				return 14;
			case 'small':
				return 16;
			default:
				return 20;
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
