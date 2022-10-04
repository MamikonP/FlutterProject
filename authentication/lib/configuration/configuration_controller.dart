import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigurationController extends GetxController {

	final RxMap<String, dynamic> _config = <String, dynamic>{}.obs;
	final RxBool isLoaded = false.obs;
	late SharedPreferences sharedPreferences;
	final bool isAndroid = Platform.isAndroid;
	final bool isIOS = Platform.isIOS;

	Future<void> _loadConfigFile() async {
		final String response = await rootBundle.loadString('assets/files/config.json');
		_config.assignAll(jsonDecode(response) as Map<String, dynamic>);
	}

	Future<void> _initializeLocalStorage() async {
		sharedPreferences = await SharedPreferences.getInstance();
	}

	@override
	void onInit() {
		super.onInit();
		_loadConfigFile().then((dynamic value) async {
			await _initializeLocalStorage();
			isLoaded.value = true;
		});
	}

	Map<String, dynamic> get config => _config.value;
}
