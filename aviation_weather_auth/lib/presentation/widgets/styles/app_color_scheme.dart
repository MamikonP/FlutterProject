import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme with AppColors {
  ThemeData get darkTheme => ThemeData(
        scaffoldBackgroundColor: primaryColor,
        colorScheme: AppColorScheme().colorSchemeDark,
        fontFamily: 'Lato',
      );

  ThemeData get lightTheme => ThemeData(
        scaffoldBackgroundColor: lightColor,
        colorScheme: AppColorScheme().colorSchemeLight,
        fontFamily: 'Lato',
      );
}

class AppColorScheme with AppColors {
  ColorScheme get colorSchemeLight => ColorScheme(
        primary: primaryColor,
        secondary: secondaryColor,
        background: backgroundColor,
        brightness: Brightness.light,
        error: errorColor,
        surface: secondaryColor,
        onPrimary: lightColor,
        onBackground: primaryColor,
        onError: lightColor,
        onSecondary: lightColor,
        onSurface: darkColor,
        primaryContainer: accentColor,
      );

  ColorScheme get colorSchemeDark => ColorScheme(
        primary: lightColor,
        secondary: lightColor,
        background: primaryColor,
        brightness: Brightness.dark,
        error: errorColor,
        surface: secondaryColor,
        onPrimary: primaryColor,
        onBackground: lightColor,
        onError: primaryColor,
        onSecondary: primaryColor,
        onSurface: lightColor,
        primaryContainer: accentColor,
      );
}
