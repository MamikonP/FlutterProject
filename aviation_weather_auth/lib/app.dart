import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'l10n/l10n.dart';
import 'presentation/bloc/settings/theme_mode/theme_mode_bloc.dart';
import 'presentation/cubit/locale/locale_cubit.dart';
import 'presentation/shared/app_navigator.dart';
import 'presentation/widgets/styles/app_color_scheme.dart';
import 'presentation/widgets/styles/app_colors.dart';
import 'providers.dart';
import 'services/analytics_service.dart';

class App extends StatefulWidget {
  const App({
    super.key,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with AppColors {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (_, LocaleState state) {
          return _MaterialApp(state);
        },
      ),
    );
  }
}

class _MaterialApp extends StatelessWidget {
  _MaterialApp(this.mState);

  final FirebaseAnalyticsObserver firebaseAnalyticsObserver =
      FirebaseAnalyticsObserver(
    analytics: AnalyticsService().firebaseAnalytics,
  );
  final AppTheme _appTheme = AppTheme();
  final LocaleState mState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeModeBloc, ThemeModeState>(
      builder: (BuildContext context, ThemeModeState state) {
        return MaterialApp(
          darkTheme: _appTheme.darkTheme,
          theme: _appTheme.lightTheme,
          themeMode: state.themeMode,
          supportedLocales: L10n.locales,
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          locale: mState.locale,
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: AppNavigator().routes,
          navigatorObservers: <NavigatorObserver>[firebaseAnalyticsObserver],
        );
      },
    );
  }
}
