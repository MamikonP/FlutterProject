import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

import './base_exception.dart';
import './check_response.dart';
import '../storage/local_storage.dart';
import 'exceptions.dart';

class NetworkHelper extends GetConnect implements GetxService {

	NetworkHelper({
		required this.appBaseUrl
	});

	final String appBaseUrl;
	final CheckResponse _checkResponse = CheckResponse();

	@override
	void onInit() {
		super.onInit();

		final LocalStorage localStorage = LocalStorage();

		httpClient.baseUrl = appBaseUrl;
		httpClient.timeout = const Duration(seconds: 10);

		httpClient.addRequestModifier((Request<dynamic> request) async {
			final String? token = localStorage.getValue('token', String) as String?;

			if (token != null) {
				request.headers.addAll(<String, String> {
					'authorization': token
				});
			}

			return request;
		});

		httpClient.addResponseModifier((Request<Object?> request, Response<Object?> response) {
			_checkResponse.checkResponse(response);
			return response;
		});
	}

	Future<Response<dynamic>> _getResponse(
		String endpoint,
		String httpMethod,
		{
			Map<String, dynamic>? payload,
			Map<String, String>? headers,
		}
	) async {
		switch (httpMethod) {
			case 'get':
				return httpClient.get(endpoint, query: payload, headers: headers);
			case 'post':
				return httpClient.post(endpoint, body: payload, headers: headers);
			case 'put':
				return httpClient.put(endpoint, body: payload, headers: headers);
			case 'delete':
				return httpClient.delete(endpoint, query: payload, headers: headers);
			default:
				throw BaseAppException(message: 'Invalid HTTP method $httpMethod');
		}
	}

	Future<Response<dynamic>> doRequest(
		String endpoint, String httpMethod,
		{
			Map<String, dynamic>? payload,
			Map<String, String>? headers,
		}
	) async {
		try {
			return _getResponse(endpoint, httpMethod, payload: payload, headers: headers);
		}
		on SocketException {
			throw SocketException('NETWORK_ERROR_DESC'.tr);
		}
		on TimeoutException {
			throw TimeoutException('Timeout to execute $httpMethod request');
		}
		catch (e) {
			throw BaseAppException(message: 'NETWORK_ERROR_HEADING'.tr);
		}
	}

	GetSocket getSocket() {
		try {
			return socket('$appBaseUrl/ws');
		} on SocketException {
			throw SocketException('NETWORK_ERROR_DESC'.tr);
		} catch(e) {
			throw BaseAppException(message: e.toString());
		}
	}
}
