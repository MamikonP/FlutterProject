import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'app.dart';
import 'services/notification_service.dart';
import 'utils/utilities.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Utilities().configureAppServices();
  await MobileAds.instance.initialize();
  await NotificationService().initialize();
  NotificationService.listen();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  runApp(const App());
}
