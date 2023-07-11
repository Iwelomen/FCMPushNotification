import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pushnotifi/Pages/notification.dart';
import 'package:pushnotifi/main.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
      'high_importance_channel', "High_importance_Notification",
      description: 'This channel is for important notification',
      importance: Importance.defaultImportance);
  final _localNotification = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState?.pushNamed(
      Notifications.route,
      arguments: message,
    );
  }

  Future initLocalNotification() async {
    const android = AndroidInitializationSettings('@drawable/ic_luncher');
    const settings = InitializationSettings(android: android);

    await _localNotification.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) {
        // final message = RemoteMessage.fromMap(jsonDecode());
      }
    );
  }

  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification == null) return;

      _localNotification.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@drawable/ic_luncher',
            ),
          ),
          payload: jsonEncode(message.toMap()));
    });
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    print(fcmToken);

    initPushNotification();
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    print("Title: ${message.notification?.title}");
    print("Body:  ${message.notification?.body}");
    print("Payload:  ${message.data}");
  }
}
