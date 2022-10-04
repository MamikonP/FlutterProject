import 'package:flutter/material.dart';

class AppGap extends StatelessWidget {

	const AppGap(
		this.size,
		{
			Key? key,
			required this.direction
		}
	) : super(key: key);

	final double size;
	final String direction;

	@override
	Widget build(BuildContext context) {
		return SizedBox(
			width: getWidth(direction),
			height: getHeight(direction)
		);
	}

	double getWidth(String direction) {
		return direction == 'horizontal' ? size : 0;
	}

	double getHeight(String direction) {
		return direction == 'vertical' ? size : 0;
	}
}
