part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => <Object>[];
}

class UpdateSettings extends SettingsEvent {
  const UpdateSettings(this.settingsModel);

  final Map<String, int> settingsModel;

  @override
  List<Object> get props => <Object>[settingsModel];
}
