import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talkangels/const/app_routes.dart';
import 'package:talkangels/ui/angels/utils/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();

  NotificationService().requestPermissions();

  NotificationService().getFCMToken();
  FirebaseMessaging.onBackgroundMessage(
      NotificationService.firebaseMessagingBackgroundHandler);

  await NotificationService.flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(NotificationService().channel);

  NotificationService.getInitialMsg();

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  NotificationService.showMsgHandler();

  final InitializationSettings initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
  );

  NotificationService.onMsgOpen();
  NotificationService.flutterLocalNotificationsPlugin
      .initialize(initializationSettings, onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
    log('notificationResponse----- ${notificationResponse.payload}');
  });

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Talk Angels',
      initialRoute: Routes.splashScreen,
      getPages: Routes.routes,
    );
  }
}

/// auth. cancelled
// OtplessResponse{errorMessage='user cancelled', data=null}

/// whatsapp login response

Map codelineData = {
  "token": "4ae6b82ed6ab49b8a4600b7042e24030",
  "timestamp": "2024-01-05 19:22:43",
  "timezone": "+05:30",
  "mobile": {
    "name": "Codeline Infotech LLP",
    "number": "918155017575",
  },
  "waNumber": "918155017575",
  "waName": "Codeline Infotech LLP",
};

///console
// ChannelProxy::onConnected->onJoinChannelSuccess(this:0xb4000073c637e400, channel:"demo", uid:"951062463", elapsed:2167, reason:1)
// RtcConnectionImpl::connect(this:0xb400007341862500, token:"0****=", channelId:"demo", userId:"951062463")
