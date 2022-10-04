import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../styles.dart';

class AppLoading extends StatelessWidget {
	const AppLoading({this.hasBackground = false, Key? key}) : super(key: key);

	final bool hasBackground;

	Widget _progressIndicator() {
		return Center(
		  child: CircularProgressIndicator(
				color: AppColors.accent,
		  ),
		);
	}

	@override
	Widget build(BuildContext context) {
		if (hasBackground) {
			return Stack(
				alignment: Alignment.center,
				children: <Widget>[
					Container(color: AppColors.light,),
					SvgPicture.asset('assets/images/common/logo.svg'),
					_progressIndicator()
				],
			);
		}
		return _progressIndicator();
	}
}
