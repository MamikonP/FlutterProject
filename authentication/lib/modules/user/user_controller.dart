// ignore_for_file: avoid_dynamic_calls

import 'package:get/get.dart';
import '../../storage/local_storage.dart';
import 'user_model.dart';

enum UserVerification { started, pending, failed, verified, invalid }

class UserController extends GetxController {
	final RxString _captcha = ''.obs;
	final Rx<UserVerification> verified = UserVerification.started.obs;
	final RxString email = ''.obs;
	final RxString _responseError = ''.obs;
	final Rx<User> _user = User(
					email: '',
					firstName: '',
					lastName: '',
					userId: '',
					preferableCurrency: '',
					language: '')
			.obs;
	final LocalStorage _localStorage = LocalStorage();
	String userId = '';
	final RxBool isWithoutPassword = false.obs;
	bool firstLogin = false;

	set captcha(String newCaptcha) => _captcha.value = newCaptcha;
	String get captcha => _captcha.value;

	set user(User user) => _user.value = user;
	User get user => _user.value;

	set responseError(String error) => _responseError.value = error;
	String get responseError => _responseError.value;

	void reset() {
		captcha = '';
		verified.value = UserVerification.started;
		_responseError.value = '';
	}

	void _updateToken(String token) =>
			_localStorage.setValue('token', token, token.runtimeType);
	void _updateUserId(String userId) =>
			_localStorage.setValue('userId', userId, userId.runtimeType);

	void _getUserId() {
		final Object? value = _localStorage.getValue('userId', String);
		userId = value != null ? value as String : '';
	}

	Future<void> getUserData() async {
		_getUserId();
	}

	void updateUserData(Map<String, dynamic> data) {
		_updateToken(data['token'] as String);
		_updateUserId(data['userId'] as String);
	}

	void clearUserData() {
		final List<String> userData = <String>[
			'token',
			'userId',
		];
		userData.forEach(_localStorage.removeValue);
	}
}
