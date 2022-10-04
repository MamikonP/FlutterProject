// ignore_for_file: avoid_dynamic_calls

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grecaptcha/grecaptcha.dart';

import '../../../configuration/configuration_controller.dart';
import '../../modules/user/user_controller.dart';
import '../../shared/app_snackbar.dart';
import '../../styles.dart';

class AppCaptchaAndroid extends StatelessWidget {
	AppCaptchaAndroid({Key? key}) : super(key: key);

	final UserController _userController = Get.find<UserController>();
	final ConfigurationController _configurationController = Get.find<ConfigurationController>();

	@override
	Widget build(BuildContext context) {
		return MaterialButton(
			padding: const EdgeInsets.symmetric(vertical: 8),
			elevation: 1.0,
			color: AppColors.captcha,
			child: Row(
				children: <Widget>[
					Stack(children: <Widget>[
						Obx(
							() => Visibility(
								visible:
										_userController.verified.value == UserVerification.pending,
								child: const SizedBox(
									height: 25,
									width: 25,
									child: CircularProgressIndicator(color: Colors.green),
								),
							),
						),
						Obx(
							() => Visibility(
								visible:
										_userController.verified.value != UserVerification.pending,
								child: Checkbox(
									value: _userController.verified.value ==
											UserVerification.verified,
									checkColor: AppColors.light,
									activeColor: AppColors.success,
									onChanged: (bool? value) async {
										if (_userController.verified.value !=
												UserVerification.verified) {
											await verifyUser(context);
										}
									},
								),
							),
						),
					]),
					const SizedBox(width: 5,),
					Expanded(
						child: Text(
							'I AM NOT A ROBOT'.tr,
							textAlign: TextAlign.left,
						),
					),
				],
			),
			onPressed: () async {
				if (_userController.verified.value != UserVerification.verified) {
					await verifyUser(context);
				}
			},
		);
	}

	void startTimer() {
		Timer(const Duration(minutes: 2), () {
			_userController.reset();
		});
	}

	Future<void> verifyUser(BuildContext context) async {
		final String siteKey = _configurationController.config['reCaptcha']['siteKey'].toString();

		try {
			_userController.verified.value = UserVerification.pending;

			Grecaptcha()
				.verifyWithRecaptcha(siteKey)
				.then(
					(String captcha) {
						_userController.captcha = captcha;
						_userController.verified.value = UserVerification.verified;
						startTimer();
					},
					onError: (dynamic e) {
						_userController.verified.value = UserVerification.failed;
						showSnackBar(context, 'INVALID RECAPTCHA'.tr, AppColors.attention);
					}
				);
		}
		catch (e) {
			_userController.verified.value = UserVerification.failed;
			showSnackBar(context, 'NETWORK_ERROR_HEADING'.tr, AppColors.attention);
		}
	}
}
