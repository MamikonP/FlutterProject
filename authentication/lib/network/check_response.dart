// ignore_for_file: avoid_dynamic_calls

import 'package:get/get_connect.dart';

import './exceptions.dart';

class CheckResponse {

	void validateResponse(Response<dynamic> response) {
		if (
			response.body.containsKey('status') == true &&
			response.body['status'] == false
		) {
			throw BackendException(response.body as Map<String, dynamic>);
		}
	}

	void checkResponse(Response<dynamic> response) {
		if (response.statusCode! >= 200 && response.statusCode! <= 308) {
			return;
		}

		switch (response.statusCode) {
			case 400:
				throw BadRequestException();
			case 401:
				throw UnauthorizedException();
			case 403:
				throw ForbiddenException();
			case 404:
				throw NotFoundException();
			case 409:
				throw ConflictException();
			case 500:
				throw InternalServerException();
			case 502:
				throw BadGateWayException();
			default:
				throw InvalidException(statusCode: response.statusCode!);
		}
	}

	bool checkOKStatus(Response<dynamic> response) {
		return response.statusText == 'OK' || response.statusCode == 200;
	}
}
