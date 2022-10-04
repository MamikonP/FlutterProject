
import 'package:flutter/material.dart';

import '../styles.dart';
import '../views/widgets.dart';

void showSnackBar(BuildContext context, String content, Color color, 
		{double? width, double horizontalPadding = 8, double verticalPadding = 8}) {
	FocusScope.of(context).requestFocus(FocusNode());
	ScaffoldMessenger.of(context).showSnackBar(
		SnackBar(
			width: width,
			behavior: SnackBarBehavior.floating,
			content: AppText(content, alignment: 'center', color: AppColors.light,),
			backgroundColor: color,
			margin: width != null ? null : EdgeInsets.symmetric(
				horizontal: horizontalPadding,
				vertical: verticalPadding
			),
			padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
			shape: RoundedRectangleBorder(
				borderRadius: BorderRadius.circular(8)
			),
		)
	);
}
