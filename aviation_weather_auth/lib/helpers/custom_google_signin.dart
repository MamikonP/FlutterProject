import 'package:google_sign_in/google_sign_in.dart';

class CustomGoogleSignIn {
  factory CustomGoogleSignIn() {
      instance.googleSignIn ??= GoogleSignIn();
    return instance;
  }

  CustomGoogleSignIn._internal();
  static final CustomGoogleSignIn instance = CustomGoogleSignIn._internal();

  GoogleSignIn? googleSignIn;
}
