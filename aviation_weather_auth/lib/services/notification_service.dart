import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> initialize() async => messaging.requestPermission();

  static Future<void> _onBackgroundMessage(RemoteMessage remoteMessage) async {
    await Firebase.initializeApp();
  }

  static Future<String?> getToken() async =>
      FirebaseMessaging.instance.getToken();

  static void listen() {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        debugPrint('${message.data}');
      },
    );

    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
  }
}
