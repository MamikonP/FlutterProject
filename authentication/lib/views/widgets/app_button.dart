import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../styles.dart';
import '../widgets.dart';

class AppButton extends StatelessWidget {

	const AppButton({
		Key? key,
		this.text,
		this.icon,
		this.theme,
		required this.onPressed
	}) : super(key: key);

	final String? text;
	final String? icon;
	final String? theme;
	final VoidCallback onPressed;

	@override
	Widget build(BuildContext context) {
		late final Widget child;
		late String iconName = '';
		late Color backgroundColor;
		late Color textColor;
		late double borderWidth;

		if (icon != null) {
			switch (icon) {
				case 'arrowRight':
					iconName = 'arrow-right.svg';
					break;
				case 'arrowUp':
					iconName = 'arrow-up.svg';
					break;
				case 'arrowDown':
					iconName = 'arrow-down.svg';
					break;
				case 'swapHorizontal':
					iconName = 'swap-horizontal.svg';
					break;
			}
		}

		switch (theme) {
			case 'outline':
				backgroundColor = AppColors.transparent;
				break;
			case 'attention':
				backgroundColor = AppColors.attention;
				break;
			default:
				backgroundColor = AppColors.accent;
		}

		if (theme == 'attention') {
			textColor = AppColors.light;
		}
		else {
			textColor = AppColors.main;
		}

		if (theme == 'outline') {
			borderWidth = 2;
		}
		else {
			borderWidth = 0;
		}

		child = Row(
			mainAxisAlignment: MainAxisAlignment.center,
			mainAxisSize: MainAxisSize.min,
			children: <Widget> [

				if (icon != null) SizedBox(
					width: 24,
					height: 24,
					child: SvgPicture.asset('assets/images/icons/$iconName')
				),

				if (icon != null && text != null) const AppGap(4, direction: 'horizontal'),

				if (text != null) Text(
					text!,
					style: TextStyle(
						fontSize: 16,
						height: 1,
						color: textColor
					)
				)

			]
		);

		return Container(
			constraints: const BoxConstraints(
				minHeight: 48
			),
			decoration: BoxDecoration(
				boxShadow: <BoxShadow> [
					BoxShadow(
						color: AppColors.accent.withOpacity(0.2),
						blurRadius: 30,
						offset: const Offset(0, 5)
					)
				]
			),
			child: ElevatedButton(
				onPressed: onPressed,
				style: ButtonStyle(
					overlayColor: MaterialStateProperty.all(AppColors.transparent),
					foregroundColor: MaterialStateProperty.all(AppColors.transparent),
					shadowColor: MaterialStateProperty.all(AppColors.transparent),
					surfaceTintColor: MaterialStateProperty.all(AppColors.transparent),
					backgroundColor: MaterialStateProperty.all(backgroundColor),
					shape: MaterialStateProperty.all(
						RoundedRectangleBorder(
							side: BorderSide(
								width: borderWidth,
								color: AppColors.accent
							),
							borderRadius: BorderRadius.circular(8)
						)
					),
					padding: MaterialStateProperty.all(
						const EdgeInsets.only(
							top: 5,
							bottom: 5,
							left: 16,
							right: 16
						)
					),
					elevation: MaterialStateProperty.all(0)
				),
				child: child
			)
		);
	}
}
