// ignore_for_file: avoid_dynamic_calls

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../configuration/configuration_controller.dart';
import '../../modules/user/user_controller.dart';

class AppCaptchaIOS extends StatefulWidget {

	const AppCaptchaIOS({
		Key? key,
		required this.userAuthorizationController
	}) : super(key: key);

	final dynamic userAuthorizationController;

	@override
	State createState() => _AppCaptchaIOSState();
}

class _AppCaptchaIOSState extends State<AppCaptchaIOS> {
	final UserController _userController = Get.find<UserController>();
	final ConfigurationController _configurationController = Get.find<ConfigurationController>();

	double size = 0.0;
	double initialSize = 0.0;
	double initialWidth = double.infinity;

	@override
	Widget build(BuildContext context) {
		return Obx(() => SizedBox(
			height: size,
			child: _userController.verified.value != UserVerification.failed 
				? _configurationController.isLoaded.value 
				? Stack(
				children: <Widget>[
					WebView(
						initialUrl: _configurationController.config['reCaptcha']['url'].toString(),
						zoomEnabled: false,
						javascriptMode: JavascriptMode.unrestricted,
						onWebViewCreated: (WebViewController controller) {
							widget.userAuthorizationController.webViewController = controller;
						},
						onPageFinished: (String url) async{
							final WebViewController webController =
								widget.userAuthorizationController.webViewController as WebViewController;
							final double s = double.parse( await
								webController.runJavascriptReturningResult(
									"document.querySelector('.captcha-form').offsetHeight"
								)
							);
							final double width = double.parse( await
								webController.runJavascriptReturningResult(
									"document.querySelector('.captcha-form').offsetWidth"
								)
							);
							setState(() {
								size = s;
								initialWidth = width;
							});
							initialSize = size;
							_userController.verified.value = UserVerification.started;
						},
						javascriptChannels: <JavascriptChannel>{
							JavascriptChannel(
								name: _configurationController.config['reCaptcha']['channelName'].toString(),
								onMessageReceived: (JavascriptMessage captcha) {
									_userController.captcha = captcha.message;
									_userController.verified.value = UserVerification.verified;
									setState(() => size = initialSize);
									startTimer();
								},
							),
						},
						onWebResourceError: (WebResourceError error) {
							_userController.verified.value = UserVerification.failed;
						},
					),

					GestureDetector(
						behavior: HitTestBehavior.translucent,
						onTap: () {
							if (_userController.verified.value == UserVerification.started ||
									_userController.verified.value == UserVerification.invalid) {
								setState(() => size = 500);
								_userController.verified.value = UserVerification.pending;
							}
						},
						child: Container(width: initialWidth,),
					)
				],
			) : const SizedBox.shrink() : const SizedBox.shrink(),
		)
		);
	}

	void startTimer() {
		Timer(const Duration(minutes: 1), () {
			_userController.reset();
		});
	}
}
