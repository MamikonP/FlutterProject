part of 'theme_mode_bloc.dart';

abstract class ThemeModeEvent extends Equatable {
  const ThemeModeEvent();

  @override
  List<Object> get props => <ThemeMode>[];
}

class UpdateTheme extends ThemeModeEvent {
  const UpdateTheme(this.themeMode);

  final ThemeMode themeMode;
}
