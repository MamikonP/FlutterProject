import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import '../configuration/configuration_binding.dart';
import '../modules/user/user_authorization_binding.dart';
import '../modules/user/user_binding.dart';
import '../views/pages/app_home_page.dart';
import '../views/pages/app_login_page.dart';
import '../views/pages/app_register_page.dart';
import '../views/pages/app_reset_password_page.dart';


final List<Bindings> rootBindings = <Bindings> [
	UserAuthorizationBinding(),
];

final List<GetPage<dynamic>> appPages = <GetPage<dynamic>>[

	GetPage<dynamic>(
		name: '/',
		page: () => AppHomePage(),
		bindings: rootBindings,
	),

	GetPage<dynamic>(
		name: '/login',
		page: () => const AppLoginPage(),
		bindings: <Bindings> [
			UserBinding(),
			UserAuthorizationBinding(),
			ConfigurationBinding(),
		]
	),

	GetPage<dynamic>(
		name: '/register',
		page: () => const AppRegisterPage(),
		bindings: <Bindings>[
			UserAuthorizationBinding()
		]
	),

	GetPage<dynamic>(
		name: '/reset-password',
		page: () => const AppResetPasswordPage(),
		bindings: <Bindings>[
			UserAuthorizationBinding(),
		],
	),
];
