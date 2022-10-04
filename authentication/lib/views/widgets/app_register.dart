import 'package:flutter/material.dart';
// import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';

import '../../extensions/user_register_form_extension.dart';
import '../../modules/user/user_controller.dart';
import '../../modules/user/user_register_controller.dart';
import '../../modules/user/user_service.dart';
import '../../shared/app_snackbar.dart';
import '../../styles.dart';
import '../../utils/utilities.dart';
import '../../utils/validations.dart';
import '../widgets.dart';

class AppRegister extends GetWidget<UserRegisterController> {
	AppRegister({Key? key}) : super(key: key);

	final UserController _userController = Get.find<UserController>();
	final Validations _validations = Validations();
	final UserService _userService = UserService();

	@override
	Widget build(BuildContext context) {
		return GestureDetector(
			onTap: () => unfocus(context),
			child: Container(
				color: AppColors.transparent,
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.stretch,
					children: [

						AppLogo(),

						AppGap(AppGaps.medium, direction: 'vertical'),

						// First Name
						AppInput(
							controller: controller.firstName,
							placeholder: "${'FIRST NAME'.tr}*",
							validator: _validations.validateFirstName,
							formKey: controller.formKey(FormKey.firstName),
						),

						AppGap(AppGaps.small, direction: 'vertical'),

						// Last Name
						AppInput(
							controller: controller.lastName,
							placeholder: "${'LAST NAME'.tr}*",
							validator: _validations.validateLastName,
							formKey: controller.formKey(FormKey.lastName),
						),

						AppGap(AppGaps.small, direction: 'vertical'),

						// Email
						AppInput(
							controller: controller.email,
							placeholder: "${'EMAIL'.tr}*",
							validator: _validations.validateEmail,
							formKey: controller.formKey(FormKey.email),
						),

						AppGap(AppGaps.small, direction: 'vertical'),

						// Password
						Obx(
							() => AppInput(
								controller: controller.password,
								placeholder: 'PASSWORD'.tr,
								type: Type.password,
								obscureText: controller.obscure.value,
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
							)
						),

						AppGap(AppGaps.small, direction: 'vertical'),

						// Confirm Password
						Obx(
							() => AppInput(
								controller: controller.confirmPassword,
								placeholder: 'CONFIRM PASSWORD'.tr,
								type: Type.password,
								obscureText: controller.confirmPasswordObscure.value,
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

						Obx(
							() => Visibility(
								visible: _userController.responseError != '',
								child: AppFormError(
									message: _userController.responseError,
								)
							)
						),

						AppGap(AppGaps.small, direction: 'vertical'),

						Obx(
							() => AppPasswordStrengthIndicator(
								items: controller.checked,
							)
						),

						AppGap(AppGaps.small, direction: 'vertical'),

						AppCaptcha(controller: controller,),

						Obx(
							() => Visibility(
								visible: _userController.verified.value == UserVerification.invalid,
								child: AppFormError(message: 'INVALID RECAPTCHA'.tr,)
							)
						),

						AppGap(AppGaps.small, direction: 'vertical'),

						Obx(
							() =>  AppCheckbox(
								text: 'I AGREE TO ALL TERMS'.tr,
								isChecked: controller.terms.value,
								onChanged: (bool? value) {
									controller.terms.value = ! controller.terms.value;
									controller.termsError.value = ! controller.terms.value;
								},
							),
						),

						Obx(
							() => Visibility(
								visible: controller.termsError.value,
								child: AppFormError(message: 'FIELD_IS_REQUIRED'.tr,),
							),
						),

						AppGap(AppGaps.big, direction: 'vertical'),

						AppButton(
							text: 'CREATE ACCOUNT'.tr,
							onPressed: () {
								if (validateAllFields()) {
									signUp(context);
								}
							}
						),

						AppGap(AppGaps.big, direction: 'vertical'),
						AppDivider(text: 'OR'.tr),
						AppGap(AppGaps.small, direction: 'vertical'),

						GestureDetector(
							onTap: () => signUpWithGoogle(context),
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

						Row(
							mainAxisAlignment: MainAxisAlignment.center,
							children: <Widget> [
								AppText(
									'HAVE AN ACCOUNT'.tr,
									size: 'small'
								),
								const SizedBox(width: 5,),
								GestureDetector(
									onTap: () {
										_userController.reset();
										Get.offAllNamed('/login');
									},
									child: AppText(
										'LOG IN'.tr,
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

	Future<void> signUpWithGoogle(BuildContext context) async {
		try {
			await _userService.signInWithGoogle();
			_userController.reset();
			Get.toNamed('/wallets');
		} catch (e) {
			if (e.toString() == 'Terms') {
				Get.toNamed('/accept-terms');
			} else {
				showSnackBar(context, e.toString(), AppColors.attention);
			}
		}
	}

	bool validateAllFields() {
		bool validated = true;
		for (final GlobalKey<FormState> formKey in controller.formKeys()) {
			if (formKey.currentState != null && !formKey.currentState!.validate()) {
				validated = false;
			}
		}
		if (!controller.terms.value) {
			controller.termsError.value = true;
		}
		return validated;
	}

	Map<String, dynamic> registerData() {
		return <String, dynamic>{
			'firstName': controller.firstName.text,
			'lastName': controller.lastName.text,
			'email': controller.email.text,
			'password': controller.password.text,
			'captcha': _userController.captcha,
			'isAgreeWithTerms': controller.terms.value,
			'lang': 'hy',
		};
	}

	Future<void> handleError(String error) async {
		if (error == 'Invalid recaptcha') {
			_userController.verified.value = UserVerification.invalid;
		} else {
			_userController.responseError = error;
			if (controller.webViewController != null) {
				await controller.webViewController?.reload();
			}
		}
	}

	Future<void> signUp(BuildContext context) async {
		try {
			await _userService.register(registerData());
			_userController.email.value = controller.email.text;
			_userController.reset();
			_userController.responseError = '';
			Get.offNamed('/email-activation');
		} catch (error) {
			await handleError(error.toString());
		}
	}

	void unfocus(BuildContext context) {
		FocusScope.of(context).requestFocus(FocusNode());
		if (_userController.verified.value == UserVerification.pending &&
				controller.webViewController != null) {
			controller.webViewController?.reload();
		}
	}
}
