import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repositories/user_auth_api_repository_impl.dart';
import 'data/repositories/user_auth_repository_impl.dart';
import 'data/repositories/user_repository_impl.dart';
import 'presentation/bloc/settings/settings_bloc.dart';
import 'presentation/bloc/settings/theme_mode/theme_mode_bloc.dart';
import 'presentation/bloc/user/user_bloc.dart';
import 'presentation/bloc/user_auth/user_auth_bloc.dart';
import 'presentation/cubit/locale/locale_cubit.dart';
import 'presentation/cubit/navigation_bar_cubit.dart';
import 'services/settings_service.dart';

final List<BlocProvider<dynamic>> providers = <BlocProvider<dynamic>>[
  BlocProvider<LocaleCubit>(
    create: (BuildContext context) => LocaleCubit(),
  ),
  BlocProvider<UserAuthBloc>(
    create: (BuildContext context) => UserAuthBloc(
      UserAuthRepository(),
      UserAuthAPIRepository(),
    ),
  ),
  BlocProvider<UserBloc>(
    create: (BuildContext context) => UserBloc(UserRepository()),
  ),
  BlocProvider<NavigationBarCubit>(
    create: (BuildContext context) => NavigationBarCubit(),
  ),
  BlocProvider<SettingsBloc>(
    create: (BuildContext context) =>
        SettingsBloc(SettingsService().defaultSettings),
  ),
  BlocProvider<ThemeModeBloc>(
    create: (BuildContext context) => ThemeModeBloc(
      SettingsService().defaultSettings['Mode'] == 0
          ? ThemeMode.light
          : ThemeMode.dark,
    ),
  ),
];
