import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talkangels/const/app_routes.dart';
import 'package:talkangels/const/extentions.dart';
import 'package:talkangels/const/shared_prefs.dart';
import 'package:talkangels/ui/staff/constant/app_assets.dart';
import 'package:talkangels/ui/staff/constant/app_color.dart';
import 'package:talkangels/ui/staff/constant/app_string.dart';
import 'package:talkangels/ui/staff/main/bottom_navigation_bar/bottom_bar_controller.dart';
import 'package:talkangels/ui/staff/widgets/app_appbar.dart';
import 'package:talkangels/ui/staff/widgets/app_button.dart';
import 'package:talkangels/ui/staff/widgets/app_show_profile_pic.dart';
import 'package:talkangels/ui/staff/widgets/common_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  BottomBarController bottomBarController = Get.find();

  bool requestStatus = true;
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: homeDrawer(),
      appBar: AppAppBar(
        appBarHeight: 80,
        backGroundColor: appBarColor,
        titleText: AppString.heyTalkAngel,
        // leadingIcon: Padding(
        //   padding: EdgeInsets.only(left: w * 0.06),
        //   child: svgAssetImage(AppAssets.menuBar),
        // ),
        // leadingWidth: w * 0.125,
        titleSpacing: w * 0.06,
        action: [
          AppShowProfilePic(
            image: AppAssets.profiles,
            onTap: () {
              Get.toNamed(Routes.profileDetailsScreen);
            },
          ),
          (w * 0.045).addWSpace(),
        ],
      ),
      body: Container(
        height: h,
        width: w,
        decoration: const BoxDecoration(gradient: appGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CommonContainer(
                          height: h * 0.15,
                          width: double.infinity,
                          bottomChild: AppString.totalMinute,
                          title: AppString.total,
                          subTitle: AppString.minutes,
                          icon: Icons.timer_outlined,
                        ),
                      ),
                      (w * 0.03).addWSpace(),
                      Expanded(
                        flex: 1,
                        child: CommonContainer(
                          height: h * 0.15,
                          width: double.infinity,
                          bottomChild: AppString.rupies,
                          title: AppString.total,
                          subTitle: AppString.currentEarnings,
                          icon: Icons.payments_outlined,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: h * 0.015),
                    child: CommonContainer(
                      height: h * 0.15,
                      width: double.infinity,
                      bottomChild: AppString.totalMoneyWithdraws,
                      title: AppString.total,
                      subTitle: AppString.moneyWithdraws,
                      icon: Icons.book_online,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CommonContainer(
                          height: h * 0.15,
                          width: double.infinity,
                          bottomChild: AppString.totalPendingMoney,
                          title: AppString.total,
                          subTitle: AppString.pendingMoney,
                          icon: Icons.monetization_on_outlined,
                        ),
                      ),
                      (w * 0.03).addWSpace(),
                      Expanded(
                        flex: 1,
                        child: CommonContainer(
                          height: h * 0.15,
                          width: double.infinity,
                          bottomChild: AppString.totalRequestSent,
                          title: AppString.withdraw,
                          subTitle: AppString.requestSent,
                          icon: Icons.check_circle_outline,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: h * 0.015),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: w * 0.03, vertical: h * 0.015),
                      decoration: BoxDecoration(
                          color: containerColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  AppString.withdraw.regularLeagueSpartan(
                                      fontSize: 14, fontColor: appColorBlue),
                                  AppString.requestStatus.regularLeagueSpartan(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ],
                              ),
                              AppString.oneLineExplanation.regularLeagueSpartan(
                                  fontColor: greyFontColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                            ],
                          ),
                          const Spacer(),
                          Switch(
                            activeColor: appColorGreen,
                            inactiveTrackColor: textFieldBorderColor,
                            thumbColor:
                                MaterialStateProperty.resolveWith((Set states) {
                              if (states.contains(MaterialState.disabled)) {
                                return containerColor.withOpacity(0.05);
                              }
                              return containerColor;
                            }),
                            value: requestStatus,
                            onChanged: (value) {
                              setState(() {
                                requestStatus = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget homeDrawer() {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return GetBuilder<BottomBarController>(
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            closeDrawer();
          },
          child: Drawer(
            elevation: 0,
            width: w * 0.75,
            backgroundColor: appBarColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: Container(
              height: h,
              width: w,
              decoration: const BoxDecoration(gradient: appGradient),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          AppShowProfilePic(
                            image: AppAssets.profiles,
                            onTap: () {},
                            radius: w * 0.18,
                          ),
                          (w * 0.04).addWSpace(),
                          Column(
                            children: [
                              AppString.jenilTaylor.regularLeagueSpartan(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                              AppString.phoneNumber
                                  .regularLeagueSpartan(fontSize: 12),
                            ],
                          ),
                        ],
                      ).paddingOnly(
                          left: w * 0.06, top: h * 0.05, bottom: h * 0.035),
                    ),
                    1.0.appDivider(),
                    drawerListTile(
                      title: AppString.myProfile,
                      onTap: () {
                        closeDrawer();
                        controller.selectedPage = 2;
                        Get.toNamed(Routes.bottomBarScreen);
                        controller.update();
                      },
                      image: AppAssets.myProfileIcon,
                    ),
                    1.0.appDivider(),
                    drawerListTile(
                      title: AppString.callHistory,
                      onTap: () {
                        closeDrawer();
                        controller.selectedPage = 1;
                        Get.toNamed(Routes.bottomBarScreen);
                        controller.update();
                      },
                      image: AppAssets.myWalletIcon,
                    ),
                    1.0.appDivider(),
                    drawerListTile(
                      title: AppString.reportAProblem,
                      onTap: () {
                        closeDrawer();
                      },
                      image: AppAssets.reportProblemIcon,
                    ),
                    1.0.appDivider(),
                    drawerListTile(
                      title: AppString.deleteAccount,
                      onTap: () {
                        closeDrawer();

                        ///
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) => AlertDialog(
                            insetPadding:
                                EdgeInsets.symmetric(horizontal: w * 0.08),
                            contentPadding: EdgeInsets.all(w * 0.05),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            content: Builder(
                              builder: (context) {
                                return Container(
                                  padding: EdgeInsets.zero,
                                  height: h * 0.4,
                                  width: w * 0.9,
                                  child: Column(
                                    children: [
                                      const Spacer(),
                                      SizedBox(
                                          height: h * 0.13,
                                          width: w * 0.26,
                                          child: assetImage(
                                              AppAssets.sureAnimationAssets,
                                              fit: BoxFit.contain)),
                                      const Spacer(),
                                      AppString.areYouSure
                                          .leagueSpartanfs20w600(
                                              fontColor: blackColor,
                                              fontSize: 24),
                                      AppString.deleteAccountDescription
                                          .regularLeagueSpartan(
                                              fontColor: greyFontColor,
                                              fontSize: 15,
                                              textAlign: TextAlign.center),
                                      (h * 0.04).addHSpace(),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: AppButton(
                                              height: h * 0.06,
                                              color: Colors.transparent,
                                              onTap: () {
                                                Get.offAllNamed(
                                                    Routes.loginScreen);
                                              },
                                              child: AppString.yesImSure
                                                  .regularLeagueSpartan(
                                                      fontColor: blackColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                          ),
                                          (w * 0.02).addWSpace(),
                                          Expanded(
                                            flex: 1,
                                            child: AppButton(
                                              height: h * 0.06,
                                              color: appColorBlue,
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: AppString.noGoBack
                                                  .regularLeagueSpartan(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700),
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
                      },
                      image: AppAssets.deleteAccountIcon,
                    ),
                    1.0.appDivider(),
                    drawerListTile(
                      title: AppString.logOut,
                      fontColor: redColor,
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: h * 0.4,
                              width: w * 1,
                              decoration: const BoxDecoration(
                                  gradient: appGradient,
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20))),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: w * 0.05),
                                  child: Column(
                                    children: <Widget>[
                                      const Spacer(),
                                      SizedBox(
                                          height: h * 0.12,
                                          width: w * 0.3,
                                          child: assetImage(
                                              AppAssets.exitAnimationAssets,
                                              fit: BoxFit.contain)),
                                      const Spacer(),
                                      Center(
                                        child: AppString.doYouWantToExit
                                            .leagueSpartanfs20w600(),
                                      ),
                                      (h * 0.01).addHSpace(),
                                      AppString
                                          .areYouSureYouReallyWantToLOgOutFromyourTalkAngelAaccount
                                          .regularLeagueSpartan(
                                              fontColor: greyFontColor,
                                              fontSize: 14,
                                              textAlign: TextAlign.center),
                                      (h * 0.03).addHSpace(),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: AppButton(
                                              height: h * 0.06,
                                              color: Colors.transparent,
                                              onTap: () {
                                                Get.back();
                                                showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (_) => AlertDialog(
                                                    insetPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                w * 0.08),
                                                    contentPadding:
                                                        EdgeInsets.all(
                                                            w * 0.05),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    content: Builder(
                                                      builder: (context) {
                                                        return SizedBox(
                                                          height: h * 0.4,
                                                          width: w * 0.9,
                                                          child: Column(
                                                            children: [
                                                              const Spacer(),
                                                              SizedBox(
                                                                  height:
                                                                      h * 0.13,
                                                                  width:
                                                                      w * 0.26,
                                                                  child: assetImage(
                                                                      AppAssets
                                                                          .sureAnimationAssets,
                                                                      fit: BoxFit
                                                                          .contain)),
                                                              const Spacer(),
                                                              AppString
                                                                  .doYouWantToExit
                                                                  .leagueSpartanfs20w600(
                                                                      fontColor:
                                                                          blackColor,
                                                                      fontSize:
                                                                          24),
                                                              AppString
                                                                  .areYouSureYouReallyWantToLOgOutFromyourTalkAngelAaccount
                                                                  .regularLeagueSpartan(
                                                                      fontColor:
                                                                          greyFontColor,
                                                                      fontSize:
                                                                          15,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center),
                                                              (h * 0.04)
                                                                  .addHSpace(),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        AppButton(
                                                                      height: h *
                                                                          0.06,
                                                                      color: Colors
                                                                          .transparent,
                                                                      onTap:
                                                                          () {
                                                                        PreferenceManager()
                                                                            .setClearALlPref();
                                                                        Get.back();

                                                                        Get.offAllNamed(
                                                                            Routes.loginScreen);
                                                                      },
                                                                      child: AppString.logOut.regularLeagueSpartan(
                                                                          fontColor:
                                                                              blackColor,
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w800),
                                                                    ),
                                                                  ),
                                                                  (w * 0.02)
                                                                      .addWSpace(),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        AppButton(
                                                                      height: h *
                                                                          0.06,
                                                                      color:
                                                                          appColorBlue,
                                                                      onTap:
                                                                          () {
                                                                        Get.back();
                                                                      },
                                                                      child: AppString.cancel.regularLeagueSpartan(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w800),
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
                                              },
                                              child: AppString.logout_
                                                  .regularLeagueSpartan(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                          ),
                                          (w * 0.02).addWSpace(),
                                          Expanded(
                                            flex: 1,
                                            child: AppButton(
                                              height: h * 0.06,
                                              color: appColorBlue,
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: AppString.cancel
                                                  .regularLeagueSpartan(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                          )
                                        ],
                                      ),
                                      (h * 0.02).addHSpace(),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      image: AppAssets.logOutIcon,
                      action: false,
                    ),
                    1.0.appDivider(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  closeDrawer() {
    Get.back();
  }

  drawerListTile(
      {required String title,
      required String image,
      required VoidCallback onTap,
      Color? fontColor,
      bool action = true}) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: h * 0.03, horizontal: w * 0.06),
        child: Row(
          children: [
            image == ""
                ? const SizedBox(
                    width: 20,
                    height: 20,
                  )
                : svgAssetImage(image,
                    height: 15, width: 15, color: fontColor ?? whiteColor),
            15.0.addWSpace(),
            Expanded(
              child: title.regularLeagueSpartan(
                fontColor: fontColor ?? whiteColor,
                fontSize: 14,
              ),
            ),
            action == true
                ? Icon(Icons.arrow_forward_ios,
                    color: whiteColor.withOpacity(0.5), size: 17)
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
