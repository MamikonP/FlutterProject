import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../network/network_service.dart';

class UserHelper {
	final NetworkService _networkService = NetworkService();
	late GoogleSignIn? googleSignIn;

	Future<Map<String, dynamic>> getUserByID(String userId) async {
		return await _networkService
			.request(
				endpoint: 'api/user/$userId',
				request: 'get',
			) as Map<String, dynamic>;
	}

	Future<GoogleSignInAuthentication?> getGoogleAuthentication(bool iosPlatform,
			{String? clientId}) async {
		if (iosPlatform){
			googleSignIn = GoogleSignIn(clientId: clientId);
		} else {
			googleSignIn = GoogleSignIn();
		}
		final GoogleSignInAccount? account = await googleSignIn!.signIn();
		return account?.authentication;
	}

	Future<Map<String, dynamic>> login(String email, String password, String captcha) async {
		return await _networkService
			.request(
				endpoint: 'api/auth/login',
				request: 'post',
				payload: <String, dynamic>{
					'email': email,
					'password': password,
					'captcha': captcha,
				}
			) as Map<String, dynamic>;
	}

	Future<Map<String, dynamic>> firstLogin() async {
		return await _networkService
			.request(
				endpoint: 'api/user/first-login',
				request: 'post',
			) as Map<String, dynamic>;
	}

	Future<Map<String, dynamic>> register(Map<String, dynamic> registerData) async {
		return await _networkService.request(
			endpoint: 'api/user/register',
			request: 'post',
			payload: registerData
		) as Map<String, dynamic>;
	}

	Future<Map<String, dynamic>> resetPassword(String email, String password, String captcha) async {
		return await _networkService.request(
			endpoint: 'api/auth/forgot',
			request: 'post',
			payload: <String, dynamic>{
				'email': email,
				'password': password,
				'captcha': captcha
			}
		) as Map<String, dynamic>;
	}

	Future<Map<String, dynamic>> signInWithGoogle(String idToken, bool isAgreeWithTerms) async {
		return await _networkService.request(
				endpoint: 'api/auth/google-auth',
				request: 'post',
				payload: <String, dynamic>{
					'idToken': idToken,
					'isAgreeWithTerms': isAgreeWithTerms
				}
			) as Map<String, dynamic>;
	}

	Future<Map<String, dynamic>> generateTFA() async {
		return await _networkService.request(
			endpoint: 'api/tfa/generate',
			request: 'post'
		) as Map<String, dynamic>;
	}

	Future<Map<String, dynamic>> verifyTFA(String pinCode) async {
		return await _networkService.request(
			endpoint: 'api/tfa/verify',
			request: 'post',
			payload: <String, String>{
				'token': pinCode
			}
		) as Map<String, dynamic>;
	}

	Future<Map<String, dynamic>> disableTFA(String pinCode) async {
		return await _networkService.request(
			endpoint: 'api/tfa/disable',
			request: 'post',
			payload: <String, String>{
				'token': pinCode
			}
		) as Map<String, dynamic>;
	}

	Future<Map<String, dynamic>> confirmAuthorization(String authorizationToken) async {
		return await _networkService.request(
			endpoint: 'api/confirm-authorization',
			request: 'post',
			payload: <String, String>{
				'authorizationToken': authorizationToken
			}
		) as Map<String, dynamic>;
	}

	Future<Map<String, dynamic>> logout() async {
		return await _networkService.request(
			endpoint: 'api/auth/logout',
			request: 'post'
		) as Map<String, dynamic>;
	}

	Future<Map<String, dynamic>> editProfile(String id, String firstName, String lastName) async {
		return await _networkService.request(
			endpoint: 'api/user/$id',
			request: 'put',
			payload: <String, dynamic> {
				'id': id,
				'firstName': firstName,
				'lastName': lastName,
			}
		) as Map<String, dynamic>;
	}

	Future<Map<String, dynamic>> changePassword(String newPassword, String oldPassword) async {
		return await _networkService.request(
			endpoint: 'api/auth/change-password',
			request: 'post',
			payload: <String, dynamic> {
				'newPassword': newPassword,
				'oldPassword': oldPassword,
			}
		) as Map<String, dynamic>;
	}

	Future<Map<String, dynamic>> createPassword(String newPassword) async {
		return await _networkService.request(
			endpoint: 'api/auth/create-password',
			request: 'post',
			payload: <String, dynamic> {
				'password': newPassword,
			}
		) as Map<String, dynamic>;
	}

	Future<Map<String, dynamic>> deactivateAccountWithEmail(
			String userId, String? explainMessage) async {
		return await _networkService.request(
			endpoint: 'api/send-deactivation-email/$userId',
			request: 'post',
			payload: explainMessage == null ? null : <String, dynamic>{
				'explainMessage': explainMessage
			}
		) as Map<String, dynamic>;
	}

	Future<Map<String, dynamic>> deactivateAccount(
			String userId, String passwordOrTFA, String? explainMessage) async {
		final Map<String, dynamic> deactivateData = <String, dynamic>{
			'passwordOrTFA': passwordOrTFA
		};
		deactivateData.addIf(explainMessage != null, 'explainMessage', explainMessage);
		return await _networkService.request(
			endpoint: 'api/user/deactivate/$userId',
			request: 'put',
			payload: deactivateData
		) as Map<String, dynamic>;
	}

	Future<Map<String, dynamic>> changePreferableCurrency(String userId, String preferableCurrency) async {
		return await _networkService.request(
			endpoint: 'api/user/$userId',
			request: 'put',
			payload: <String, dynamic> {
				'id': userId,
				'preferableCurrency': preferableCurrency,
			}
		) as Map<String, dynamic>;
	}

	Future<Map<String, dynamic>> updateLanguage(String userId, String language) async {
		return await _networkService.request(
			endpoint: 'api/user/$userId',
			request: 'put',
			payload: <String, dynamic> {
				'id': userId,
				'lang': language
			}
		) as Map<String, dynamic>;
	}

	Future<Map<String, dynamic>> acceptTerms(bool isAgreeWithTerms) async {
		return await _networkService.request(
			endpoint: 'api/user/accept-terms',
			request: 'post',
			payload: <String, dynamic> {
				'isAgreeWithTerms': isAgreeWithTerms,
			}
		) as Map<String, dynamic>;
	}
}
