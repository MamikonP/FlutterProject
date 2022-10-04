import 'package:flutter/material.dart';

import '../../styles.dart';
import '../widgets.dart';

class AppPasswordStrengthIndicator extends StatelessWidget {

	const AppPasswordStrengthIndicator({
		Key? key,
		required this.items,
	}) : super(key: key);

	final Map<String, dynamic> items;

	@override
	Widget build(BuildContext context) {
		final double widthFactor = calculatePasswordWidthFactor(items);
		return Column(
			children: <Widget> [
				Stack(
					children: <Widget> [
						FractionallySizedBox(
							widthFactor: 1,
							child: Container(
								height: 3,
								decoration: BoxDecoration(
									borderRadius: BorderRadius.circular(3),
									color: AppColors.main.withOpacity(0.05)
								)
							)
						),
						FractionallySizedBox(
							widthFactor: widthFactor,
							child: Container(
								height: 3,
								decoration: BoxDecoration(
									borderRadius: BorderRadius.circular(3),
									color: widthFactor == 0.3 ? AppColors.attention :
												widthFactor == 0.7 ? AppColors.warning :
												widthFactor == 1.0 ? AppColors.success :
												AppColors.attention
								),
							),
						),
					],
				),
				AppGap(AppGaps.small, direction: 'vertical'),
				AppList(
					items: items,
				)
			]
		);
	}

	double calculatePasswordWidthFactor(Map<String, dynamic> checked) {
		final int checkedCount = checked.values.toList()
			.where((dynamic element) => element == true).toList().length;
		switch (checkedCount) {
		  case 0:
			case 1:
				return 0.0;
			case 2:
				return 0.3;
			case 3:
				return 0.7;
			case 4:
				return 1.0;
		  default:
				return 0;
		}
	}
}
