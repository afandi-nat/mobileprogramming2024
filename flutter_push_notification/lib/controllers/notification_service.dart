import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_push_notification/controllers/auth_service.dart';
import 'package:flutter_push_notification/controllers/crud_service.dart';

import 'package:flutter_push_notification/main.dart';

class PushNotifications {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // request notification permission
  static Future init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    // get the device fcm token
    // final token = await _firebaseMessaging.getToken();
    // print("device token: $token");
  }

  static Future getDeviceToken() async {
    final token = await _firebaseMessaging.getToken();
    print("device token: $token");

    bool isUserLoggedin = await AuthService.isLoggedIn();
    if (isUserLoggedin) {
      await CRUDService.saveUserToken(token!);
      print("save to firestore");
    }
    // also save if token changes
    _firebaseMessaging.onTokenRefresh.listen((event) async {
      if (isUserLoggedin) {
        await CRUDService.saveUserToken(token!);
        print("save to firestore");
      }
    });
  }

  //initialize local notifications
  static Future localNotiInit() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    // final DarwinInitializationSettings initializationSettingsDarwin =
    //     DarwinInitializationSettings(
    //   onDidReceiveLocalNotification: (id, title, body, payload) => null,
    // );
    // const LinuxInitializationSettings initializationSettingsLinux =
    //     LinuxInitializationSettings(defaultActionName: 'Open notification');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    // iOS: initializationSettingsDarwin,
    // linux: initializationSettingsLinux);

    // request notification permissions for android 13 or above
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();

    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  }

  // on tap local notification in foreground
  static void onNotificationTap(NotificationResponse notificationResponse) {
    navigatorKey.currentState!
        .pushNamed("/message", arguments: notificationResponse);
  }

  //show a simple notification
  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('Your Channel id', 'Your Chabbel Name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }
}
