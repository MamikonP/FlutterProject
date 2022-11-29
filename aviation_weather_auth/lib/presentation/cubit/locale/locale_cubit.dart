import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit()
      : super(
          LocaleUpdated(
            Locale(Platform.localeName.split('_')[0]),
          ),
        );

  void onUpdateLocale(Locale locale) => emit(LocaleUpdated(locale));
}
