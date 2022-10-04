import 'package:get/get.dart';

import './base_exception.dart';
import './check_response.dart';
import './network_helper.dart';
import '../configuration/configuration_controller.dart';
import '../modules/user/user_controller.dart';
import 'exceptions.dart';

class NetworkService {
	final NetworkHelper _networkHelper = Get.find<NetworkHelper>();
	final CheckResponse _checkResponse = CheckResponse();

	Map<String, dynamic>? _modifyPayload(
		String url,
		{
			Map<String, dynamic>? payload
		}
	) {
		if (payload == null) {
			return payload;
		}

		if (Get.find<ConfigurationController>().isAndroid) {
			if (payload.containsKey('captcha')) {
				payload['isAndroid'] = true;
			}
		}

		if (Get.find<ConfigurationController>().isIOS && url.endsWith('google-auth')) {
			payload['deviceType'] = 'ios';
		}

		return payload;
	}

	Future<void> _catchUnauhtorizedException() async {
		final UserController userController = Get.find<UserController>();
		userController.clearUserData();
		Get.offAllNamed('/');
	}

	Future<dynamic> request({
		required String endpoint,
		required String request,
		Map<String, dynamic>? payload,
		Map<String, String>? headers
	}) async {
		try {
			payload = _modifyPayload(endpoint, payload: payload);

			final Response<dynamic> response = await _networkHelper.doRequest(
				endpoint,
				request,
				payload: payload,
				headers: headers
			);

			if (!_checkResponse.checkOKStatus(response)) {
				throw BaseAppException(message: response.statusText ?? 'NETWORK_ERROR_HEADING'.tr);
			}

			_checkResponse.validateResponse(response);

			return response.body;
		} on BackendException catch (error) {
				if (error.message['type'] == 'ERROR_UNAUTHORIZED') {
					await _catchUnauhtorizedException();
					return;
				}
				throw BackendException(error.message);
		}	catch (e) {
			throw BaseAppException(message: e.toString());
		}
	}

	GetSocket getSocket() {
		try {
			return _networkHelper.getSocket();
		} catch(e) {
			throw BaseAppException(message: e.toString());
		}
	}
}
