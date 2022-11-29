import 'package:get_it/get_it.dart';

import '../data/data_sources/local/shared_preferences.dart';
import '../data/settings_constants.dart';

class SettingsService {
  final LocalStorage _localStorage = GetIt.instance<LocalStorage>();

  final List<String> _settings = <String>[
    Mode.name,
    MapStyle.name,
    AltitudeUnit.name,
    Temperature.name,
    WindSpeed.name,
    DistanceUnit.name,
    ClockSystem.name,
    Pressure.name,
    'Nearest Stations'
  ];

  Map<String, int> get defaultSettings {
    final Map<String, int> model = <String, int>{};
    for (final String element in _settings) {
      final int? value = _localStorage.getValue(element, int) as int?;
      model.addAll(<String, int>{element: value ?? 0});
    }
    return model;
  }
}
