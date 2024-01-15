// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:talkangels/constant/app_assets.dart';
// import 'package:talkangels/constant/app_color.dart';
// import 'package:talkangels/constant/app_string.dart';
// import 'package:talkangels/utils/app_routes.dart';
// import 'package:talkangels/utils/extentions.dart';
// import 'package:talkangels/widgets/app_app_bar.dart';
// import 'package:talkangels/widgets/app_button.dart';
// import 'package:talkangels/widgets/app_show_profile_pic.dart';
//
// class PersonDetailScreen extends StatefulWidget {
//   const PersonDetailScreen({Key? key}) : super(key: key);
//
//   @override
//   State<PersonDetailScreen> createState() => _PersonDetailScreenState();
// }
//
// class _PersonDetailScreenState extends State<PersonDetailScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppAppBar(
//         leadingIcon: GestureDetector(
//             onTap: () {
//               Get.back();
//             },
//             child: const Icon(Icons.arrow_back)),
//         titleText: AppString.personDetails,
//         bottom: PreferredSize(
//           preferredSize: const Size(300, 50),
//           child: 1.0.appDivider(),
//         ),
//       ),
//       body: Container(
//         height: h,
//         width: w,
//         decoration: const BoxDecoration(gradient: appGradient),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Stack(
//                       children: [
//                         AppShowProfilePic(
//                             image: AppAssets.profiles,
//                             onTap: () {
//                               showDialog(
//                                 context: context,
//                                 builder: (_) => AlertDialog(
//                                   insetPadding: EdgeInsets.only(
//                                       left: w * 0.06, right: w * 0.3),
//                                   contentPadding: EdgeInsets.zero,
//                                   clipBehavior: Clip.antiAliasWithSaveLayer,
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10)),
//                                   content: Builder(
//                                     builder: (context) {
//                                       return Container(
//                                         padding: EdgeInsets.zero,
//                                         height: h * 0.35,
//                                         width: w * 0.9,
//                                         child: Column(
//                                           children: [
//                                             Container(
//                                               height: h * 0.29,
//                                               width: w * 0.9,
//                                               decoration: const BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.vertical(
//                                                         top: Radius.circular(
//                                                             10)),
//                                               ),
//                                               child: assetImage(
//                                                   AppAssets.profiles,
//                                                   fit: BoxFit.cover),
//                                             ),
//                                             Container(
//                                               height: h * 0.06,
//                                               width: w * 0.9,
//                                               decoration: const BoxDecoration(
//                                                 color: whiteColor,
//                                                 borderRadius:
//                                                     BorderRadius.vertical(
//                                                         bottom: Radius.circular(
//                                                             10)),
//                                               ),
//                                               child: Padding(
//                                                 padding: EdgeInsets.symmetric(
//                                                     horizontal: w * 0.03),
//                                                 child: Row(
//                                                   children: [
//                                                     InkWell(
//                                                       onTap: () {},
//                                                       child: const CircleAvatar(
//                                                         backgroundColor:
//                                                             appColorGreen,
//                                                         radius: 15,
//                                                         child: Icon(Icons.phone,
//                                                             color: whiteColor,
//                                                             size: 18),
//                                                       ),
//                                                     ),
//                                                     (w * 0.02).addWSpace(),
//                                                     AppString.talkNow
//                                                         .regularLeagueSpartan(
//                                                             fontColor:
//                                                                 appColorGreen,
//                                                             fontSize: 15,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .w900),
//                                                     const Spacer(),
//                                                     InkWell(
//                                                       onTap: () {},
//                                                       child: Container(
//                                                         height: w * 0.08,
//                                                         width: w * 0.08,
//                                                         decoration:
//                                                             BoxDecoration(
//                                                           shape:
//                                                               BoxShape.circle,
//                                                           border: Border.all(
//                                                               color:
//                                                                   greyFontColor),
//                                                         ),
//                                                         child: const Icon(
//                                                             Icons.share,
//                                                             color:
//                                                                 greyFontColor,
//                                                             size: 18),
//                                                       ),
//                                                     ),
//                                                     (w * 0.03).addWSpace(),
//                                                     InkWell(
//                                                       onTap: () {},
//                                                       child: Container(
//                                                         height: w * 0.08,
//                                                         width: w * 0.08,
//                                                         decoration:
//                                                             BoxDecoration(
//                                                           shape:
//                                                               BoxShape.circle,
//                                                           border: Border.all(
//                                                               color:
//                                                                   greyFontColor),
//                                                         ),
//                                                         child: svgAssetImage(
//                                                                 AppAssets
//                                                                     .whatsAppLogo,
//                                                                 color:
//                                                                     greyFontColor)
//                                                             .paddingAll(6),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               );
//                             },
//                             borderShow: false,
//                             radius: 70),
//                         const Positioned(
//                           right: 6,
//                           bottom: 6,
//                           child: CircleAvatar(
//                             backgroundColor: containerColor,
//                             radius: 7,
//                             child: CircleAvatar(
//                               backgroundColor: greenColor,
//                               radius: 4.5,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     (w * 0.03).addWSpace(),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         AppString.jeniliaCork.regularLeagueSpartan(
//                             fontColor: whiteColor,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w500),
//                         AppString.hazelkaur12.regularLeagueSpartan(
//                             fontColor: whiteColor.withOpacity(0.4),
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500),
//                         AppString.online.regularLeagueSpartan(
//                             fontColor: greenColor,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500),
//                       ],
//                     ),
//                     const Spacer(),
//                     InkWell(
//                       onTap: () {},
//                       child: const CircleAvatar(
//                         backgroundColor: redFontColor,
//                         radius: 17,
//                         child: Icon(Icons.share, color: whiteColor, size: 20),
//                       ),
//                     ),
//                     (w * 0.03).addWSpace(),
//                     InkWell(
//                       onTap: () {},
//                       child: CircleAvatar(
//                         backgroundColor: whiteColor,
//                         radius: 17,
//                         child: svgAssetImage(AppAssets.whatsAppLogo,
//                             color: appColorGreen, width: 20, height: 20),
//                       ),
//                     ),
//                   ],
//                 ).paddingSymmetric(horizontal: w * 0.04, vertical: h * 0.02),
//                 1.0.appDivider(),
//
//                 ///About Me
//                 detailListTile(
//                   image: const Icon(Icons.person, color: whiteColor),
//                   title: AppString.aboutMe,
//                 ),
//                 AppString.aboutMeValue
//                     .regularLeagueSpartan(
//                       fontColor: greyFontColor,
//                       fontSize: 15,
//                     )
//                     .paddingOnly(
//                       left: w * 0.04,
//                       right: w * 0.04,
//                       bottom: h * 0.015,
//                     ),
//                 1.0.appDivider(),
//
//                 /// Language
//                 detailListTile(
//                   image: const Icon(Icons.translate_sharp, color: whiteColor),
//                   title: AppString.language,
//                 ),
//                 AppString.languageValue
//                     .regularLeagueSpartan(
//                       fontColor: greyFontColor,
//                       fontSize: 15,
//                     )
//                     .paddingOnly(
//                       left: w * 0.04,
//                       right: w * 0.04,
//                       bottom: h * 0.015,
//                     ),
//                 1.0.appDivider(),
//
//                 /// Personal Detail
//                 detailListTile(
//                   image: const Icon(Icons.link, color: whiteColor),
//                   title: AppString.personalDetails,
//                 ),
//                 AppString.genderFemale
//                     .regularLeagueSpartan(
//                         fontColor: greyFontColor, fontSize: 15)
//                     .paddingOnly(
//                       left: w * 0.04,
//                       right: w * 0.04,
//                       bottom: h * 0.015,
//                     ),
//                 1.0.appDivider(),
//
//                 /// Customer Rating
//                 Row(
//                   children: [
//                     detailListTile(
//                       image: const Icon(Icons.star, color: whiteColor),
//                       title: AppString.customerRating,
//                     ),
//                     const Spacer(),
//                     AppString.rating
//                         .regularLeagueSpartan(
//                             fontColor: appColorGreen,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500)
//                         .paddingOnly(right: w * 0.04),
//                   ],
//                 ),
//                 AppString.customerRatingValue
//                     .regularLeagueSpartan(
//                         fontColor: greyFontColor, fontSize: 15)
//                     .paddingOnly(
//                       left: w * 0.04,
//                       right: w * 0.04,
//                       bottom: h * 0.015,
//                     ),
//                 1.0.appDivider(),
//
//                 /// Charges
//                 detailListTile(
//                   image: const Icon(Icons.currency_rupee, color: whiteColor),
//                   title: AppString.charges,
//                 ),
//                 AppString.chargesValue
//                     .regularLeagueSpartan(
//                       fontColor: greyFontColor,
//                       fontSize: 15,
//                     )
//                     .paddingOnly(
//                       left: w * 0.04,
//                       right: w * 0.04,
//                       bottom: h * 0.015,
//                     ),
//
//                 (h * 0.03).addHSpace(),
//                 AppButton(
//                   onTap: () {
//                     Get.toNamed(Routes.callingScreen);
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Icon(Icons.call, color: whiteColor),
//                       (w * 0.03).addWSpace(),
//                       AppString.callNow.regularLeagueSpartan(
//                           fontWeight: FontWeight.w900, fontSize: 20),
//                     ],
//                   ),
//                 ).paddingSymmetric(horizontal: w * 0.04),
//                 (h * 0.03).addHSpace(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   detailListTile({
//     required Icon image,
//     required String title,
//     Color? fontColor,
//   }) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//     return Row(
//       children: [
//         Container(
//                 height: 28,
//                 width: 28,
//                 decoration: BoxDecoration(
//                     color: textFieldColor,
//                     borderRadius: BorderRadius.circular(4)),
//                 child: image)
//             .paddingOnly(right: w * 0.03),
//         title.regularLeagueSpartan(
//             fontColor: whiteColor, fontSize: 16, fontWeight: FontWeight.w500),
//       ],
//     ).paddingOnly(
//         left: w * 0.04, right: w * 0.04, top: h * 0.015, bottom: h * 0.005);
//   }
// }

///
///
/// UPDATE

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talkangels/ui/angels/constant/app_assets.dart';
import 'package:talkangels/ui/angels/constant/app_color.dart';
import 'package:talkangels/ui/angels/constant/app_string.dart';
import 'package:talkangels/ui/angels/main/home_pages/home_screen_controller.dart';
import 'package:talkangels/const/app_routes.dart';
import 'package:talkangels/const/extentions.dart';
import 'package:talkangels/ui/angels/widgets/app_app_bar.dart';
import 'package:talkangels/ui/angels/widgets/app_button.dart';
import 'package:talkangels/ui/angels/widgets/app_show_profile_pic.dart';

class PersonDetailScreen extends StatefulWidget {
  const PersonDetailScreen({Key? key}) : super(key: key);

  @override
  State<PersonDetailScreen> createState() => _PersonDetailScreenState();
}

class _PersonDetailScreenState extends State<PersonDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppAppBar(
        leadingIcon: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back)),
        titleText: AppString.personDetails,
        bottom: PreferredSize(
          preferredSize: const Size(300, 50),
          child: 1.0.appDivider(),
        ),
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) {
          return controller.isLoading == true
              ? Container(
                  height: h,
                  width: w,
                  decoration: const BoxDecoration(gradient: appGradient),
                  child: const Center(
                      child: CircularProgressIndicator(color: Colors.white)),
                )
              : Container(
                  height: h,
                  width: w,
                  decoration: const BoxDecoration(gradient: appGradient),
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  AppShowProfilePic(
                                      image: controller.selectedAngle?.image ==
                                                  '' ||
                                              controller.selectedAngle?.image ==
                                                  null
                                          ? AppAssets.blankProfile
                                          : controller.selectedAngle!.image!,
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            insetPadding: EdgeInsets.only(
                                                left: w * 0.06, right: w * 0.3),
                                            contentPadding: EdgeInsets.zero,
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            content: Builder(
                                              builder: (context) {
                                                return Container(
                                                  padding: EdgeInsets.zero,
                                                  height: h * 0.35,
                                                  width: w * 0.9,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: h * 0.29,
                                                        width: w * 0.9,
                                                        decoration:
                                                            const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.vertical(
                                                                  top: Radius
                                                                      .circular(
                                                                          10)),
                                                        ),
                                                        child: controller
                                                                        .selectedAngle!
                                                                        .image ==
                                                                    "" ||
                                                                controller
                                                                    .selectedAngle!
                                                                    .image!
                                                                    .isEmpty
                                                            ? assetImage(
                                                                AppAssets
                                                                    .blankProfile,
                                                                fit: BoxFit
                                                                    .cover)
                                                            : Image.network(
                                                                controller
                                                                    .selectedAngle!
                                                                    .image!,
                                                                fit: BoxFit
                                                                    .cover),
                                                      ),
                                                      Container(
                                                        height: h * 0.06,
                                                        width: w * 0.9,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: whiteColor,
                                                          borderRadius:
                                                              BorderRadius.vertical(
                                                                  bottom: Radius
                                                                      .circular(
                                                                          10)),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      w * 0.03),
                                                          child: Row(
                                                            children: [
                                                              InkWell(
                                                                onTap: () {},
                                                                child:
                                                                    const CircleAvatar(
                                                                  backgroundColor:
                                                                      appColorGreen,
                                                                  radius: 15,
                                                                  child: Icon(
                                                                      Icons
                                                                          .phone,
                                                                      color:
                                                                          whiteColor,
                                                                      size: 18),
                                                                ),
                                                              ),
                                                              (w * 0.02)
                                                                  .addWSpace(),
                                                              AppString.talkNow.regularLeagueSpartan(
                                                                  fontColor:
                                                                      appColorGreen,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900),
                                                              const Spacer(),
                                                              InkWell(
                                                                onTap: () {},
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      w * 0.08,
                                                                  width:
                                                                      w * 0.08,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border: Border.all(
                                                                        color:
                                                                            greyFontColor),
                                                                  ),
                                                                  child: const Icon(
                                                                      Icons
                                                                          .share,
                                                                      color:
                                                                          greyFontColor,
                                                                      size: 18),
                                                                ),
                                                              ),
                                                              (w * 0.03)
                                                                  .addWSpace(),
                                                              InkWell(
                                                                onTap: () {},
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      w * 0.08,
                                                                  width:
                                                                      w * 0.08,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border: Border.all(
                                                                        color:
                                                                            greyFontColor),
                                                                  ),
                                                                  child: svgAssetImage(
                                                                          AppAssets
                                                                              .whatsAppLogo,
                                                                          color:
                                                                              greyFontColor)
                                                                      .paddingAll(
                                                                          6),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                      borderShow: false,
                                      radius: 70),
                                  const Positioned(
                                    right: 6,
                                    bottom: 6,
                                    child: CircleAvatar(
                                      backgroundColor: containerColor,
                                      radius: 7,
                                      child: CircleAvatar(
                                        backgroundColor: greenColor,
                                        radius: 4.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              (w * 0.03).addWSpace(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  (controller.selectedAngle!.name ?? "")
                                      .regularLeagueSpartan(
                                          fontColor: whiteColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                  (controller.selectedAngle!.userName ?? "")
                                      .regularLeagueSpartan(
                                          fontColor:
                                              whiteColor.withOpacity(0.4),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                  (controller.selectedAngle!.activeStatus ?? "")
                                      .regularLeagueSpartan(
                                          fontColor: greenColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                ],
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {},
                                child: const CircleAvatar(
                                  backgroundColor: redFontColor,
                                  radius: 17,
                                  child: Icon(Icons.share,
                                      color: whiteColor, size: 20),
                                ),
                              ),
                              (w * 0.03).addWSpace(),
                              InkWell(
                                onTap: () {},
                                child: CircleAvatar(
                                  backgroundColor: whiteColor,
                                  radius: 17,
                                  child: svgAssetImage(AppAssets.whatsAppLogo,
                                      color: appColorGreen,
                                      width: 20,
                                      height: 20),
                                ),
                              ),
                            ],
                          ).paddingSymmetric(
                              horizontal: w * 0.04, vertical: h * 0.02),
                          1.0.appDivider(),

                          ///About Me
                          detailListTile(
                            image: const Icon(Icons.person, color: whiteColor),
                            title: AppString.aboutMe,
                          ),
                          (controller.selectedAngle!.bio ?? "")
                              .regularLeagueSpartan(
                                fontColor: greyFontColor,
                                fontSize: 15,
                              )
                              .paddingOnly(
                                left: w * 0.04,
                                right: w * 0.04,
                                bottom: h * 0.015,
                              ),
                          1.0.appDivider(),

                          /// Language
                          detailListTile(
                            image: const Icon(Icons.translate_sharp,
                                color: whiteColor),
                            title: AppString.language,
                          ),
                          (controller.selectedAngle!.language ?? "")
                              .regularLeagueSpartan(
                                fontColor: greyFontColor,
                                fontSize: 15,
                              )
                              .paddingOnly(
                                left: w * 0.04,
                                right: w * 0.04,
                                bottom: h * 0.015,
                              ),
                          1.0.appDivider(),

                          /// Personal Detail
                          detailListTile(
                            image: const Icon(Icons.link, color: whiteColor),
                            title: AppString.personalDetails,
                          ),
                          ("Gender : ${controller.selectedAngle!.gender ?? ""}")
                              .regularLeagueSpartan(
                                  fontColor: greyFontColor, fontSize: 15)
                              .paddingOnly(
                                left: w * 0.04,
                                right: w * 0.04,
                                bottom: h * 0.015,
                              ),
                          1.0.appDivider(),

                          /// Customer Rating
                          Row(
                            children: [
                              detailListTile(
                                image:
                                    const Icon(Icons.star, color: whiteColor),
                                title: AppString.customerRating,
                              ),
                              const Spacer(),
                              AppString.rating
                                  .regularLeagueSpartan(
                                      fontColor: appColorGreen,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)
                                  .paddingOnly(right: w * 0.04),
                            ],
                          ),
                          AppString.customerRatingValue
                              .regularLeagueSpartan(
                                  fontColor: greyFontColor, fontSize: 15)
                              .paddingOnly(
                                left: w * 0.04,
                                right: w * 0.04,
                                bottom: h * 0.015,
                              ),
                          1.0.appDivider(),

                          /// Charges
                          detailListTile(
                            image: const Icon(Icons.currency_rupee,
                                color: whiteColor),
                            title: AppString.charges,
                          ),
                          "${controller.selectedAngle!.charges ?? ""}"
                              .regularLeagueSpartan(
                                fontColor: greyFontColor,
                                fontSize: 15,
                              )
                              .paddingOnly(
                                left: w * 0.04,
                                right: w * 0.04,
                                bottom: h * 0.015,
                              ),

                          (h * 0.03).addHSpace(),
                          AppButton(
                            onTap: () {
                              Get.toNamed(Routes.callingScreen, arguments: {
                                "selectedAngle": controller.selectedAngle,
                                "angleCallResModel":
                                    controller.angleCallResModel,
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.call, color: whiteColor),
                                (w * 0.03).addWSpace(),
                                AppString.callNow.regularLeagueSpartan(
                                    fontWeight: FontWeight.w900, fontSize: 20),
                              ],
                            ),
                          ).paddingSymmetric(horizontal: w * 0.04),
                          (h * 0.03).addHSpace(),
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }

  detailListTile({
    required Icon image,
    required String title,
    Color? fontColor,
  }) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
                height: 28,
                width: 28,
                decoration: BoxDecoration(
                    color: textFieldColor,
                    borderRadius: BorderRadius.circular(4)),
                child: image)
            .paddingOnly(right: w * 0.03),
        title.regularLeagueSpartan(
            fontColor: whiteColor, fontSize: 16, fontWeight: FontWeight.w500),
      ],
    ).paddingOnly(
        left: w * 0.04, right: w * 0.04, top: h * 0.015, bottom: h * 0.005);
  }
}
