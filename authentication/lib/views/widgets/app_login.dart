import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../extensions/user_login_form_extension.dart';
import '../../modules/user/user_controller.dart';
import '../../modules/user/user_login_controller.dart';
import '../../modules/user/user_service.dart';
import '../../shared/app_snackbar.dart';
import '../../styles.dart';
import '../styles/colors.dart';
import '../../utils/utilities.dart';
import '../../utils/validations.dart';
import '../widgets.dart';


class AppLogin extends GetWidget<UserLoginController> {
	AppLogin({Key? key}) : super(key: key);

	final UserController _userController = Get.find<UserController>();
	final UserService _userService = UserService();
	final Validations _validations = Validations();

	@override
	Widget build(BuildContext context) {

		// top: 64
		return GestureDetector(
			onTap: () => unfocus(context),
			child: Container(
				color: AppColors.transparent,
				child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
						Widget>[
					// Logo
					AppLogo(),

					AppGap(AppGaps.biggest, direction: 'vertical'),

					// Email
					AppInput(
						controller: controller.email,
						placeholder: 'EMAIL'.tr,
						validator: _validations.validateEmail,
						formKey: controller.formKey(FormKey.email),
					),

					AppGap(AppGaps.small, direction: 'vertical'),

					// Password
					Obx(() => AppInput(
							controller: controller.password,
							placeholder: 'PASSWORD'.tr,
							obscureText: controller.obscure.value,
							type: Type.password,
							onTap: () {
								controller.obscure.value = !controller.obscure.value;
							},
							validator: (String? value) {
								if (value == null || value.isEmpty) {
									return 'FIELD_IS_REQUIRED'.tr;
								}
								final Map<String, dynamic> validate = _validations.validatePassword(value);
								for (final MapEntry<dynamic, dynamic> element in validate.entries) {
									if(element.value == false) {
										return 'INVALID PASSWORD'.tr;
									}
								}
								return null;
							},
							formKey: controller.formKey(FormKey.password),
						),
					),

					Obx(() => Visibility(
						visible: _userController.responseError != '',
						child: AppFormError(message: _userController.responseError,)
					)),

					AppGap(AppGaps.smallest, direction: 'vertical'),

					// Remember me && Forgot password?
					Row(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: <Widget> [
							Obx(() => AppCheckbox(
								text: 'REMEMBER ME'.tr,
								isChecked: controller.rememberMe.value,
								onChanged: (bool? value) {
									controller.rememberMe.value = value!;
								}
							)),
							GestureDetector(
								onTap: () {
									_userController.reset();
									Get.toNamed('/reset-password');
								},
								child: AppText(
									'FORGOT PASSWORD?'.tr,
									size: 'small',
									lineHeight: 1
								)
							)
						]
					),

					AppGap(AppGaps.big, direction: 'vertical'),

					AppCaptcha(controller: controller,),

					Obx(() => Visibility(
						visible: _userController.verified.value == UserVerification.invalid,
						child: AppFormError(message: 'INVALID RECAPTCHA'.tr,)
					)),

					AppGap(AppGaps.smallest, direction: 'vertical'),

					// Submit
					AppButton(
						text: 'LOG IN'.tr,
						onPressed: () {
							if (validateAllFields()) {
								signIn();
							}
						}
					),

					AppGap(AppGaps.big, direction: 'vertical'),

					AppDivider(text: 'OR'.tr),

					AppGap(AppGaps.small, direction: 'vertical'),

					GestureDetector(
						onTap: () => signInWithGoogle(context),
						child: Card(
							elevation: 2,
							child: Row(
								mainAxisAlignment: MainAxisAlignment.center,
								children: <Widget>[
									const Image(
										image: AssetImage(
											'assets/logos/google_light.png',
											package: 'flutter_signin_button'
										)
									),
									Flexible(
										child: AppText(
											'CONTINUE WITH GOOGLE'.tr,
											size: 'small',
										),
									)
								],
							),
						),
					),

					AppGap(AppGaps.small, direction: 'vertical'),

					Row(mainAxisAlignment: MainAxisAlignment.center, children: [
						AppText(
							'NOT REGISTERED YET?'.tr,
							size: 'small',
						),
						const SizedBox(width: 5,),
						GestureDetector(
							onTap: () {
								_userController.reset();
								Get.toNamed('/register');
							},
							child: AppText(
								'CREATE AN ACCOUNT'.tr,
								size: 'small',
								isBold: true
							)
						)
					])
				])
			)
		);
	}

	bool validateAllFields() {
		bool validated = true;
		for (final GlobalKey<FormState> formKey in controller.formKeys()) {
			if (formKey.currentState != null && ! formKey.currentState!.validate()) {
				validated = false;
			}
		}
		return validated;
	}

	Future<void> signInWithGoogle(BuildContext context) async {
		try {
			await _userService.signInWithGoogle();
			_userController.reset();
			if (_userController.firstLogin) {
				Get.toNamed('/tfa', arguments: <String, dynamic>{'isSuggestion': true});
			} else {
				Get.toNamed('/wallets');
			}
		} catch (e) {
			if (e.toString() == 'Terms') {
				Get.toNamed('/accept-terms');
			} else {
				showSnackBar(context, e.toString(), AppColors.attention);
			}
		}
	}

	Future<void> handleError(String error) async {
		if (error == 'Invalid recaptcha') {
			_userController.verified.value = UserVerification.invalid;
		} else {
			if(error == 'Account is not activated for ${controller.email.text}') {
				_userController.responseError = 'NEED VERIFICATION VIA EMAIL'.tr;
			} else {
				_userController.responseError = error;
			}
			if (controller.webViewController != null) {
				await controller.webViewController?.reload();
			}
		}
	}

	Future<void> signIn() async{
		try {
			await _userService.login(
				controller.email.text, controller.password.text, _userController.captcha);
			_userController.reset();
			_userController.responseError = '';
			if (_userController.firstLogin) {
				Get.toNamed('/tfa', arguments: <String, dynamic>{'isSuggestion': true});
			} else {
				Get.toNamed('/wallets');
			}
		} catch (error) {
			await handleError(error.toString());
		}
	}

	void unfocus(BuildContext context) {
		FocusScope.of(context).requestFocus(FocusNode());
		if (_userController.verified.value == UserVerification.pending
			&& controller.webViewController != null) {
			controller.webViewController?.reload();
		}
	}
}
