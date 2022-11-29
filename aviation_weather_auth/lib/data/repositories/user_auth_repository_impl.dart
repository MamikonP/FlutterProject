import 'package:firebase_auth/firebase_auth.dart';

import '../../core/network/base_exception.dart';
import '../../core/repositories/user_auth_repository.dart';
import '../../helpers/api/user_auth_helper.dart';
import '../../helpers/custom_firebase_auth.dart';
import '../constants.dart';

class UserAuthRepository implements IUserAuthRepository {
  final UserAuthHelper _userAuthHelper = UserAuthHelper();

  @override
  Future<void> googleSignIn() async {
    try {
      final OAuthCredential? authCredential =
          await _userAuthHelper.googleSignIn();
      await CustomFirebaseAuth(onException: 'Google Sign-In failed')
          .signInWithCredential(authCredential);
    } catch (e) {
      throw BaseAppException(message: e.toString());
    }
  }

  @override
  Future<void> logout(Auth? auth) async => _userAuthHelper.logout(auth);

  @override
  Future<void> facebookSignIn() async {
    try {
      final OAuthCredential? authCredential =
          await _userAuthHelper.facebookSignIn();
      await CustomFirebaseAuth(onException: 'Facebook Sign-In failed')
          .signInWithCredential(authCredential);
    } catch (e) {
      throw BaseAppException(message: e.toString());
    }
  }
  
  @override
  Future<void> appleSignIn() async {
     try {
      final OAuthCredential? authCredential =
          await _userAuthHelper.appleSignIn();
      await CustomFirebaseAuth(onException: 'Apple Sign-In failed')
          .signInWithCredential(authCredential);
    } catch (e) {
      throw BaseAppException(message: e.toString());
    }
  }
}
