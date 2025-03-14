import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class FCMService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static const _androidChannel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  static final _localNotifications = FlutterLocalNotificationsPlugin();

  static const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true);

  static Future setUpFCM() async {
    tz.initializeTimeZones();
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    var initializationSettingsAndroid =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    final initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin);

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) async {
        if (details.notificationResponseType ==
            NotificationResponseType.selectedNotification) {}
      },
    );

    if (defaultTargetPlatform == TargetPlatform.android) {
      await _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(_androidChannel);
    }

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    messaging.onTokenRefresh.listen((token) async {
      // update lại token trên db
    });

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessageOpenApp);
    FirebaseMessaging.onMessage.listen(handleOnMessage);
  }
  static final location = tz.getLocation('Asia/Ho_Chi_Minh');
  static Future<void> scheduleNotification(
      int id, String title, String body, DateTime scheduledTime) async {

    await _localNotifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, location),
      NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
          ),
          iOS: const DarwinNotificationDetails()),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }

  static Future<void> scheduleNotificationEveryDay(String title, String body, DateTime scheduledTime) async {

    await _localNotifications.zonedSchedule(
      0,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, location),
      NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChannel.id,
          _androidChannel.name,
          channelDescription: _androidChannel.description,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      matchDateTimeComponents: DateTimeComponents.time, // Lặp lại mỗi ngày vào giờ đã chọn
    );
  }

  static Future handleBackgroundMessage(RemoteMessage? message) async {}

  static void handleMessageOpenApp(RemoteMessage event) {}

  static Future handleOnMessage(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;
    AndroidNotification? android = message.notification!.android;
    AppleNotification? ios = message.notification!.apple;

    if (android != null &&
        !kIsWeb &&
        defaultTargetPlatform == TargetPlatform.android) {
      _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
            ),
          ));
    }
    if (ios != null) {
      _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(iOS: DarwinNotificationDetails()));
    }
  }

  static Future<String?> getToken() async {
    String? token;
    token = await messaging.getToken().timeout(const Duration(minutes: 2));
    return token;
  }
}
