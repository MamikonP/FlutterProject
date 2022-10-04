import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configuration/configuration_controller.dart';
import '../../modules/user/user_controller.dart';
import '../../modules/user/user_model.dart';
import '../../modules/user/user_service.dart';
import '../../utils/utilities.dart';
import '../widgets/app_loading.dart';

class AppHomePage extends StatelessWidget {
	AppHomePage({Key? key}) : super(key: key);

	final ConfigurationController _configurationController = Get.find<ConfigurationController>();

	Widget getStarted() {
		final Utilities utilities = Utilities();
		final String? token = utilities.getToken();
		if (token == null || token == '') {
			Future<dynamic>.microtask(() => Get.offAndToNamed('/login'));
			return const AppLoading(hasBackground: true,);
		}
		final UserService userService = UserService();
		return FutureBuilder<Map<String, dynamic>>(
			future: userService.getUserByID(),
			builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
				if (snapshot.hasError) {
					Future<dynamic>.microtask(() => Get.offAndToNamed('/login'));
					return const AppLoading(hasBackground: true,);
				}
				if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
					Future<dynamic>.microtask(() => (){})
						.then((dynamic value) async {
							final UserController userController = Get.find<UserController>();
							userController.user = User.fromJson(snapshot.data!);
							await userController.getUserData();
							Future<dynamic>.microtask(() => Get.offAndToNamed('/login'));
						}
					);
					return const AppLoading(hasBackground: true,);
				}
				return const AppLoading(hasBackground: true,);
			},
		);
	}

	@override
	Widget build(BuildContext context) {
		return Obx(() {
			if (! _configurationController.isLoaded.value) {
				return const Scaffold(
					body: AppLoading()
				);
			}
			Utilities.injectsInstancesInMemory();
			return getStarted();
		});
	}
}
