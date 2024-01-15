import 'dart:developer';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:talkangels/ui/angels/models/angle_list_res_model.dart';

class CallingScreenController extends GetxController {
  late final RtcEngine engine;
  String channelId = "";
  String appId = "";
  String token = "";
  Datum? selectedAngle;
  setAngle(Datum value) {
    selectedAngle = value;
    update();
  }

  setAgoraDetails(String channellId, String apppId, String tokenn) {
    channelId = channellId;
    appId = apppId;
    token = tokenn;
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
    engine = createAgoraRtcEngine();
    await engine.initialize(RtcEngineContext(
      appId: appId,
    ));
    joinChannel();
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

        update();
      },
      onUserJoined: (connection, remoteUid, elapsed) async {
        log('user join${remoteUid}');

        DeviceInfo info = await engine.getAudioDeviceInfo();
        log("info----->${info.isLowLatencyAudioSupported}");
      }, /*onAudioDeviceVolumeChanged: (deviceType, volume, muted) {
        log("muted----->${muted}");
        log("deviceType----->${deviceType}");
        log("volume----->${volume}");
      },*/
    );

    engine.registerEventHandler(rtcEngineEventHandler);

    await engine.enableAudio();
    // await engine!.setEnableSpeakerphone(false);
    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await engine.setAudioProfile(
      profile: AudioProfileType.audioProfileDefault,
      scenario: AudioScenarioType.audioScenarioGameStreaming,
    );
    // update();
  }

  joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.microphone.request();
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.camera.request();
    }
    await engine.joinChannel(
        token: token,
        channelId: channelId,
        uid: 0,
        options: ChannelMediaOptions(
          channelProfile: channelProfileType,
          enableAudioRecordingOrPlayout: true,
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
        ));
  }

  @override
  void onClose() {
    leaveChannel();
    super.onClose();
  }

  leaveChannel() async {
    await engine.leaveChannel();

    isJoined = false;
    isConnect = false;
    openMicrophone = true;
    enableSpeakerphone = true;
    playEffect = false;
    enableInEarMonitoring = false;
    recordingVolume = 100;
    playbackVolume = 100;
    inEarMonitoringVolume = 100;
    update();
    // if(){}
  }

  switchMicrophone() async {
    // await  engine.muteLocalAudioStream(!openMicrophone);
    await engine.enableLocalAudio(!openMicrophone);
    openMicrophone = !openMicrophone;
    update();
  }

  switchSpeakerphone() async {
    await engine.setEnableSpeakerphone(!enableSpeakerphone);
    enableSpeakerphone = !enableSpeakerphone;
    update();
  }

  switchEffect() async {
    if (playEffect) {
      await engine.stopEffect(1);
      playEffect = false;
      update();
    } else {
      final path =
          (await engine.getAssetAbsolutePath("assets/Sound_Horizon.mp3"))!;
      await engine.playEffect(
          soundId: 1,
          filePath: path,
          loopCount: 0,
          pitch: 1,
          pan: 1,
          gain: 100,
          publish: true);
      // .then((value) {

      playEffect = true;
      update();
    }
  }

  onChangeInEarMonitoringVolume(double value) async {
    inEarMonitoringVolume = value;
    await engine.setInEarMonitoringVolume(inEarMonitoringVolume.toInt());
    update();
  }

  toggleInEarMonitoring(value) async {
    try {
      await engine.enableInEarMonitoring(
          enabled: value,
          includeAudioFilters: EarMonitoringFilterType.earMonitoringFilterNone);
      enableInEarMonitoring = value;
      update();
    } catch (e) {
      // Do nothing
    }
  }

  ///
  /// extra

// onChangeBluetooth(double value) async {
// _inEarMonitoringVolume = value;
// await engine);
// update();
// }
}
