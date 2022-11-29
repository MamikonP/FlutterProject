import 'dart:io';

class ReachabilityService {
  Future<void> checkNetworkConnection(String url) async {
    final List<InternetAddress> result = await InternetAddress.lookup(url);
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return;
    }
  }
}
