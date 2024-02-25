import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:quranku/core/utils/pair.dart';

@Singleton()
class LocalNotification {
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse,
    ) async {
      final String? payload = notificationResponse.payload;
      if (notificationResponse.payload != null) {
        log('notification payload: $payload');
      }
      // await Navigator.push(
      //   context,
      //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
      // );
    }

    const initSettingsAndroid =
        AndroidInitializationSettings('ic_launcher_round');
    const initSettingsDarwin = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsDarwin,
      macOS: initSettingsDarwin,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  Future<void> show({
    required String title,
    required String body,
    String? payload,
    Pair<String, String>? channel,
  }) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channel?.first ?? 'high_importance_channel',
      channel?.second ?? 'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const iosPlatformChannelSpecifics = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics,
    );
    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      payload: payload,
      platformChannelSpecifics,
    );
  }
}
