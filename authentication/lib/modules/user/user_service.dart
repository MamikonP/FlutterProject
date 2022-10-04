// ignore_for_file: avoid_dynamic_calls

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../configuration/configuration_controller.dart';
import '../../network/base_exception.dart';
import '../../network/exceptions.dart';
import '../../storage/local_storage.dart';
import '../../utils/utilities.dart';
import 'user_controller.dart';
import 'user_helper.dart';
import 'user_model.dart';

class UserService {

	final ConfigurationController _configurationController = Get.find<ConfigurationController>();
	final UserController _userController = Get.find<UserController>();
	final UserHelper _userHelper = UserHelper();
	final LocalStorage _localStorage = LocalStorage();

	Future<Map<String, dynamic>> getUserByID() async {
		final Object? value = _localStorage.getValue('userId', String);
		final String id = value != null ? value as String : '';
		final Map<String, dynamic> userData = await _userHelper.getUserByID(id);
		return userData['result'] as Map<String, dynamic>;
	}

	Future<void> _firstLogin(bool firstLogin) async {
		if (firstLogin == true) {
			_userController.firstLogin = firstLogin;
			await _userHelper.firstLogin();
		}
	}

	Future<void> updateLocalData() async {
		final Map<String, dynamic> userData = await getUserByID();
		_userController.user = User.fromJson(userData);
		await _userController.getUserData();
	}

	Future<void> login(String email, String password, String captcha) async {
		try {
			final Map<String, dynamic> loginData = await _userHelper.
				login(email, password, captcha);
			final Map<String, dynamic> data = loginData['result'] as Map<String, dynamic>;
			_userController.updateUserData(data);
			await updateLocalData();
			await _firstLogin(data['firstLogin'] as bool);
		} on BackendException catch (error) {
			final Map<String, dynamic> message = error.message;
			if (message['type'] == 'INVALID_CREDENTIALS') {
				throw BaseAppException(message: 'INVALID CREDENTIALS'.tr);
			}
			throw BaseAppException(message: message['message'] as String);
		}
		
	}

	Future<void> register(Map<String, dynamic> registerData) async {
		try {
			await _userHelper.register(registerData);
		} on BackendException catch (error) {
			final Map<String, dynamic> message = error.message;
			if (message['type'] == 'EMAIL_IN_USE') {
				throw BaseAppException(message: 'USER ALREADY EXISTS'.tr);
			}
			throw BaseAppException(message: message['message'] as String);
		}
	}

	Future<void> resetPassword(String email, String password, String captcha) async {
		try {
			await _userHelper.resetPassword(email, password, captcha);		  
		} on BackendException catch (error) {
			final Map<String, dynamic> message = error.message;
			if (message['type'] == 'USER_NOT_FOUND') {
				throw BaseAppException(message: 'USER NOT FOUND'.tr);
			}
			throw BaseAppException(message: error.message['message'] as String);
		}
	}

	Future<void> signInWithGoogle() async {
		final GoogleSignInAuthentication? authentication = await _userHelper.getGoogleAuthentication(
			_configurationController.isIOS,
			clientId: _configurationController.config['reCaptcha']['clientID'].toString()
		);
		if (authentication == null) {
			throw BaseAppException(message: 'Google Authentication failed.');
		}
		try {
			final Map<String, dynamic> loginData = await _userHelper.signInWithGoogle(
				authentication.idToken ?? '',
				false
			);
			_userHelper.googleSignIn?.disconnect();
			final Map<String, dynamic> data = loginData['result'] as Map<String, dynamic>;
			_userController.updateUserData(data);
			if (data['isAgreeWithTerms'] == false) {
				throw BaseAppException(message: 'Terms');
			}
			await updateLocalData();
			await _firstLogin(data['firstLogin'] as bool);
		} on BackendException catch (error) {
			throw BaseAppException(message: error.message['message'] as String);
		}
		
	}

	Future<void> logout() async {
		GoogleSignIn googleSignIn;
		if (_configurationController.isIOS) {
			googleSignIn = GoogleSignIn(clientId: _configurationController.config['reCaptcha']['clientID'].toString());
		} else {
			googleSignIn = GoogleSignIn();
		}
		if (googleSignIn.currentUser != null) {
			googleSignIn.disconnect();
		}
		try {
			await _userHelper.logout();
		} on BackendException catch (error) {
			throw BaseAppException(message: error.message['message'] as String);
		}
	}
}
