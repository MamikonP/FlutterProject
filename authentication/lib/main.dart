import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './middlewares/authentication.dart';
import 'views/widgets.dart';
import 'modules/localization/localization.dart';
import 'modules/localization/localization_service.dart';

void main() async {
	await Get.putAsync(() => AuthService().init());
	WidgetsFlutterBinding.ensureInitialized();
	Get.put(Localization());
	await LocalizationService().loadLocalizations();
	runApp(const App());
}
