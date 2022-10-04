import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../configuration/configuration_controller.dart';

class LocalStorage {

	LocalStorage() {
		final ConfigurationController configurationController = Get.find<ConfigurationController>();
		_sharedPreferences = configurationController.sharedPreferences;
	}

	late SharedPreferences _sharedPreferences;

	Object? getValue(String key, Object expectedType) {
		switch (expectedType) {
			case bool:
				return _sharedPreferences.getBool(key);
			case String:
				return _sharedPreferences.getString(key);
			case double:
				return _sharedPreferences.getDouble(key);
			case int:
				return _sharedPreferences.getInt(key);
			case List<String>:
				return _sharedPreferences.getStringList(key);
		}
		return null;
	}

	void setValue(String key, Object value, Object expectedType) {
		switch (expectedType) {
			case bool:
				_sharedPreferences.setBool(key, value as bool);
				break;
			case String:
				_sharedPreferences.setString(key, value as String);
				break;
			case double:
				_sharedPreferences.setDouble(key, value as double);
				break;
			case int:
				_sharedPreferences.setInt(key, value as int);
				break;
			case List<String>:
				_sharedPreferences.setStringList(key, value as List<String>);
				break;
		}
	}

	void removeValue(String key) => _sharedPreferences.remove(key);
}
