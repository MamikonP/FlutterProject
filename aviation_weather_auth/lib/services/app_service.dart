import '../data/constants.dart';
import '../data/settings_constants.dart';
import 'configuration/configuration_local_storage.dart';
import 'configuration/configuration_network_service.dart';

class AppService {
  final List<Object> _premiumAccessFields = <Object>[
    Mode.values.first,
  ];
  
  Future<void> configureAppServices() async {
    await ConfigurationLocalStorages().configure();
    ConfigurationNetworkService(AppConstants.BASE_URL)
        .configure();
  }

  bool hasPremiumAccess(Object object) {
    final Object obj = _premiumAccessFields.firstWhere(
      (Object element) => element.runtimeType == object.runtimeType,
      orElse: () => '',
    );
    return obj.runtimeType != String;
  }
}
