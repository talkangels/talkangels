import 'dart:async';
import 'dart:developer';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:talkangels/const/extentions.dart';
import 'package:talkangels/const/shared_prefs.dart';
import 'package:talkangels/theme/app_layout.dart';
import 'package:talkangels/ui/angels/constant/app_color.dart';
import 'package:talkangels/ui/angels/constant/app_string.dart';
import 'package:talkangels/ui/angels/main/home_pages/home_screen_controller.dart';
import 'package:talkangels/ui/angels/models/angle_list_res_model.dart';
import 'package:talkangels/ui/angels/widgets/app_button.dart';
import 'package:talkangels/ui/staff/main/home_pages/home_controller.dart';

class CallingScreenController extends GetxController {
  RtcEngine? engine;
  String channelId = "";
  String appId = "";
  String token = "";
  String staffId = "";
  AngleData? selectedAngle;
  Timer? timer;
  bool isUserJoined = false;
  static HomeController homeController = Get.put(HomeController());
  int secondCount = 0;

  setAngle(AngleData value) {
    selectedAngle = value;
    update();
  }

  setCallRecieveOrNot() {
    timer = Timer(
      const Duration(seconds: 35),
      () async {
        if (isUserJoined == true) {
          timer!.cancel();
        } else {
          log("LEAVE==Angels_callingScreenController_TimeOut");

          rejectCall();
          leaveChannel();
          Get.back();
        }
      },
    );
  }

  rejectCall() async {
    await homeController.rejectCall(
        selectedAngle!.id!, PreferenceManager().getId(), 'staff');
    await homeController.addCallHistory(
        PreferenceManager().getId(), selectedAngle!.id!, 'reject', '0');
  }

  setAgoraDetails(
    String channellId,
    String apppId,
    String tokenn,
  ) {
    channelId = channellId;
    appId = apppId;
    token = tokenn;

    setCallRecieveOrNot();
    update();
  }

  bool isJoined = false,
      isConnect = false,
      openMicrophone = true,
      enableSpeakerphone = false,
      playEffect = false;
  bool enableInEarMonitoring = false;
  double recordingVolume = 100,
      playbackVolume = 100,
      inEarMonitoringVolume = 100;
  TextEditingController channelIdController = TextEditingController();
  ChannelProfileType channelProfileType =
      ChannelProfileType.channelProfileCommunication;
  late final RtcEngineEventHandler rtcEngineEventHandler;

  Future<void> initEngine() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.microphone.request();
    }
    engine = createAgoraRtcEngine();
    await engine!.initialize(RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    ));
    await engine!.enableAudio();
    // await engine!.setEnableSpeakerphone(false);
    await engine!.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await engine!.setAudioProfile(
      profile: AudioProfileType.audioProfileDefault,
      scenario: AudioScenarioType.audioScenarioGameStreaming,
    );
    await engine!.joinChannel(
        token: token,
        channelId: channelId,
        uid: 0,
        options: const ChannelMediaOptions(
          channelProfile: ChannelProfileType.channelProfileCommunication,
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
        ));
    rtcEngineEventHandler = RtcEngineEventHandler(
      onError: (ErrorCodeType err, String msg) {
        log("err----->$err  $msg");
      },
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        log('join----');
        isConnect = true;
        isJoined = true;
        update();
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        isJoined = false;
        log("LEAVE==Angels_callingScreenController_OnLeaveChannel");

        leaveChannel();
        Get.back();
        log('remove----111');
        update();
      },
      onUserOffline: (connection, remoteUid, reason) {
        log('remove----222');
        log("LEAVE==Angels_callingScreenController_OnUserOffline");

        leaveChannel();
        Get.back();
      },
      onUserJoined: (connection, remoteUid, elapsed) async {
        log('user join  $remoteUid');
        isUserJoined = true;
        timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          secondCount = secondCount + 1;
          update();
          log("secondCount--------------> ${secondCount}");
        });
        update();
        log('localUid----${connection.localUid}');
      }, /*onAudioDeviceVolumeChanged: (deviceType, volume, muted) {
        log("muted----->${muted}");
        log("deviceType----->${deviceType}");
        log("volume----->${volume}");
      },*/
    );

    engine!.registerEventHandler(rtcEngineEventHandler);

    // update();
  }

  joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.camera.request();
    }
  }

  @override
  void onClose() {
    log("LEAVE==Angels_callingScreenController_OnClose");
    leaveChannel();
    super.onClose();
  }

  leaveChannel() async {
    log("LEAVECHANNELS");

    HomeScreenController angelHomeScreenController =
        Get.put(HomeScreenController());
    TextEditingController ratingController = TextEditingController();
    String? rating;

    // await engine!.release();
    await engine!.leaveChannel();

    /// call Rating API
    if (secondCount > 10) {
      log("LEAVECHANNELS10");
      Get.dialog(
        AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
          contentPadding: EdgeInsets.all(Get.width * 0.05),
          // clipBehavior: Clip.antiAliasWithSaveLayer,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Builder(
            builder: (context) {
              return Container(
                padding: EdgeInsets.zero,
                height: Get.height * 0.5,
                width: Get.width * 0.9,
                child: Column(
                  children: [
                    AppString.pleaseRatingThisCall.regularLeagueSpartan(
                        fontColor: blackColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w800),
                    (Get.height * 0.03).addHSpace(),
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) =>
                          const Icon(Icons.star, color: Colors.amber),
                      onRatingUpdate: (ratingValue) {
                        rating = ratingValue.toString().split('.').first;
                        log("$rating");
                      },
                    ),
                    (Get.height * 0.03).addHSpace(),
                    TextField(
                      maxLines: 6,
                      minLines: 5,
                      onChanged: (value) {},
                      controller: ratingController,
                      style: const TextStyle(
                          color: blackColor,
                          fontSize: 16,
                          height: 1.2,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'League Spartan'),
                      decoration: InputDecoration(
                        hintText: "Comments",
                        hintStyle: TextStyle(
                            color: blackColor.withOpacity(0.5),
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'League Spartan'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: appBarColor),
                        ),
                      ),
                    ),
                    (Get.height * 0.04).addHSpace(),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: AppButton(
                            height: Get.height * 0.06,
                            color: Colors.transparent,
                            onTap: () {
                              Get.back();
                              log("RATING_SKIP");
                            },
                            child: AppString.skip.regularLeagueSpartan(
                                fontColor: blackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        (Get.width * 0.02).addWSpace(),
                        Expanded(
                          flex: 1,
                          child: AppButton(
                            height: Get.height * 0.06,
                            border: Border.all(color: redFontColor),
                            color: redFontColor,
                            onTap: () {
                              if (rating != null ||
                                  ratingController.text.isNotEmpty) {
                                /// Post Rating Api
                                angelHomeScreenController.addRatingApi(
                                  "${selectedAngle?.id.toString()}", // null
                                  rating!,
                                  ratingController.text,
                                );
                              } else {
                                showAppSnackBar("Please Select Require Fields");
                              }
                            },
                            child: AppString.submit.regularLeagueSpartan(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    }

    isJoined = false;
    isConnect = false;
    openMicrophone = true;
    enableSpeakerphone = true;
    playEffect = false;
    enableInEarMonitoring = false;
    recordingVolume = 100;
    playbackVolume = 100;
    inEarMonitoringVolume = 100;
    secondCount = 0;
    update();
  }

  switchMicrophone() async {
    // await  engine.muteLocalAudioStream(!openMicrophone);
    await engine!.enableLocalAudio(!openMicrophone);
    openMicrophone = !openMicrophone;
    update();
  }

  switchSpeakerphone() async {
    await engine!.setEnableSpeakerphone(!enableSpeakerphone);
    enableSpeakerphone = !enableSpeakerphone;
    update();
  }

  ///
  /// extra

// onChangeBluetooth(double value) async {
// _inEarMonitoringVolume = value;
// await engine);
// update();
// }
}
