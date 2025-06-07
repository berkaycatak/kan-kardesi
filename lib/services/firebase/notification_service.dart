// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kan_kardesi/models/notifications/notification_data_model.dart';
import 'package:kan_kardesi/utils/constants/global_variables/global_variables.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (kDebugMode) {
    print('Handling a background message ${message.data}');
  }
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: selectNotification,
    onDidReceiveBackgroundNotificationResponse: selectNotification,
  );
}

Future<void> selectNotification(
  NotificationResponse? response, {
  String? payload,
}) async {
  if (kDebugMode) {
    print('tıklandı');
    print(response);
  }

  NotificationDataModel notificationDataModel;
  if (response != null) {
    if (kDebugMode) {
      print(response.payload);
    }
    notificationDataModel = NotificationDataModel.fromJson(
      jsonDecode(response.payload!),
    );
  } else {
    notificationDataModel = NotificationDataModel.fromJson(
      jsonDecode(payload!),
    );
  }

  // flutterLocalNotificationsPlugin.cancelAll(); // tüm bildirimleri siliyor}
}

void initialMessageHandler(RemoteMessage message) {
  NotificationDataModel notificationDataModel = NotificationDataModel.fromJson(
    message.data,
  );

  selectNotification(null, payload: jsonEncode(message.data));
  // NotificationNavigateService _navigateService =
  //     NotificationNavigateService(notificationDataModel: notificationDataModel);
  // _navigateService.openPage();
}

final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
    StreamController<ReceivedNotification>.broadcast();

final List<DarwinNotificationCategory> darwinNotificationCategories =
    <DarwinNotificationCategory>[
  DarwinNotificationCategory(
    'standart',
  ),
];

final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
  requestAlertPermission: true,
  requestBadgePermission: true,
  requestSoundPermission: true,
  notificationCategories: darwinNotificationCategories,
);
final InitializationSettings initializationSettings = InitializationSettings(
  android: const AndroidInitializationSettings('@mipmap/launcher_icon'),
  iOS: initializationSettingsDarwin,
);

class NotificationService {
  String? fcmToken;

  Future<String?> init() async {
    await FirebaseMessaging.instance.requestPermission();
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    if (GlobalVariables.playerID != null) {
      fcmToken = GlobalVariables.playerID;
    } else {
      fcmToken = await FirebaseMessaging.instance.getToken();
    }

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    AndroidNotificationChannel standartChannel =
        const AndroidNotificationChannel(
      'standart', // id
      'Standart Notification', // title
      importance: Importance.high,
      playSound: true,
    );

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(standartChannel);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: selectNotification,
      onDidReceiveBackgroundNotificationResponse: selectNotification,
    );
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      initialMessageHandler(message);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      if (kDebugMode) {
        print('notificaiton geldi');
        print(message.data);
      }

      NotificationDataModel notificationDataModel =
          NotificationDataModel.fromJson(
        message.data,
      );

      if (Platform.isAndroid) {
        flutterLocalNotificationsPlugin.show(
          0,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'standart',
              'Standart Notification',
              icon: '@mipmap/launcher_icon',
              autoCancel: true,
              fullScreenIntent: true,
              channelShowBadge: true,
              ledOnMs: 1000,
              ledOffMs: 500,
              playSound: true,
            ),
            iOS: DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
          payload: jsonEncode(message.data),
        );
      }
    });

    return fcmToken;
  }
}

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}
