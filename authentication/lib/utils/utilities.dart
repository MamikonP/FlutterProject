import 'dart:io';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../configuration/configuration_controller.dart';
import '../modules/user/user_controller.dart';
import '../network/network_helper.dart';
import '../storage/local_storage.dart';

class Utilities {

	String getDomainNameFromUrl(String url) {
		final Uri uri = Uri.parse(url);
		return uri.host;
	}

	Future<String?> getFilePath() async {
		final Directory directory = await getTemporaryDirectory();

		if (directory == null) {
			throw MissingPlatformDirectoryException('Unable to get temporary directory');
		}

		return directory.path;
	}

	String? getToken() {
		final LocalStorage storage = LocalStorage();
		final Object? token = storage.getValue('token', String);
		return token == null ? null : token as String;
	}

	static void injectsInstancesInMemory() {
		Get.put(NetworkHelper(appBaseUrl: Get.find<ConfigurationController>().config['baseUrl'].toString()), permanent: true);
		Get.put(UserController(), permanent: true);
	}
}
