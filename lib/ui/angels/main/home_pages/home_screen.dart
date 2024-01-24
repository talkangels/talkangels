import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:talkangels/theme/app_layout.dart';
import 'package:talkangels/ui/angels/constant/app_assets.dart';
import 'package:talkangels/ui/angels/constant/app_color.dart';
import 'package:talkangels/ui/angels/constant/app_string.dart';
import 'package:talkangels/ui/angels/main/home_pages/home_screen_controller.dart';
import 'package:talkangels/const/app_routes.dart';
import 'package:talkangels/const/extentions.dart';
import 'package:talkangels/const/shared_prefs.dart';
import 'package:talkangels/ui/angels/utils/share_profile_details_service.dart';
import 'package:talkangels/ui/angels/widgets/app_app_bar.dart';
import 'package:talkangels/ui/angels/widgets/app_button.dart';
import 'package:talkangels/ui/angels/widgets/app_dialogbox.dart';
import 'package:talkangels/ui/angels/widgets/app_show_profile_pic.dart';
import 'package:talkangels/ui/angels/widgets/app_textfield.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  HomeScreenController homeController = Get.put(HomeScreenController());
  TextEditingController talkTimeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Razorpay razorpay = Razorpay();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      DynamicLinkService().handleDynamicLinks();
      await homeController.userDetailsApi();
    });

    timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      if (homeController.isSearch == false) {
        homeController.homeAngleApi();
      } else {
        homeController.homeAngleApi(
            isSearched: homeController.isSearch,
            value: homeController.searchValue);
      }
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        timer!.cancel();
        log('appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        timer = Timer.periodic(const Duration(seconds: 15), (timer) {
          if (homeController.isSearch == false) {
            homeController.homeAngleApi();
          } else {
            homeController.homeAngleApi(
                isSearched: homeController.isSearch,
                value: homeController.searchValue);
          }
        });
        log('appLifeCycleState resumed');
        break;
      case AppLifecycleState.paused:
        timer!.cancel();
        log('appLifeCycleState paused');
        break;
      case AppLifecycleState.hidden:
        timer!.cancel();
        log('appLifeCycleState suspending');
        break;
      case AppLifecycleState.detached:
        timer!.cancel();
        log('appLifeCycleState detached');
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
    timer!.cancel();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    log("${PreferenceManager().getId()}", name: "USERID");
    log("${PreferenceManager().getToken()}", name: "TOKEN");
    log("${PreferenceManager().getLogin()}", name: "LOGIN");
    log(PreferenceManager().getName(), name: "NAME");
    log(PreferenceManager().getNumber(), name: "NUMBER");
    log(PreferenceManager().getFCMNotificationToken(),
        name: "FCMNOTIFICATIONTOKEN");
    log("${jsonDecode(PreferenceManager().getUserDetails())}",
        name: "DECODE====GETUSERDETAILS");

    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return GetBuilder<HomeScreenController>(
      builder: (controller) {
        return Stack(
          children: [
            Scaffold(
                drawer: homeDrawer(),
                appBar: AppAppBar(
                  appBarHeight: 120, backGroundColor: appBarColor,
                  titleText: AppString.heyTalkAngle,
                  // leadingIcon: Padding(
                  //   padding: EdgeInsets.only(left: w * 0.06),
                  //   child: svgAssetImage(AppAssets.menuBar),
                  // ),
                  // leadingWidth: w * 0.125,
                  titleSpacing: w * 0.03,
                  action: [
                    AppShowProfilePic(
                      image: '',
                      onTap: () {
                        Get.toNamed(Routes.profileScreen);
                      },
                    ),
                    (w * 0.045).addWSpace(),
                  ],
                  bottom: bottom(),
                ),
                body: controller.resModel.data == null
                    ? Container(
                        height: h,
                        width: w,
                        decoration: const BoxDecoration(gradient: appGradient),
                        child: const Center(
                            child:
                                CircularProgressIndicator(color: whiteColor)),
                      )
                    : Container(
                        height: h,
                        width: w,
                        decoration: const BoxDecoration(gradient: appGradient),
                        child:
                            controller.resModel.data == [] ||
                                    controller.resModel.data!.length <= 0
                                ? Center(
                                    child: AppString.noDataFound
                                        .leagueSpartanfs20w600(
                                            fontColor: greyFontColor,
                                            fontWeight: FontWeight.w700))
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: controller.resModel.data!.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            top: index == 0 ? h * 0.02 : 0,
                                            left: w * 0.04,
                                            right: w * 0.04,
                                            bottom: h * 0.02),
                                        child: InkWell(
                                          onTap: () {
                                            controller.setAngle(controller
                                                .resModel.data![index]);
                                            Get.toNamed(
                                                Routes.personDetailScreen,
                                                arguments: {
                                                  "angel_id": controller
                                                      .resModel.data![index].id
                                                });
                                          },
                                          child: Container(
                                            height: h * 0.13,
                                            width: w,
                                            decoration: BoxDecoration(
                                                color: containerColor,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                (w * 0.04).addWSpace(),
                                                Stack(
                                                  children: [
                                                    AppShowProfilePic(
                                                        image: controller
                                                                .resModel
                                                                .data![index]
                                                                .image ??
                                                            '',
                                                        onTap: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (_) =>
                                                                AlertDialog(
                                                              insetPadding:
                                                                  EdgeInsets.only(
                                                                      left: w *
                                                                          0.06,
                                                                      right: w *
                                                                          0.3),
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              clipBehavior: Clip
                                                                  .antiAliasWithSaveLayer,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              content:
                                                                  Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                height:
                                                                    h * 0.35,
                                                                width: w * 0.9,
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      height: h *
                                                                          0.29,
                                                                      width: w *
                                                                          0.9,
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.vertical(top: Radius.circular(10)),
                                                                      ),
                                                                      child: controller.resModel.data![index].image == "" || controller.resModel.data![index].image!.isEmpty
                                                                          ? assetImage(AppAssets.blankProfile,
                                                                              fit: BoxFit
                                                                                  .cover)
                                                                          : Image.network(
                                                                              controller.resModel.data![index].image!,
                                                                              fit: BoxFit.cover),
                                                                    ),
                                                                    Container(
                                                                      height: h *
                                                                          0.06,
                                                                      width: w *
                                                                          0.9,
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        color:
                                                                            whiteColor,
                                                                        borderRadius:
                                                                            BorderRadius.vertical(bottom: Radius.circular(10)),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.symmetric(horizontal: w * 0.03),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            InkWell(
                                                                              onTap: () {},
                                                                              child: const CircleAvatar(
                                                                                backgroundColor: appColorGreen,
                                                                                radius: 15,
                                                                                child: Icon(Icons.phone, color: whiteColor, size: 18),
                                                                              ),
                                                                            ),
                                                                            (w * 0.02).addWSpace(),
                                                                            AppString.talkNow.regularLeagueSpartan(
                                                                                fontColor: appColorGreen,
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.w900),
                                                                            const Spacer(),
                                                                            InkWell(
                                                                              onTap: () async {
                                                                                String url = await DynamicLinkService().createShareProfileLink(angelId: controller.resModel.data![index].id.toString());
                                                                                Share.share(url);
                                                                              },
                                                                              child: Container(
                                                                                height: w * 0.08,
                                                                                width: w * 0.08,
                                                                                decoration: BoxDecoration(
                                                                                  shape: BoxShape.circle,
                                                                                  border: Border.all(color: greyFontColor),
                                                                                ),
                                                                                child: const Icon(Icons.share, color: greyFontColor, size: 18),
                                                                              ),
                                                                            ),
                                                                            (w * 0.03).addWSpace(),
                                                                            InkWell(
                                                                              onTap: () {},
                                                                              child: Container(
                                                                                height: w * 0.08,
                                                                                width: w * 0.08,
                                                                                decoration: BoxDecoration(
                                                                                  shape: BoxShape.circle,
                                                                                  border: Border.all(color: greyFontColor),
                                                                                ),
                                                                                child: svgAssetImage(AppAssets.whatsAppLogo, color: greyFontColor).paddingAll(6),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        borderShow: false,
                                                        radius: 62),
                                                    Positioned(
                                                      right: 6,
                                                      bottom: 6,
                                                      child: controller
                                                                  .resModel
                                                                  .data![index]
                                                                  .activeStatus ==
                                                              AppString.online
                                                          ? const CircleAvatar(
                                                              backgroundColor:
                                                                  containerColor,
                                                              radius: 7,
                                                              child:
                                                                  CircleAvatar(
                                                                backgroundColor:
                                                                    greenColor,
                                                                radius: 4.5,
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                    ),
                                                  ],
                                                ),
                                                (w * 0.03).addWSpace(),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    (controller
                                                                .resModel
                                                                .data![index]
                                                                .name ??
                                                            '')
                                                        .regularLeagueSpartan(
                                                            fontColor:
                                                                whiteColor,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                    (h * 0.005).addHSpace(),
                                                    "${controller.resModel.data![index].gender?[0] ?? ''}-${controller.resModel.data![index].age ?? ''} Yrs • 0 yrs of Experience"
                                                        .regularLeagueSpartan(
                                                            fontColor:
                                                                whiteColor,
                                                            fontSize: 10),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(Icons.star,
                                                            size: 11,
                                                            color: yellowColor),
                                                        (w * 0.01).addWSpace(),
                                                        ("${controller.resModel.data![index].totalRating}  (${controller.resModel.data![index].reviews?.length} Rating)")
                                                            .regularLeagueSpartan(
                                                                fontColor:
                                                                    yellowColor,
                                                                fontSize: 10),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const Spacer(),
                                                InkWell(
                                                  onTap: () {
                                                    // log(",PreferenceManager().getId()-------1----${PreferenceManager().getId()}");
                                                    // log(",PreferenceManager().getId()------2-----${PreferenceManager().getToken()}");
                                                    // log(",PreferenceManager().getId()-----3------${controller.resModel.data![index].id!}");
                                                    controller.setAngle(
                                                        controller.resModel
                                                            .data![index]);

                                                    if (controller
                                                            .resModel
                                                            .data![index]
                                                            .callStatus ==
                                                        "Busy") {
                                                    } else {
                                                      controller.angleCallingApi(
                                                          controller.resModel
                                                              .data![index].id!,
                                                          PreferenceManager()
                                                              .getId());
                                                    }
                                                  },
                                                  child: Container(
                                                      height: h * 0.045,
                                                      width: w * 0.2,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                              color:
                                                                  textFieldBorderColor)),
                                                      child: Center(
                                                          child: controller.resModel.data![index].callStatus ==
                                                                  "Busy"
                                                              ? AppString.busy.regularLeagueSpartan(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)
                                                              : AppString.talkNow
                                                                  .regularLeagueSpartan(
                                                                      fontSize: 14,
                                                                      fontWeight: FontWeight.w500))),
                                                ),
                                                (w * 0.04).addWSpace(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                      )),
            controller.isCallLoading == true
                ? Container(
                    height: h,
                    width: w,
                    color: Colors.black26,
                    child: const Center(
                        child: CircularProgressIndicator(color: Colors.white)),
                  )
                : const SizedBox()
          ],
        );
      },
    );
  }

  PreferredSizeWidget bottom() {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return PreferredSize(
      preferredSize: Size(double.infinity, h * 0.20),
      child: GetBuilder<HomeScreenController>(builder: (controller) {
        return SearchTextFormField(
          controller: controller.searchController,
          labelText: AppString.searchTalkAngelHere,
          prefixIcon: Icon(Icons.search, color: whiteColor.withOpacity(0.5)),
          onChanged: (p0) {
            controller.searchValue = p0;
            controller.update();
            if (p0.isEmpty || p0 == '') {
              controller.isSearch = false;
              controller.update();
              controller.homeAngleApi();
            } else {
              controller.isSearch = true;
              controller.update();
              controller.homeAngleApi(
                  isSearched: controller.isSearch, value: p0);
            }
          },
          suffixIcon: InkWell(
            onTap: () {
              showModalBottomSheet<void>(
                constraints: BoxConstraints(maxHeight: h * 0.55),
                isDismissible: false,
                backgroundColor: containerColor,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                context: context,
                builder: (BuildContext context) {
                  return Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: w * 0.05, vertical: h * 0.025),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Stack(
                            children: [
                              Container(
                                width: w * 1,
                                height: h * 0.15,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: assetsImage2(AppAssets.girl),
                                        fit: BoxFit.cover)),
                              ),
                              Positioned(
                                right: w * 0.05,
                                top: h * 0.01,
                                child: Row(
                                  children: [
                                    AppString.insufficientBalance
                                        .regularLeagueSpartan(
                                            fontWeight: FontWeight.w600),
                                    (w * 0.01).addWSpace(),
                                    svgAssetImage(AppAssets.emoji),
                                  ],
                                ),
                              )
                            ],
                          ),
                          (h * 0.03).addHSpace(),
                          AppString.addTalkTime.regularLeagueSpartan(),
                          (h * 0.01).addHSpace(),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: whiteColor),
                            child: TextFormField(
                              cursorColor: blackColor,
                              keyboardType: TextInputType.number,
                              controller: talkTimeController,
                              style: const TextStyle(
                                  color: blackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'League Spartan'),
                              decoration: InputDecoration(
                                suffixIcon: TextButton(
                                    onPressed: () {
                                      Get.back();
                                      Get.toNamed(Routes.allChargesScreen);
                                    },
                                    child: AppString.seeOffer
                                        .regularLeagueSpartan(
                                            fontColor: appColorGreen,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                hintText: "₹",
                                hintStyle: TextStyle(
                                    color: blackColor.withOpacity(0.7),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'League Spartan'),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide.none),
                                constraints:
                                    const BoxConstraints(maxHeight: 50),
                              ),
                            ),
                          ),
                          const Spacer(),
                          AppButton(
                            onTap: () {
                              if (talkTimeController.text != '') {
                                /// Payment Method

                                var options = {
                                  'key': 'rzp_test_EM5urUrcGkdJvm',
                                  'amount':
                                      100 * int.parse(talkTimeController.text),
                                  'name': 'Acme Corp.',
                                  'description': 'Fine T-Shirt',
                                  'retry': {'enabled': true, 'max_count': 1},
                                  'send_sms_hash': true,
                                  'prefill': {
                                    'contact':
                                        "+91 ${PreferenceManager().getNumber().toString()}",
                                    'email': 'test@razorpay.com'
                                  },
                                  'external': {
                                    'wallets': ['paytm']
                                  }
                                };
                                try {
                                  Get.back();
                                  razorpay.open(options);
                                  log("SUCCESS======>>>>>");
                                } catch (e) {
                                  log("ERROR==RAZORPAY   $e");
                                }
                              } else {
                                showAppSnackBar(AppString.pleaseEnterAmount);
                              }
                            },
                            child: AppString.add.regularLeagueSpartan(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Container(
              height: h * 0.01,
              width: w * 0.22,
              decoration: BoxDecoration(
                color: redFontColor,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: svgAssetImage(AppAssets.myWalletIcon,
                            color: redFontColor)
                        .paddingAll(2),
                  ),
                  "${homeController.userDetailsResModel.data?.talkAngelWallet?.totalBallance ?? ''}"
                      .regularLeagueSpartan(fontSize: 12),
                ],
              ),
            ),
          ).paddingOnly(top: 8, bottom: 8, right: 10),
        ).paddingOnly(left: w * 0.04, right: w * 0.04, bottom: h * 0.01);
      }),
    );
  }

  Widget homeDrawer() {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        closeDrawer();
      },
      child: Drawer(
        elevation: 0,
        width: w * 0.75,
        backgroundColor: appBarColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
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
                        image: '',
                        onTap: () {},
                        radius: w * 0.18,
                      ),
                      (w * 0.04).addWSpace(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "${PreferenceManager().getName() ?? ''}"
                              .regularLeagueSpartan(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                          "+91 ${PreferenceManager().getNumber() ?? ''}"
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
                    Get.toNamed(Routes.profileScreen);
                  },
                  image: AppAssets.myProfileIcon,
                ),
                1.0.appDivider(),
                drawerListTile(
                  title: AppString.myWallet,
                  onTap: () {
                    closeDrawer();
                    Get.toNamed(Routes.myWalletScreen, arguments: {
                      "walletBallance": homeController.userDetailsResModel.data
                          ?.talkAngelWallet?.totalBallance,
                    });
                  },
                  image: AppAssets.myWalletIcon,
                ),
                1.0.appDivider(),
                drawerListTile(
                  title: AppString.referEarn,
                  onTap: () {
                    closeDrawer();
                    Get.toNamed(Routes.referEarnScreen, arguments: {
                      "referCode":
                          homeController.userDetailsResModel.data?.referCode ??
                              ''
                    });
                  },
                  image: AppAssets.referEarnIcon,
                ),
                1.0.appDivider(),
                drawerListTile(
                  title: AppString.reportAProblem,
                  onTap: () {
                    closeDrawer();
                    Get.toNamed(Routes.reportAProblemScreen);
                  },
                  image: AppAssets.reportProblemIcon,
                ),
                1.0.appDivider(),
                drawerListTile(
                  title: AppString.deleteAccount,
                  onTap: () {
                    closeDrawer();

                    /// Delete Account
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) => AlertDialog(
                        insetPadding:
                            EdgeInsets.symmetric(horizontal: w * 0.08),
                        contentPadding: EdgeInsets.all(w * 0.05),
                        // clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        content: Container(
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
                                      fit: BoxFit.cover)),
                              const Spacer(),
                              AppString.areYouSure.regularLeagueSpartan(
                                  fontColor: blackColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800),
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
                                      onTap: () async {
                                        await homeController.deleteAccountApi();
                                      },
                                      child: AppString.yesImSure
                                          .regularLeagueSpartan(
                                              fontColor: blackColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  (w * 0.02).addWSpace(),
                                  Expanded(
                                    flex: 1,
                                    child: AppButton(
                                      height: h * 0.06,
                                      border: Border.all(color: redFontColor),
                                      color: redFontColor,
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: AppString.noGoBack
                                          .regularLeagueSpartan(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  image: AppAssets.deleteAccountIcon,
                ),
                1.0.appDivider(),
                drawerListTile(
                    title: AppString.logOut,
                    fontColor: redFontColor,
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
                                padding:
                                    EdgeInsets.symmetric(horizontal: w * 0.05),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    const Spacer(),
                                    SizedBox(
                                        height: h * 0.12,
                                        width: w * 0.3,
                                        child: assetImage(
                                            AppAssets.exitAnimationAssets,
                                            fit: BoxFit.cover)),
                                    const Spacer(),
                                    Center(
                                      child: AppString.doYouWantToExit
                                          .regularLeagueSpartan(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                    ),
                                    (h * 0.01).addHSpace(),
                                    AppString
                                        .areYouSureYouReallyWantToLogOutFromyourTalkAngelAccount
                                        .regularLeagueSpartan(
                                            fontColor: greyFontColor,
                                            fontSize: 12,
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
                                                          horizontal: w * 0.08),
                                                  contentPadding:
                                                      EdgeInsets.all(w * 0.05),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
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
                                                                width: w * 0.26,
                                                                child:
                                                                    assetImage(
                                                                  AppAssets
                                                                      .sureAnimationAssets,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )),
                                                            const Spacer(),
                                                            AppString
                                                                .doYouWantToExit
                                                                .regularLeagueSpartan(
                                                                    fontColor:
                                                                        blackColor,
                                                                    fontSize:
                                                                        24,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                            AppString
                                                                .areYouSureYouReallyWantToLogOutFromYourTalkAngelAccount
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
                                                                    onTap: () {
                                                                      PreferenceManager()
                                                                          .setClearALlPref();
                                                                      Get.back();
                                                                      Get.offAllNamed(
                                                                          Routes
                                                                              .loginScreen);
                                                                    },
                                                                    child: AppString.logOut.regularLeagueSpartan(
                                                                        fontColor:
                                                                            blackColor,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                                  ),
                                                                ),
                                                                (w * 0.02)
                                                                    .addWSpace(),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AppButton(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.06,
                                                                    border: Border.all(
                                                                        color:
                                                                            redFontColor),
                                                                    color:
                                                                        redFontColor,
                                                                    onTap: () {
                                                                      Get.back();
                                                                    },
                                                                    child: AppString.cancel.regularLeagueSpartan(
                                                                        fontSize:
                                                                            14,
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
                                            child: AppString.logOut
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
                                            border:
                                                Border.all(color: redFontColor),
                                            color: redFontColor,
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
                    action: false),
              ],
            ),
          ),
        ),
      ),
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

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    log("${response.code}", name: "ERRORcode");
    log("${response.message}", name: "ERRORmessage");
    log("${response.error}", name: "ERRORerror");

    paymentFaildDialogBox(context,
        h: MediaQuery.of(context).size.height,
        w: MediaQuery.of(context).size.width,
        barrierDismissible: true,
        description: response.message);
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    log(response.data.toString(), name: "SUCCESS");

    appDialogBox(
      context,
      h: MediaQuery.of(context).size.height,
      w: MediaQuery.of(context).size.width,
      barrierDismissible: true,
    );
    setState(() {
      talkTimeController.clear();
    });
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    log(response.walletName.toString(), name: "EXTERNALWALLET");
    paymentFaildDialogBox(context,
        h: MediaQuery.of(context).size.height,
        w: MediaQuery.of(context).size.width,
        barrierDismissible: true,
        description: response.walletName);
  }
}
