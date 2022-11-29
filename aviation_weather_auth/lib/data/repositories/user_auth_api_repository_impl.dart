import '../../core/network/base_exception.dart';
import '../../core/network/base_response.dart';
import '../../core/repositories/user_auth_api_repository.dart';
import '../../helpers/api/user_auth_api_helper.dart';
import '../../helpers/custom_converter.dart';
import '../models/auth/auth_response.dart';

class UserAuthAPIRepository extends CustomConverter
    implements IUserAuthAPIRepository {
  final UserAuthAPIHelper _userAuthAPIHelper = UserAuthAPIHelper();

  @override
  Future<String?> register(String email, String name, String password) async {
    final String registerData =
        await _userAuthAPIHelper.register(email, name, password);
    final AuthResponse response =
        AuthResponse.fromJson(stringToJson<Map<String, dynamic>>(registerData));
    return response.token;
  }

  @override
  Future<String?> login(String email, String password) async {
    final String loginData = await _userAuthAPIHelper.login(email, password);
    final BaseResponse<AuthResponse?> response =
        BaseResponse<AuthResponse?>.fromJson(
      stringToJson<Map<String, dynamic>>(loginData),
      (Object? data) => data == null
          ? null
          : AuthResponse.fromJson(data as Map<String, dynamic>),
    );
    if (response.success == false) {
      throw BaseAppException(message: response.message ?? 'Sign-in failed');
    }
    return response.data?.token;
  }
}
