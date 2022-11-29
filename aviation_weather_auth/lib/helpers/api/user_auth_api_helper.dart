import '../../core/network/network_repository.dart';

class UserAuthAPIHelper {
  final NetworkRepository _networkRepository = NetworkRepository();

  Future<String> register(String email, String name, String password) async {
    return _networkRepository.request(
      endpoint: '/api/v1/auth/register',
      httpMethod: 'post',
      payload: <String, String>{
        'email': email,
        'name': name,
        'password': password,
      },
    );
  }

  Future<String> login(String email, String password) async {
    return _networkRepository.request(
      endpoint: '/api/v1/auth/login',
      httpMethod: 'post',
      payload: <String, String>{
        'email': email,
        'password': password,
      },
    );
  }
}
