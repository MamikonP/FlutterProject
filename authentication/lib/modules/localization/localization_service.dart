import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'localization.dart';

class LocalizationService {
	Future<Map<String, dynamic>?> _loadLocalization(String localeName) async {
		try {
			final String data = await rootBundle.loadString('assets/files/localizations/$localeName.json');
			return jsonDecode(data) as Map<String, dynamic>;
		} catch (e) {
			return null;
		}
	}

	Future<void> loadLocalizations() async {
		final Map<String, dynamic> locales = <String, dynamic>{};
		final List<String> localesName = <String>['hy', 'en', 'ru'];
		for (final String localeName in localesName) {
			final Map<String, dynamic>? data = await _loadLocalization(localeName);
			if (data != null) {
				locales.addAll(data);
			}
		}
		final Map<String, Map<String, String>> allLocales = <String, Map<String, String>>{};
		locales.forEach((String key, dynamic value) {
			final Map<String, dynamic> values = value as Map<String, dynamic>;
			allLocales[key] = values.map((String key, dynamic value) => 
				MapEntry<String, String>(key, value.toString()));
		});
		Get.find<Localization>().locales = allLocales;
	}
}
