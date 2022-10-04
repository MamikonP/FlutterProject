import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../extensions/user_reset_password_form_extension.dart';
import '../../modules/user/user_controller.dart';
import '../../modules/user/user_reset_password_controller.dart';
import '../../modules/user/user_service.dart';
import '../../styles.dart';
import '../../utils/validations.dart';
import '../widgets.dart';


class AppResetPassword extends GetWidget<UserResetPasswordController> {

	AppResetPassword({Key? key}) : super(key: key);

	final UserController _userController = Get.find<UserController>();
	final Validations _validations = Validations();
	final UserService _userService = UserService();

	@override
	Widget build(BuildContext context) {

		// top: 64
		return GestureDetector(
			onTap: () => unfocus(context),
			child: Container(
				color: AppColors.transparent,
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.stretch,
					children: [

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

						// New Password
						Obx(() => AppInput(
								controller: controller.password,
								placeholder: 'NEW PASSWORD'.tr,
								obscureText: controller.obscure.value,
								type: Type.password,
								onTap: () {
									controller.obscure.value =
										!controller.obscure.value;
								},
								onChanged: (String value) {
									final Map<String, dynamic> check = _validations.validatePassword(value);
									controller.checked = check;
								},
								validator: (String? value) {
									if (value == null || value.isEmpty) {
										return 'FIELD_IS_REQUIRED'.tr;
									}
									for (final MapEntry<dynamic, dynamic> element in
											controller.checked.entries) {
										if(element.value == false) {
											return 'INVALID PASSWORD'.tr;
										}
									}
									return null;
								},
								formKey: controller.formKey(FormKey.password),
							),
						),

						AppGap(AppGaps.small, direction: 'vertical'),

						// Confirm New Password
						Obx(() =>  AppInput(
								controller: controller.confirmPassword,
								placeholder: 'CONFIRM NEW PASSWORD'.tr,
								obscureText: controller.confirmPasswordObscure.value,
								type: Type.password,
								onTap: () {
									controller.confirmPasswordObscure.value =
										!controller.confirmPasswordObscure.value;
								},
								validator: (String newPassword) {
									return _validations.validateConfirmPassword(
													controller.password.value.text, newPassword);
								},
								formKey: controller.formKey(FormKey.confirmPassword),
							),
						),

						Obx(() => Visibility(
							visible: _userController.responseError != '',
							child: AppFormError(message: _userController.responseError,)
						)),

						AppGap(AppGaps.big, direction: 'vertical'),

						Obx(() => AppPasswordStrengthIndicator(
								items: controller.checked,
							),
						),

						AppGap(AppGaps.big, direction: 'vertical'),

						AppCaptcha(controller: controller,),

						Obx(() => Visibility(
							visible: _userController.verified.value == UserVerification.invalid,
							child: AppFormError(message: 'INVALID RECAPTCHA'.tr,)
						)),

						AppGap(AppGaps.big, direction: 'vertical'),

						AppButton(
							text: 'RESET PASSWORD'.tr,
							onPressed: () {
								if (validateAllFields()) {
									resetPassword(context);
								}
							}
						),

						AppGap(AppGaps.big, direction: 'vertical'),

						Row(
							mainAxisAlignment: MainAxisAlignment.center,
							children: <Widget> [
								AppText(
									'NOT REGISTERED YET?'.tr,
									size: 'small'
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
							]
						)
					]
				),
			),
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

	Future<void> handleError(String error) async {
		if (error == 'Invalid recaptcha') {
			_userController.verified.value = UserVerification.invalid;
		} else {
			_userController.responseError = error;
			if (controller.webViewController != null) {
				controller.webViewController?.reload();
			}
		}
	}

	Future<void> resetPassword(BuildContext context) async {
		try {
			await _userService.resetPassword(
				controller.email.text, controller.password.text, _userController.captcha);
			_userController.email.value = controller.email.text;
			_userController.reset();
			_userController.responseError = '';
			Get.offNamed('/email-activation',
				arguments: <String, String> {
					'header': 'RESET PASSWORD'.tr,
					'sub_header': 'EMAIL SENT'.tr,
					'content': 
						'${'WE’VE SENT AN EMAIL TO EMAIL A LINK TO CHANGE YOUR PASSWORD.'.tr} ${'FOLLOW THE INSTRUCTIONS TO COMPLETE PASSWORD CHANGE.'.tr}'
				});
		} catch (error) {
			handleError(error.toString());
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
