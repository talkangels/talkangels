
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talkangels/const/extentions.dart';
import 'package:talkangels/ui/staff/constant/app_color.dart';
import 'package:talkangels/ui/staff/constant/app_assets.dart';
import 'package:talkangels/ui/staff/constant/app_string.dart';

class MoreCallInfoScreen extends StatefulWidget {
  const MoreCallInfoScreen({Key? key}) : super(key: key);

  @override
  State<MoreCallInfoScreen> createState() => _MoreCallInfoScreenState();
}

class _MoreCallInfoScreenState extends State<MoreCallInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: h,
        width: w,
        decoration: const BoxDecoration(gradient: appGradient),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: h * 0.4,
                  width: w,
                  child:
                      // Icon(Icons.person, size: 150, color: greyFontColor),
                      assetImage(AppAssets.profiles, fit: BoxFit.fill),
                ),
                Positioned(
                  child: Container(
                    height: h * 0.4,
                    width: w,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFF28274C).withOpacity(0.5),
                          const Color(0xFF181831).withOpacity(0.64),
                          const Color(0xFF1C1B37),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 5,
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back, color: whiteColor),
                  ),
                ),
                Positioned(
                  bottom: h * 0.04,
                  left: w * 0.08,
                  child:
                      AppString.jenilTaylor.leagueSpartanfs20w600(fontSize: 36),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: w * 0.08, vertical: h * 0.02),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppString.phoneNumbers.regularLeagueSpartan(fontSize: 18),
                      AppString.mobileIndia.regularLeagueSpartan(
                          fontColor: greyFontColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w300),
                    ],
                  ),
                  const Spacer(),
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: appColorGreen,
                    child: Icon(
                      Icons.call,
                      color: whiteColor,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: h * 0.04,
              width: w,
              padding: EdgeInsets.only(left: w * 0.08),
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFF28274C),
                    Color(0xFF181831),
                    Color(0xFF10101C),
                  ],
                ),
              ),
              child: AppString.callHistory.regularLeagueSpartan(
                  fontColor: greyFontColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: w * 0.08, vertical: h * 0.018),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Icon(Icons.phone_callback),
                          // Icon(Icons.phone_missed),
                          // Icon(Icons.phone_forwarded,),
                          const Icon(Icons.phone_callback_rounded,
                              color: whiteColor, size: 15),
                          (w * 0.04).addWSpace(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppString.time.regularLeagueSpartan(
                                  fontWeight: FontWeight.w700),
                              (w * 0.02).addWSpace(),
                              AppString.Incomingcall1min20sec
                                  .regularLeagueSpartan(
                                      fontColor: greyFontColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w300),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return 1.0.appDivider();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
