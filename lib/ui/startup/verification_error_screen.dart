import 'package:flutter/material.dart';
import 'package:talkangels/const/extentions.dart';
import 'package:talkangels/ui/staff/constant/app_assets.dart';
import 'package:talkangels/ui/staff/constant/app_color.dart';
import 'package:talkangels/ui/staff/constant/app_string.dart';
import 'package:talkangels/ui/staff/widgets/app_appbar.dart';
import 'package:talkangels/ui/staff/widgets/app_button.dart';

class VerificationErrorScreen extends StatefulWidget {
  const VerificationErrorScreen({Key? key}) : super(key: key);

  @override
  State<VerificationErrorScreen> createState() =>
      _VerificationErrorScreenState();
}

class _VerificationErrorScreenState extends State<VerificationErrorScreen> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppAppBar(
        backGroundColor: appBarColor,
        titleText: AppString.somethingWentWrong,
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
                  (h * 0.10).addHSpace(),
                  SizedBox(
                      height: h * 0.3,
                      width: w * 0.6,
                      child: assetImage(
                          AppAssets.somethingWentWrongAnimationAssets,
                          fit: BoxFit.cover)),
                  (h * 0.05).addHSpace(),
                  AppString.somethingWentWrong
                      .leagueSpartanfs20w600(fontSize: 24),
                  (h * 0.01).addHSpace(),
                  AppString.somethingWentWrongDescription.regularLeagueSpartan(
                      fontColor: greyFontColor, textAlign: TextAlign.center),
                  (h * 0.17).addHSpace(),
                  AppButton(
                    onTap: () {},
                    color: redColor,
                    child: AppString.tryAgain.leagueSpartanfs20w600(),
                  ),
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
