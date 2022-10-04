import 'package:get/get_utils/src/extensions/internacionalization.dart';

class Validations {
	Map<String, dynamic> validatePassword(String? value) {
		final Map<String, dynamic> check = <String, dynamic>{
			'An uppercase character': value?.contains(RegExp(r'[A-Z]')),
			'A lowercase character': value?.contains(RegExp(r'[a-z]')),
			'A number': value?.contains(RegExp(r'[0-9]')),
			'At least 6 characters': value?.contains(RegExp(r'.{6,}')),
		};
		return check;
	}

	String? validateConfirmPassword(String? password, String? newPassword) {
		if (newPassword == null || newPassword.isEmpty) {
			return 'FIELD_IS_REQUIRED'.tr;
		}
		if (password != newPassword) {
			return 'PASSWORDS DO NOT MATCH'.tr;
		}
		return null;
	}

	String? validateEmail(String value) {
		final RegExp regExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
		if (value == null || value.isEmpty) {
			return 'FIELD_IS_REQUIRED'.tr;
		} else if(!regExp.hasMatch(value)) {
			return 'INVALID EMAIL'.tr;
		}
		return null;
	}

	String? validateFirstName(String value) {
		if (value == null || value.isEmpty) {
			return 'FIELD_IS_REQUIRED'.tr;
		} else if(value.contains(RegExp(r'[0-9]'))) {
			return 'INVALID FIRST NAME'.tr;
		}
		return null;
	}

	String? validateLastName(String value) {
		if (value == null || value.isEmpty) {
			return 'FIELD_IS_REQUIRED'.tr;
		} else if(value.contains(RegExp(r'[0-9]'))) {
			return 'INVALID LAST NAME'.tr;
		}
		return null;
	}
}
