import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:talkangels/const/shared_prefs.dart';

class NotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      // 'This channel is used for important notifications.', // description
      importance: Importance.max,
      playSound: true,
      sound:
          RawResourceAndroidNotificationSound('assets/sound/audio_dummy.wav'));
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  requestPermissions() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  getFCMToken() async {
    String? token = await messaging.getToken();

    PreferenceManager().setFCMNotificationToken(token!);

    log("TOKEN $token");
  }

  /// notification handler..
  static void showMsgHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      RemoteNotification? notification = message!.notification;
      AndroidNotification? android = message.notification?.android;

      log("data=====  >    ${message.data}");
      log("image=====  >    ${message.data["image"]}");
      log("name=====  >    ${message.data["name"]}");
      log("channelName=====  >    ${message.data["channelName"]}");
      log("_id=====  >    ${message.data["_id"]}");
      log("mobile_number=====  >    ${message.data["mobile_number"]}");
      log("agora_tokenL=====  >    ${message.data["agora_token"]}");

      log('Notification Call :${message.notification?.android}  ${notification!.title}  ${notification.body}  ${notification.bodyLocKey}  ${notification.bodyLocArgs}');
      // FlutterRingtonePlayer.stop();
      showMsg(notification);
    });
  }

  /// handle notification when app in fore ground..///close app
  static void getInitialMsg() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      // if (message != null) {
      //  FlutterRingtonePlayer.stop();
      // _singleListingMainTrailController.setSlugName(
      //     slugName: '${message?.data['slug_name']}');
      // }
    });
  }

  ///show notification msg
  static void showMsg(RemoteNotification notification) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      '${notification.title}',
      '${notification.body}',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel', // id
          'High Importance Notifications', // title
          //'This channel is used for important notifications.',
          // description
          importance: Importance.high,
          icon: '@mipmap/ic_launcher',
        ),
        // iOS: DarwinNotificationDetails(),
      ),
    );
  }

  ///background notification handler..
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    log('Handling a background message ${message.data}');
    RemoteNotification? notification = message.notification;
  }

  ///call when click on notification back
  static void onMsgOpen() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('A new onMessageOpenedApp event was published!');
      log('listen->${message.data}');
    });
  }
}
