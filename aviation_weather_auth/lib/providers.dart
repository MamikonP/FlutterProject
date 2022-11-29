import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repositories/user_auth_api_repository_impl.dart';
import 'data/repositories/user_auth_repository_impl.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/bloc/profile/profile_bloc.dart';
import 'presentation/bloc/settings/settings_bloc.dart';
import 'presentation/bloc/settings/theme_mode/theme_mode_bloc.dart';
import 'presentation/cubit/locale/locale_cubit.dart';
import 'presentation/cubit/navigation_bar_cubit.dart';
import 'services/gallery_service.dart';
import 'services/settings_service.dart';

final List<BlocProvider<dynamic>> providers = <BlocProvider<dynamic>>[
  BlocProvider<LocaleCubit>(
    create: (BuildContext context) => LocaleCubit(),
  ),
  BlocProvider<AuthBloc>(
    create: (BuildContext context) => AuthBloc(
      UserAuthRepository(),
      UserAuthAPIRepository(),
    ),
  ),
  BlocProvider<ProfileBloc>(
    create: (BuildContext context) => ProfileBloc(GalleryService()),
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
