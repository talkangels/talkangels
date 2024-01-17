import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:talkangels/ui/angels/constant/app_assets.dart';
import 'package:talkangels/ui/angels/constant/app_color.dart';
import 'package:talkangels/ui/angels/constant/app_string.dart';
import 'package:talkangels/const/app_routes.dart';
import 'package:talkangels/const/extentions.dart';
import 'package:talkangels/const/shared_prefs.dart';
import 'package:talkangels/ui/angels/utils/share_profile_details_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _onInit() {
    Future.delayed(const Duration(seconds: 6), () {
      if (PreferenceManager().getLogin() == true) {
        log("PreferenceManager().getRole()=>${PreferenceManager().getRole()}");
        if (PreferenceManager().getRole() == "user") {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await DynamicLinkService().handleDynamicLinks();
          });

          Get.offAllNamed(Routes.homeScreen);
        } else {
          log("userRest.data!.role----dss->${PreferenceManager().getRole()}");
          Get.offAllNamed(Routes.bottomBarScreen);
        }
      } else {
        Get.offAllNamed(Routes.loginScreen);
      }
    });

    ///old Data
    // Future.delayed(const Duration(seconds: 6), () {
    //   // Get.offAllNamed(Routes.loginScreen);
    //
    //   if (PreferenceManager().getLogin() == true) {
    //     Get.offAllNamed(Routes.homeScreen);
    //   } else {
    //     Get.offAllNamed(Routes.loginScreen);
    //   }
    // });
  }

  @override
  void initState() {
    _onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: h,
        width: w,
        decoration: const BoxDecoration(gradient: appGradient),
        child: SafeArea(
          child: Column(
            children: [
              (h * 0.09).addHSpace(),
              svgAssetImage(AppAssets.appLogo,
                  height: w * 0.25, width: w * 0.25),
              AppString.talkAngels.regularAllertaStencil(fontSize: 32),
              AppString.anonymousChatCall.regularLeagueSpartan(
                  fontSize: 14, fontWeight: FontWeight.w300),
              (h * 0.17).addHSpace(),
              RippleAnimation(
                  color: appColorGreen.withOpacity(0.04),
                  delay: const Duration(milliseconds: 30),
                  repeat: true,
                  minRadius: 54,
                  ripplesCount: 6,
                  duration: const Duration(milliseconds: 6 * 300),
                  child: SizedBox(
                      height: h * 0.3,
                      width: w * 0.6,
                      child: Lottie.asset(AppAssets.animationIncomingCall,
                          fit: BoxFit.fill))),
              AppString.bringingYouToaZonOfOpenMindedness.regularLeagueSpartan(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  textAlign: TextAlign.center,
                  fontColor: appColorGreen),
            ],
          ),
        ),
      ),
    );
  }
}
