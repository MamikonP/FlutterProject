import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/services/base_configuration_service.dart';
import '../../data/data_sources/local/secure_storage.dart';
import '../../data/data_sources/local/shared_preferences.dart';

class ConfigurationLocalStorages extends BaseConfigurationService {
  @override
  Future<void> configure() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    GetIt.instance.registerLazySingleton<LocalStorage>(
      () => LocalStorage(preferences: sharedPreferences),
    );
    GetIt.instance.registerLazySingleton<SecureStorage>(
      () => SecureStorage(secureStorage: secureStorage),
    );
  }
}
