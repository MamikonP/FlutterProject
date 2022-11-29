import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

class SecureStorage {
  factory SecureStorage({required FlutterSecureStorage secureStorage}) {
    return SecureStorage._(secureStorage);
  }

  SecureStorage._(this.secureStorage);

  final FlutterSecureStorage secureStorage;

  Future<void> writeData(String key, String value) async =>
      secureStorage.write(key: key, value: value);

  Future<String?> readData(String key) async => secureStorage.read(key: key);

  Future<void> deleteData(String key) async => secureStorage.delete(key: key);

  Future<void> clearStorage() async => secureStorage.deleteAll();

  static Future<void> saveToken(String token) async =>
    GetIt.instance<SecureStorage>().writeData('token', token);

  static Future<String?> getToken() async =>
      GetIt.instance<SecureStorage>().readData('token');
}
