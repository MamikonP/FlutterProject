import 'dart:io';

import 'package:flutter/material.dart';

import '../widgets.dart';

class AppCaptcha extends StatelessWidget {
	const AppCaptcha({this.controller, Key? key}) : super(key: key);
	
	final dynamic controller;

	@override
	Widget build(BuildContext context) {
		if (Platform.isAndroid) {
			return AppCaptchaAndroid();
		} else if (Platform.isIOS) {
			return AppCaptchaIOS(userAuthorizationController: controller);
		}
		return const SizedBox.shrink();
	}
}
