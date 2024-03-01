import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:quranku/core/utils/extension/string_ext.dart';
import 'package:quranku/core/utils/local_notification.dart';

import '../../injection.dart';

Future<void> initializeFCM() async {
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  await FirebaseMessaging.instance.requestPermission();
  final fcmToken = await FirebaseMessaging.instance.getToken();
  if (kDebugMode) {
    print('FCM Token: $fcmToken');
  }
}

void configureFCMListeners() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // Handle incoming data message when the app is in the foreground
    if (kDebugMode) {
      print("Data message received: ${message.data}");
    }
    sl<LocalNotification>().show(
      title: message.notification?.title ?? emptyString,
      body: message.notification?.body ?? emptyString,
      payload: message.data.toString(),
    );
  });
}

Future<void> backgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print("Handling background message: ${message.data}");
  }
  sl<LocalNotification>().show(
    title: message.notification?.title ?? emptyString,
    body: message.notification?.body ?? emptyString,
    payload: message.data.toString(),
  );
}
