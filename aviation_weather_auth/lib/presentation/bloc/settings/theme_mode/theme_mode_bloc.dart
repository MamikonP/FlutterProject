import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_mode_event.dart';
part 'theme_mode_state.dart';

class ThemeModeBloc extends Bloc<ThemeModeEvent, ThemeModeState> {
  ThemeModeBloc(ThemeMode themeMode) : super(ThemeModeInitial(themeMode)) {
    on<UpdateTheme>((UpdateTheme event, Emitter<ThemeModeState> emit) {
      emit(ThemeModeUpdated(event.themeMode));
    });
  }
}
