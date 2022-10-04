import 'package:get/get.dart';

import './configuration_controller.dart';

class ConfigurationBinding implements Bindings {
	@override
	void dependencies() {
		Get.put(ConfigurationController(), permanent: true);
	}
}
