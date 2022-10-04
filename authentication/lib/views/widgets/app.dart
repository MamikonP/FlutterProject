import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configuration/configuration_binding.dart';
import '../../modules/localization/localization.dart';
import '../../shared/app_routing.dart';

class App extends StatelessWidget {

	const App({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return GetMaterialApp(
			translations: Get.find<Localization>(),
			translationsKeys: Get.find<Localization>().keys,
			locale: Get.deviceLocale,
			fallbackLocale: const Locale('en', 'US'),
			debugShowCheckedModeBanner: false,
			title: 'SkyLabs',
			theme: ThemeData(
				fontFamily: 'Mardoto'
			),
			initialRoute: '/',
			getPages: appPages,
			defaultTransition: Transition.cupertino,
			transitionDuration: const Duration(milliseconds: 200),
			initialBinding: ConfigurationBinding(),
		);
	}
}
