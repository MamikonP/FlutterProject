import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/constants.dart';
import '../data/settings_constants.dart';
import '../services/configuration/configuration_local_storage.dart';
import '../services/configuration/configuration_network_service.dart';

class Utilities {
  static final bool isAndroidPlatform = Platform.isAndroid;
  static final bool isIOSPlatform = Platform.isIOS;
  final List<Object> _premiumAccessFields = <Object>[
    Mode.values.first,
  ];

  Future<void> configureAppServices() async {
    await ConfigurationLocalStorages().configure();
    ConfigurationNetworkService(AppConstants.BASE_URL)
        .configure();
  }

  Future<void> checkNetworkConnection(String url) async {
    final List<InternetAddress> result = await InternetAddress.lookup(url);
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return;
    }
  }

  String sha256ofString(String input) {
    final List<int> bytes = utf8.encode(input);
    final Digest digest = sha256.convert(bytes);
    return digest.toString();
  }

  Map<String, dynamic> encodeQueryParameters(Map<String, dynamic> params) {
    final Map<String, dynamic> encodedParams = <String, dynamic>{};
    params.forEach((String key, dynamic value) {
      encodedParams.addAll(<String, dynamic>{
        Uri.encodeFull(key): Uri.encodeFull(
          value.toString(),
        )
      });
    });
    return encodedParams;
  }

  Future<bool> openLink(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      return launchUrl(uri);
    }
    return false;
  }

  bool hasPremiumAccess(Object object) {
    final Object obj = _premiumAccessFields.firstWhere(
      (Object element) => element.runtimeType == object.runtimeType,
      orElse: () => '',
    );
    return obj.runtimeType != String;
  }

  String? getResponseError(dynamic e) {
    final dynamic error = jsonDecode(e.toString());
    if (error == null) {
      return null;
    }
    if (error.runtimeType == List) {
      String errorMessage = '';
      for (final Map<String, dynamic> err in error) {
        errorMessage += '${err['msg']}: ${err['param']}\n';
      }
      return errorMessage;
    }
    final Map<String, dynamic> err = error as Map<String, dynamic>;
    if (err.containsKey('message')) {
      return err['message'] as String;
    }
    return '${err['msg']}: ${err['param']}';
  }
}
