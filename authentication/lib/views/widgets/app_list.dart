import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../styles.dart';
import '../widgets.dart';

class AppList extends StatelessWidget {

	const AppList({
		Key? key,
		required this.items,
	}) : super(key: key);

	final Map<String, dynamic> items;

	@override
	Widget build(BuildContext context) {
		final List<String> rules = items.keys.toList();
		return Column(
			children: rules.map((String rule) {
				return Column(
					children: <Widget> [
						Row(
							children: <Widget> [
								SizedBox(
									width: 18,
									child: Center(
										child: items[rule] == true ? SvgPicture.asset(
											'assets/images/icons/checkmark.svg') :
											Container(
												width: 3,
												height: 3,
												decoration: BoxDecoration(
													color: AppColors.main,
													shape: BoxShape.circle
												),
										),
									)
								),
								const AppGap(2, direction: 'horizontal'),
								Text(
									rule.toUpperCase().tr,
									style: TextStyle(
										fontSize: 12,
										height: 1.5,
										color: AppColors.main
									)
								)
							]
						)
					]
				);
			}).toList()
		);
	}
}
