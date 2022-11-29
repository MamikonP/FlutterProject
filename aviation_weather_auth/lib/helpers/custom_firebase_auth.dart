import 'package:firebase_auth/firebase_auth.dart';

import '../core/network/base_exception.dart';

class CustomFirebaseAuth {
  CustomFirebaseAuth({required this.onException});

  final String onException;

  Future<void> signInWithCredential(OAuthCredential? oAuthCredential) async {
    if (oAuthCredential == null) {
      throw BaseAppException(message: onException);
    }
    await FirebaseAuth.instance.signInWithCredential(oAuthCredential);
  }
}
