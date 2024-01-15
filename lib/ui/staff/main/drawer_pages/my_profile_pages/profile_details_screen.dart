import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talkangels/const/app_routes.dart';
import 'package:talkangels/const/extentions.dart';
import 'package:talkangels/ui/staff/constant/app_assets.dart';
import 'package:talkangels/ui/staff/constant/app_color.dart';
import 'package:talkangels/ui/staff/constant/app_string.dart';
import 'package:talkangels/ui/staff/widgets/app_appbar.dart';
import 'package:talkangels/ui/staff/widgets/app_button.dart';
import 'package:talkangels/ui/staff/widgets/app_show_profile_pic.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppAppBar(
        titleText: AppString.profileDetails,
        bottom: PreferredSize(
            preferredSize: const Size(300, 50), child: 1.0.appDivider()),
      ),
      body: Container(
        height: h,
        width: w,
        decoration: const BoxDecoration(gradient: appGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: w * 0.04, vertical: h * 0.02),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          AppShowProfilePic(
                              image: AppAssets.profiles,
                              onTap: () {
                                // showDialog(
                                //   context: context,
                                //   builder: (_) => AlertDialog(
                                //     insetPadding: EdgeInsets.only(
                                //         left: w * 0.06, right: w * 0.3),
                                //     contentPadding: EdgeInsets.zero,
                                //     clipBehavior: Clip.antiAliasWithSaveLayer,
                                //     shape: RoundedRectangleBorder(
                                //         borderRadius: BorderRadius.circular(10)),
                                //     content: Builder(
                                //       builder: (context) {
                                //         return Container(
                                //           padding: EdgeInsets.zero,
                                //           height: h * 0.35,
                                //           width: w * 0.9,
                                //           child: Column(
                                //             children: [
                                //               Container(
                                //                 height: h * 0.29,
                                //                 width: w * 0.9,
                                //                 decoration: const BoxDecoration(
                                //                   borderRadius:
                                //                       BorderRadius.vertical(
                                //                           top: Radius.circular(
                                //                               10)),
                                //                 ),
                                //                 child: assetImage(
                                //                     AppAssets.profiles,
                                //                     fit: BoxFit.cover),
                                //               ),
                                //               Container(
                                //                 height: h * 0.06,
                                //                 width: w * 0.9,
                                //                 decoration: const BoxDecoration(
                                //                   color: whiteColor,
                                //                   borderRadius:
                                //                       BorderRadius.vertical(
                                //                           bottom: Radius.circular(
                                //                               10)),
                                //                 ),
                                //                 child: Padding(
                                //                   padding: EdgeInsets.symmetric(
                                //                       horizontal: w * 0.03),
                                //                   child: Row(
                                //                     children: [
                                //                       InkWell(
                                //                         onTap: () {},
                                //                         child: const CircleAvatar(
                                //                           backgroundColor:
                                //                               appColorGreen,
                                //                           radius: 15,
                                //                           child: Icon(Icons.phone,
                                //                               color: whiteColor,
                                //                               size: 18),
                                //                         ),
                                //                       ),
                                //                       (w * 0.02).addWSpace(),
                                //                       AppString.talkNow
                                //                           .regularLeagueSpartan(
                                //                               fontColor:
                                //                                   appColorGreen,
                                //                               fontSize: 15,
                                //                               fontWeight:
                                //                                   FontWeight
                                //                                       .w900),
                                //                       const Spacer(),
                                //                       InkWell(
                                //                         onTap: () {},
                                //                         child: Container(
                                //                           height: w * 0.08,
                                //                           width: w * 0.08,
                                //                           decoration:
                                //                               BoxDecoration(
                                //                             shape:
                                //                                 BoxShape.circle,
                                //                             border: Border.all(
                                //                                 color:
                                //                                     greyFontColor),
                                //                           ),
                                //                           child: const Icon(
                                //                               Icons.share,
                                //                               color:
                                //                                   greyFontColor,
                                //                               size: 18),
                                //                         ),
                                //                       ),
                                //                       (w * 0.03).addWSpace(),
                                //                       InkWell(
                                //                         onTap: () {},
                                //                         child: Container(
                                //                           height: w * 0.08,
                                //                           width: w * 0.08,
                                //                           decoration:
                                //                               BoxDecoration(
                                //                             shape:
                                //                                 BoxShape.circle,
                                //                             border: Border.all(
                                //                                 color:
                                //                                     greyFontColor),
                                //                           ),
                                //                           child: svgAssetImage(
                                //                                   AppAssets
                                //                                       .whatsAppLogo,
                                //                                   color:
                                //                                       greyFontColor)
                                //                               .paddingAll(6),
                                //                         ),
                                //                       ),
                                //                     ],
                                //                   ),
                                //                 ),
                                //               ),
                                //             ],
                                //           ),
                                //         );
                                //       },
                                //     ),
                                //   ),
                                // );
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
                                backgroundColor: appColorGreen,
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
                          AppString.jenilTaylor.regularLeagueSpartan(
                              fontColor: whiteColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                          AppString.jeniltaylor28.regularLeagueSpartan(
                              fontColor: whiteColor.withOpacity(0.4),
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          AppString.online.regularLeagueSpartan(
                              fontColor: appColorGreen,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {},
                        child: const CircleAvatar(
                          backgroundColor: appColorBlue,
                          radius: 17,
                          child: Icon(Icons.share, color: whiteColor, size: 20),
                        ),
                      ),
                      (w * 0.03).addWSpace(),
                      InkWell(
                        onTap: () {},
                        child: CircleAvatar(
                          backgroundColor: whiteColor,
                          radius: 17,
                          child: svgAssetImage(AppAssets.whatsAppLogo,
                              color: appColorGreen, width: 20, height: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                1.0.appDivider(),

                ///About Me
                detailListTile(
                    image: const Icon(Icons.person, color: whiteColor),
                    title: AppString.aboutMe),
                AppString.aboutMeDescription
                    .regularLeagueSpartan(
                        fontColor: greyFontColor, fontSize: 15)
                    .paddingOnly(
                        left: w * 0.05, right: w * 0.05, bottom: h * 0.02),
                1.0.appDivider(),

                /// Language
                detailListTile(
                    image: const Icon(Icons.translate_sharp, color: whiteColor),
                    title: AppString.language),
                AppString.languageDescription
                    .regularLeagueSpartan(
                        fontColor: greyFontColor, fontSize: 15)
                    .paddingOnly(
                        left: w * 0.05, right: w * 0.05, bottom: h * 0.02),
                1.0.appDivider(),

                /// Personal Detail
                detailListTile(
                    image: const Icon(Icons.link, color: whiteColor),
                    title: AppString.personalDetails),
                AppString.personalDetailsDescription
                    .regularLeagueSpartan(
                        fontColor: greyFontColor, fontSize: 15)
                    .paddingOnly(
                        left: w * 0.05, right: w * 0.05, bottom: h * 0.02),
                1.0.appDivider(),

                /// Customer Rating
                Row(
                  children: [
                    detailListTile(
                        image: const Icon(Icons.star, color: whiteColor),
                        title: AppString.customerRating),
                    const Spacer(),
                    AppString.rating
                        .regularLeagueSpartan(
                            fontColor: appColorGreen,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)
                        .paddingOnly(right: w * 0.05),
                  ],
                ),
                AppString.customerRatingDescription
                    .regularLeagueSpartan(
                        fontColor: greyFontColor, fontSize: 15)
                    .paddingOnly(
                        left: w * 0.05, right: w * 0.05, bottom: h * 0.02),
                1.0.appDivider(),

                /// Charges
                detailListTile(
                    image: const Icon(Icons.currency_rupee, color: whiteColor),
                    title: AppString.charges),
                AppString.chargesDescription
                    .regularLeagueSpartan(
                        fontColor: greyFontColor, fontSize: 15)
                    .paddingOnly(
                        left: w * 0.05, right: w * 0.05, bottom: h * 0.02),

                (h * 0.02).addHSpace(),
                AppButton(
                  onTap: () {
                    Get.toNamed(Routes.callingScreen);
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
                ).paddingSymmetric(horizontal: w * 0.05),
                (h * 0.03).addHSpace(),
              ],
            ),
          ),
        ),
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
                height: 26,
                width: 26,
                decoration: BoxDecoration(
                    color: textFieldColor,
                    borderRadius: BorderRadius.circular(4)),
                child: image)
            .paddingOnly(right: w * 0.03),
        title.regularLeagueSpartan(
            fontColor: whiteColor, fontSize: 16, fontWeight: FontWeight.w500),
      ],
    ).paddingOnly(
        left: w * 0.05, right: w * 0.05, top: h * 0.015, bottom: h * 0.005);
  }
}
