import 'package:flutter/material.dart';

import '../../styles.dart';
import '../widgets.dart';

class AppCheckbox extends StatelessWidget {

	const AppCheckbox({
		Key? key,
		this.text = '',
		this.isChecked = false,
		required this.onChanged
	}) : super(key: key);

	final String text;
	final bool isChecked;
	final void Function(bool? value) onChanged;

	@override
	Widget build(BuildContext context) {
		return Row(
			children: <Widget> [

				SizedBox(
					width: 20,
					height: 20,
					child: Checkbox(
						value: isChecked,
						shape: RoundedRectangleBorder(
							borderRadius: BorderRadius.circular(5)
						),
						side: BorderSide(
							color: AppColors.main
						),
						materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
						checkColor: AppColors.light,
						activeColor: AppColors.main,
						onChanged: (bool? value) {
							onChanged(value);
						}
					)
				),

				AppGap(AppGaps.smallest, direction: 'horizontal'),

				GestureDetector(
					onTap: () {
						onChanged(!isChecked);
					},
					child: AppText(
						text,
						size: 'small',
						lineHeight: 1
					)
				)

			]
		);
	}
}
