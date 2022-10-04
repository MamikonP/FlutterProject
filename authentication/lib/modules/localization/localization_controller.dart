import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Language{armenian, english, russian}

class LocalizationController extends GetxController {

	Future<void> changeLanguage(Language language) async {
		Locale locale = const Locale('en', 'US');
		switch (language) {
			case Language.armenian:
				locale = const Locale('hy', 'AM');
				break;
			case Language.english:
				locale = const Locale('en', 'US');
				break;
			case Language.russian:
				locale = const Locale('ru', 'RU');
				break;
		}
		await Get.updateLocale(locale);
	}
}
