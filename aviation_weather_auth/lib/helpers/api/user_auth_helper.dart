import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../data/constants.dart';
import '../../utils/utilities.dart';
import '../custom_google_signin.dart';

class UserAuthHelper {
  Future<OAuthCredential?> googleSignIn() async {
    final CustomGoogleSignIn customGoogleSignIn = CustomGoogleSignIn();
    final GoogleSignInAccount? account =
        await customGoogleSignIn.googleSignIn?.signIn();
    if (account != null) {
      final GoogleSignInAuthentication authentication =
          await account.authentication;
      final OAuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      );
      return authCredential;
    }
    return null;
  }

  Future<void> logout(Auth? auth) async {
    await FirebaseAuth.instance.signOut();
    switch (auth) {
      case Auth.google:
        await CustomGoogleSignIn.instance.googleSignIn?.disconnect();
        break;
      case Auth.facebook:
        final Map<String, dynamic> userData =
            await FacebookAuth.instance.getUserData();
        if (userData != null && userData.isNotEmpty) {
          await FacebookAuth.instance.logOut();
        }
        break;
      case Auth.apple:
        return;
      case null:
        return;
    }
  }

  Future<OAuthCredential?> facebookSignIn() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    if (loginResult.accessToken != null) {
      final OAuthCredential authCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      return authCredential;
    }
    return null;
  }

  Future<OAuthCredential?> appleSignIn() async {
    final String rawNonce = generateNonce();
    final String nonce = Utilities().sha256ofString(rawNonce);
    final AuthorizationCredentialAppleID credentialAppleID =
        await SignInWithApple.getAppleIDCredential(
            scopes: <AppleIDAuthorizationScopes>[
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName
        ],
            nonce: nonce);
    final OAuthCredential authCredential = OAuthProvider('apple.com')
        .credential(
            idToken: credentialAppleID.identityToken, rawNonce: rawNonce);
    return authCredential;
  }
}
