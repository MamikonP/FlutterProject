import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../extensions/user_register_form_extension.dart';
import 'user_base_form_controller.dart';

class UserRegisterController extends UserBaseFormController {
	final TextEditingController confirmPassword = TextEditingController();
	final TextEditingController firstName = TextEditingController();
	final TextEditingController lastName = TextEditingController();
	final RxBool terms = false.obs;
	final RxBool termsError = false.obs;
	final RxBool confirmPasswordObscure = true.obs;
	final RxDouble widthFactor = 0.0.obs;
	final RxMap<String, dynamic> _checked = <String, dynamic>{
		'At least 6 characters': false,
		'An uppercase character': false,
		'A lowercase character': false,
		'A number': false,
	}.obs;

	List<GlobalKey<FormState>> formKeys() {
		return <GlobalKey<FormState>>[
			firstNameKey!,
			lastNameKey!,
			emailKey!,
			passwordKey!,
			confirmPasswordKey!,
		];
	}

	GlobalKey<FormState> formKey(FormKey formKey) {
		switch (formKey) {
			case FormKey.firstName:
				firstNameKey = formKey.key;
				return firstNameKey!;
			case FormKey.lastName:
				lastNameKey = formKey.key;
				return lastNameKey!;
			case FormKey.email:
				emailKey = formKey.key;
				return emailKey!;
			case FormKey.password:
				passwordKey = formKey.key;
				return passwordKey!;
			case FormKey.confirmPassword:
				confirmPasswordKey = formKey.key;
				return confirmPasswordKey!;
		}
	}

	set checked(Map<String, dynamic> value) => _checked.value = value;
	Map<String, dynamic> get checked => _checked.value;
}
