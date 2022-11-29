import 'package:get_it/get_it.dart';

import '../../core/network/network_helper.dart';
import '../../core/services/base_configuration_service.dart';


class ConfigurationNetworkService extends BaseConfigurationService {
  ConfigurationNetworkService(this.url);

  final String url;

  @override
  void configure() {
    GetIt.instance.registerSingleton<NetworkHelper>(
      NetworkHelper(baseUrl: url),
    );
  }
}
