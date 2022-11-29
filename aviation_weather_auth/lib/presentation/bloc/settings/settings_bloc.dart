import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/settings_constants.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(this._currentSettings) : super(SettingsInitial(_currentSettings)) {
    on<UpdateSettings>(_onUpdateSettings);
  }

  Map<String, int> _currentSettings;

  Map<String, int> get currentSettings => _currentSettings;

  Map<String, dynamic> toggles = <String, dynamic>{
    Mode.name : Mode.values,
    'Nearest Stations': <int>[0, 10],
    MapStyle.name: MapStyle.values,
    Pressure.name: Pressure.values,
    AltitudeUnit.name: AltitudeUnit.values,
    Temperature.name: Temperature.values,
    WindSpeed.name: WindSpeed.values,
    DistanceUnit.name: DistanceUnit.values,
    ClockSystem.name: ClockSystem.values,
  };

  FutureOr<void> _onUpdateSettings(
      UpdateSettings event, Emitter<SettingsState> emit) async {
    emit(SettingsUpdated(event.settingsModel));
    _currentSettings = event.settingsModel;
  }
}
