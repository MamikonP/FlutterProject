part of 'theme_mode_bloc.dart';

abstract class ThemeModeState extends Equatable {
  const ThemeModeState(this.themeMode);

  final ThemeMode themeMode;

  @override
  List<Object> get props => <Object>[themeMode];
}

class ThemeModeInitial extends ThemeModeState {
  const ThemeModeInitial(ThemeMode themeMode) : super(themeMode);
}

class ThemeModeUpdated extends ThemeModeState {
  const ThemeModeUpdated(ThemeMode themeMode) : super(themeMode);
}
