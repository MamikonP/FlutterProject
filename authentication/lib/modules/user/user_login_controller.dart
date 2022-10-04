import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../extensions/user_login_form_extension.dart';
import 'user_base_form_controller.dart';

class UserLoginController extends UserBaseFormController {
	final RxBool rememberMe = false.obs;
	
	List<GlobalKey<FormState>> formKeys() {
		return <GlobalKey<FormState>>[
			emailKey!,
			passwordKey!,
		];
	}

	GlobalKey<FormState> formKey(FormKey formKey) {
		switch (formKey) {
			case FormKey.email:
				emailKey = formKey.key;
				return emailKey!;
			case FormKey.password:
				passwordKey = formKey.key;
				return passwordKey!;
		}
	}
}
