import 'package:flutter/material.dart';

import '../../styles.dart';
import '../widgets.dart';

class AppDivider extends StatelessWidget {

	const AppDivider({
		Key? key,
		this.theme,
		this.color,
		this.text
	}) : super(key: key);

	final String? theme;
	final Color? color;
	final String? text;

	@override
	Widget build(BuildContext context) {
		final Widget line = Container(
			color: color ?? getColor(theme),
			height: 1
		);

		final Widget divider = text == null
			? line
			: Row(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
				children: <Widget> [
					Flexible(
						child: line
					),
					Padding(
						padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
						child: AppText(
							text!,
							size: 'small',
							color: color ?? getColor(theme)
						)
					),
					Flexible(
						child: line
					)
				]
			);

		return divider;
	}

	Color getColor(String? theme) {
		switch (theme) {
			case 'dark':
				return AppColors.main.withOpacity(0.3);
			default:
				return AppColors.main.withOpacity(0.1);
		}
	}
}
