import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/utilities.dart';

class AuthService extends GetxService {
	Future<AuthService> init() async => this;

	bool get isAuthenticated => _authenticated();

	bool _authenticated() {
		final Utilities utilities = Utilities();
		final String? token = utilities.getToken();
		return token != null && token != '';
	}
}

class AuthMiddleware extends GetMiddleware {
	@override
	int? get priority => 1;

	@override
	RouteSettings? redirect(String? route) {
		final AuthService authService = Get.find<AuthService>();
		return authService.isAuthenticated ? null : const RouteSettings(name: '/login');
	}

}
