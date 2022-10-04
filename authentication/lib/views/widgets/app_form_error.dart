import 'package:flutter/material.dart';

import '../../styles.dart';
import '../widgets.dart';

class AppFormError extends StatelessWidget {

	const AppFormError({
		Key? key,
		this.message = ''
	}) : super(key: key);

	final String message;

	@override
	Widget build(BuildContext context) {
		return Container(
			margin: const EdgeInsets.only(
				top: 8
			),
			child: AppText(
				message,
				size: 'small',
				color: AppColors.attention
			)
		);
	}
}
