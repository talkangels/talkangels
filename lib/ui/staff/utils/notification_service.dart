import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_callkit_incoming/entities/entities.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:talkangels/const/app_routes.dart';
import 'package:talkangels/const/shared_prefs.dart';
import 'package:talkangels/ui/angels/main/home_pages/calling_screen_controller.dart';
import 'package:talkangels/ui/staff/main/calling_pages/calling_screen.dart';
import 'package:talkangels/ui/staff/main/home_pages/home_controller.dart';
import 'package:uuid/uuid.dart';

class NotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static HomeController homeController = Get.put(HomeController());

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
      // log("data=====  >    ${message.data}");
      // log("image=====  >    ${message.data["image"]}");
      // log("name=====  >    ${message.data["name"]}");
      // log("channelName=====  >    ${message.data["channelName"]}");
      // log("_id=====  >    ${message.data["_id"]}");
      // log("mobile_number=====  >    ${message.data["mobile_number"]}");
      // log("agora_tokenL=====  >    ${message.data["agora_token"]}");
      log("messaha"
          "ge.data---->${message.data}");
      log("PreferenceManager().getRole()--------------> ${PreferenceManager().getRole()}");

      if (message.data['call_type'] == "reject") {
        if (PreferenceManager().getRole() == 'staff') {
          FlutterCallkitIncoming.endAllCalls();
        } else {
          CallingScreenController callingScreenController =
              Get.put(CallingScreenController());

          callingScreenController.leaveChannel();
          Get.back();
        }
        log("reject--------------> ");
      } else if (message.data['call_type'] == "calling") {
        callHandle(message);
        showCallkitIncoming(Uuid().v4(), message);
      }

      log('Notification Call :${message.notification?.android}  ${notification!.title}  ${notification.body}  ${notification.bodyLocKey}  ${notification.bodyLocArgs}');
      // FlutterRingtonePlayer.stop();
      // showMsg(notification);
    });
  }

  static callHandle(RemoteMessage message) {
    FlutterCallkitIncoming.onEvent.listen((CallEvent? event) async {
      switch (event!.event) {
        case Event.actionCallIncoming:
          log("actionCallIncoming----?}");
          // TODO: received an incoming call
          break;
        case Event.actionCallStart:
          log("actionCallStart----?}");
          // TODO: started an outgoing call
          // TODO: show screen calling in Flutter
          break;
        case Event.actionCallAccept:
          log("actionCallAccept----?}");
          // Get.to(JoinChannelAudio());

          Get.toNamed(Routes.callingScreenStaff, arguments: {
            "remoteMessage": message,
          });
          // Get.to(CallingScreen(
          //   message: message,
          // ));
          log("actionCallAccept----?}");
          // TODO: accepted an incoming call
          // TODO: show screen calling in Flutter
          break;
        case Event.actionCallDecline:
          await homeController.rejectCall(
              PreferenceManager().getId(), message.data['_id'], 'user');
          await homeController.addCallHistory(
              message.data['_id'], PreferenceManager().getId(), 'reject', '0');
          FlutterCallkitIncoming.endAllCalls();
          log("actionCallDecline----?}");
          // TODO: declined an incoming call
          break;
        case Event.actionCallEnded:
          log("actionCallEnded----?}");
          // TODO: ended an incoming/outgoing call
          break;
        case Event.actionCallTimeout:
          log("actionCallTimeout----?}");
          // TODO: missed an incoming call
          break;
        case Event.actionCallCallback:
          // TODO: only Android - click action `Call back` from missed call notification
          break;
        case Event.actionCallToggleHold:
          // TODO: only iOS
          break;
        case Event.actionCallToggleMute:
          // TODO: only iOS
          break;
        case Event.actionCallToggleDmtf:
          // TODO: only iOS
          break;
        case Event.actionCallToggleGroup:
          // TODO: only iOS
          break;
        case Event.actionCallToggleAudioSession:
          // TODO: only iOS
          break;
        case Event.actionDidUpdateDevicePushTokenVoip:
          // TODO: only iOS
          break;
        case Event.actionCallCustom:
          // TODO: for custom action
          break;
      }
    });
  }

  static Future<void> showCallkitIncoming(
      String uuid, RemoteMessage message) async {
    var callData = message.data;
    log("callData---->${callData['name']}");
    final params = CallKitParams(
      id: uuid,
      nameCaller: callData['name'],
      appName: 'Angel',
      avatar: 'https://i.pravatar.cc/100',
      handle: callData['mobile_number'],
      type: 0,
      duration: 30000,
      textAccept: 'Accept',
      textDecline: 'Decline',
      missedCallNotification: const NotificationParams(
        showNotification: false,
        isShowCallback: false,
        subtitle: 'Missed call',
        callbackText: 'Call back',
      ),
      extra: <String, dynamic>{'userId': callData['_id']},
      headers: <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
      android: const AndroidParams(
        isCustomNotification: true,
        isShowLogo: false,
        ringtonePath: 'system_ringtone_default',
        backgroundColor: '#0955fa',
        backgroundUrl: 'assets/test.png',
        actionColor: '#4CAF50',
        // textColor: '#ffffff',
      ),
      ios: const IOSParams(
        iconName: 'CallKitLogo',
        handleType: '',
        supportsVideo: true,
        maximumCallGroups: 2,
        maximumCallsPerCallGroup: 1,
        audioSessionMode: 'default',
        audioSessionActive: true,
        audioSessionPreferredSampleRate: 44100.0,
        audioSessionPreferredIOBufferDuration: 0.005,
        supportsDTMF: true,
        supportsHolding: true,
        supportsGrouping: false,
        supportsUngrouping: false,
        ringtonePath: 'system_ringtone_default',
      ),
    );
    await FlutterCallkitIncoming.showCallkitIncoming(params);
    // await FlutterCallkitIncoming.startCall(params);
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
    if (message.data['call_type'] == "reject") {
      if (PreferenceManager().getRole() == 'staff') {
        FlutterCallkitIncoming.endAllCalls();
      } else {
        CallingScreenController callingScreenController =
            Get.put(CallingScreenController());
        callingScreenController.rejectCall();
        callingScreenController.leaveChannel();
        Get.back();
      }
      log("reject--------------> ");
    } else if (message.data['call_type'] == "calling") {
      callHandle(message);
      showCallkitIncoming(Uuid().v4(), message);
    }
    RemoteNotification? notification = message.notification;
  }

  ///call when click on notification back
  static void onMsgOpen() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('A new onMessageOpenedApp event was published!');
      log('listen->${message.data}');
      // callHandle(message);
      // showCallkitIncoming( Uuid().v4(),message);
    });
  }
}
