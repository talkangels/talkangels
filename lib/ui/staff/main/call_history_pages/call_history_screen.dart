import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talkangels/const/app_routes.dart';
import 'package:talkangels/const/extentions.dart';
import 'package:talkangels/ui/staff/constant/app_color.dart';
import 'package:talkangels/ui/staff/constant/app_string.dart';
import 'package:talkangels/ui/staff/widgets/app_appbar.dart';
import 'package:talkangels/ui/staff/widgets/app_show_profile_pic.dart';

class CallHistoryScreen extends StatefulWidget {
  const CallHistoryScreen({Key? key}) : super(key: key);

  @override
  State<CallHistoryScreen> createState() => _CallHistoryScreenState();
}

class _CallHistoryScreenState extends State<CallHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppAppBar(
        titleText: AppString.callHistory,
        bottom: PreferredSize(
            preferredSize: const Size(300, 50), child: 1.0.appDivider()),
      ),
      body: Container(
        height: h,
        width: w,
        decoration: const BoxDecoration(gradient: appGradient),
        child: SafeArea(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.toNamed(Routes.moreCallInfoScreen);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: w * 0.05, vertical: h * 0.015),
                  child: Row(
                    children: [
                      AppShowProfilePic(
                        onTap: () {},
                        image: '',
                        borderShow: false,
                      ),
                      (w * 0.02).addWSpace(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // Icon(Icons.phone_callback),
                              // Icon(Icons.phone_missed),
                              // Icon(Icons.phone_forwarded,),
                              AppString.jenilTaylor.regularLeagueSpartan(
                                  fontWeight: FontWeight.w700),
                              (w * 0.02).addWSpace(),
                              const CircleAvatar(
                                radius: 8,
                                backgroundColor: appColorGreen,
                                // backgroundColor: appColorBlue,
                                // backgroundColor: redColor,
                                child: Icon(
                                  Icons.phone_callback,
                                  size: 10,
                                  color: whiteColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: w * 0.65,
                            child:
                                "${AppString.phoneNumbers} • ${AppString.date} • ${AppString.callTime}"
                                    .regularLeagueSpartan(
                                        fontColor: greyFontColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                        textOverflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: whiteColor.withOpacity(0.5),
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
      ),
    );
  }
}
