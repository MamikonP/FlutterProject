import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  final FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;

  Future<void> logEvent(String name) async {
    await firebaseAnalytics.logEvent(
      name: name,
      parameters: <String, dynamic>{},
    );
  }

  Future<void> setCurrentScreen(String currentScreen) async {
    await firebaseAnalytics.setCurrentScreen(
      screenName: currentScreen,
    );
  }

  Future<void> logScreenView(String screnClass, String screenName) async {
    await firebaseAnalytics.logScreenView(
      screenClass: screnClass,
      screenName: screenName,
    );
  }
}
