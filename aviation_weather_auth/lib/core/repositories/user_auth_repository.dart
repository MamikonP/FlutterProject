import '../../data/constants.dart';

abstract class IUserAuthRepository {
  Future<void> googleSignIn();
  Future<void> logout(Auth? auth);
  Future<void> facebookSignIn();
  Future<void> appleSignIn();
}
