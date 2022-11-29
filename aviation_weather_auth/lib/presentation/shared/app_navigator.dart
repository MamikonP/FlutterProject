import 'package:flutter/material.dart';

import '../pages/app_change_password_page.dart';
import '../pages/app_edit_profile_page.dart';
import '../pages/app_forgot_password_page.dart';
import '../pages/app_home_page.dart';
import '../pages/app_login_page.dart';
import '../pages/app_register_page.dart';
import '../pages/app_reset_password_page.dart';

class AppNavigator {
  Map<String, Widget Function(BuildContext)> get routes =>
      <String, Widget Function(BuildContext)>{
        '/': (BuildContext context) => AppHomePage(),
        '/login': (BuildContext context) => const AppLoginPage(),
        '/register': (BuildContext context) => const AppRegisterPage(),
        '/forgot-password': (BuildContext context) => const AppForgotPasswordPage(),
        '/reset-password': (BuildContext context) => const AppResetPasswordPage(),
        '/edit-profile': (BuildContext context) => AppEditProfilePage(),
        '/change-password': (BuildContext context) => AppChangePasswordPage(),
      };

  static String currentScreen(BuildContext context) =>
      ModalRoute.of(context)?.settings.name ?? '/';

  static Future<T?> toNamed<T>(BuildContext context, String route,
      {Object? args}) async {
    return Navigator.pushNamed(context, route, arguments: args);
  }

  static void pop<T>(BuildContext context, [T? result]) {
    return Navigator.pop(context, result);
  }

  static void popUntil<T>(BuildContext context, String predicate) {
    return Navigator.popUntil(context, ModalRoute.withName(predicate));
  }
}
