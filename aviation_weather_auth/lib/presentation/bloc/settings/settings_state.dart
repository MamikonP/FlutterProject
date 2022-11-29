part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => <Object>[];
}

class SettingsInitial extends SettingsState {
  const SettingsInitial(this.settingsModel);

  final Map<String, int> settingsModel;

  @override
  List<Object> get props => <Object>[];
}

class SettingsUpdated extends SettingsState {
  const SettingsUpdated(this.settingsModel);

  final Map<String, int> settingsModel;

  @override
  List<Object> get props => <Object>[settingsModel];
}
