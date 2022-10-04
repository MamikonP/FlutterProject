import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLogo extends StatelessWidget {

	AppLogo({
		Key? key,
		this.size = 'normal'
	}) : super(key: key);

	final String size;
	final Map<String, Map<String, double>> _sizes = {
		'normal': {
			'width': 170,
			'height': 48
		},
		'big': {
			'width': 226,
			'height': 64
		},
	};

	@override
	Widget build(BuildContext context) {
		return SizedBox(
			width: _sizes[size]!['width'],
			height: _sizes[size]!['height'],
			child: SvgPicture.asset('assets/images/common/logo.svg')
		);
	}
}
