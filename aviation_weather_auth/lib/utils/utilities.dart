import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';

class Utilities {
  static final bool isAndroidPlatform = Platform.isAndroid;
  static final bool isIOSPlatform = Platform.isIOS;

  String convertToSha256(String input) {
    final List<int> bytes = utf8.encode(input);
    final Digest digest = sha256.convert(bytes);
    return digest.toString();
  }
}
