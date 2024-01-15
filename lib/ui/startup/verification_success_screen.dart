import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talkangels/const/app_routes.dart';
import 'package:talkangels/const/extentions.dart';
import 'package:talkangels/ui/staff/constant/app_color.dart';
import 'package:talkangels/ui/staff/constant/app_assets.dart';
import 'package:talkangels/ui/staff/constant/app_string.dart';
import 'package:talkangels/ui/staff/widgets/app_appbar.dart';
import 'package:talkangels/ui/staff/widgets/app_button.dart';

class VerificationSuccessScreen extends StatefulWidget {
  const VerificationSuccessScreen({Key? key}) : super(key: key);

  @override
  State<VerificationSuccessScreen> createState() =>
      _VerificationSuccessScreenState();
}

class _VerificationSuccessScreenState extends State<VerificationSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppAppBar(
        backGroundColor: appBarColor,
        titleText: AppString.verificationSuccessful,
        titleFontWeight: FontWeight.w900,
        fontSize: 20,
        bottom: PreferredSize(
            preferredSize: const Size(300, 50), child: 1.0.appDivider()),
      ),
      body: Container(
        height: h,
        width: w,
        decoration: const BoxDecoration(gradient: appGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.06),
              child: Column(
                children: [
                  (h * 0.05).addHSpace(),
                  SizedBox(
                      height: h * 0.4,
                      width: w * 0.8,
                      child: assetImage(
                          AppAssets.verificationSuccessfulAnimationAssets,
                          width: w * 0.4,
                          height: h * 0.2,
                          fit: BoxFit.contain)),
                  AppString.verificationSuccessful
                      .leagueSpartanfs20w600(fontSize: 24),
                  (h * 0.01).addHSpace(),
                  AppString.verificationSuccessfulDescription
                      .regularLeagueSpartan(
                          fontColor: greyFontColor,
                          textAlign: TextAlign.center),
                  (h * 0.17).addHSpace(),
                  AppButton(
                      onTap: () {
                        Get.offAllNamed(Routes.bottomBarScreen);
                      },
                      child: AppString.logIn.leagueSpartanfs20w600()),
                  (h * 0.03).addHSpace(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
